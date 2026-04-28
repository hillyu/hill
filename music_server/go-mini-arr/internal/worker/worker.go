package worker

import (
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	"github.com/hillyu/go-mini-arr/internal/api"
	"github.com/hillyu/go-mini-arr/internal/config"
	"github.com/hillyu/go-mini-arr/internal/db"
	"github.com/hillyu/go-mini-arr/internal/models"
)

type Worker struct {
	Cfg           *config.Config
	DB            *db.Database
	Jackett       *api.JackettClient
	RDT           *api.RDTClient
	MusicBrainz   *api.MusicBrainzClient
}

func NewWorker(cfg *config.Config, database *db.Database) *Worker {
	return &Worker{
		Cfg:         cfg,
		DB:          database,
		Jackett:     api.NewJackettClient(cfg.JackettURL, cfg.JackettKey),
		RDT:         api.NewRDTClient(cfg.RDTURL, cfg.RDTUsername, cfg.RDTPassword),
		MusicBrainz: api.NewMusicBrainzClient(),
	}
}

func (w *Worker) Start() {
	interval, err := time.ParseDuration(w.Cfg.SearchInterval)
	if err != nil {
		log.Printf("Invalid search interval %s, defaulting to 1h", w.Cfg.SearchInterval)
		interval = time.Hour
	}

	ticker := time.NewTicker(interval)
	go func() {
		for {
			w.runOnce()
			<-ticker.C
		}
	}()
}

func (w *Worker) TriggerSearch() {
	go w.runOnce()
}

func (w *Worker) runOnce() {
	log.Println("--- Starting background worker pass ---")
	
	items, err := w.DB.GetWantedItems()
	if err != nil {
		log.Printf("Worker error getting items: %v", err)
		return
	}

	for _, item := range items {
		log.Printf("Processing item: %s - %s (Status: %s)", item.Artist, item.Album, item.Status)
		if item.Status == "wanted" || item.Status == "searching" {
			w.searchAndDownload(item)
		} else if item.Status == "downloading" {
			w.checkDownloadStatus(item)
		}
		time.Sleep(2 * time.Second) // Small delay between items
	}
	log.Println("--- Background worker pass finished ---")
}

func (w *Worker) checkDownloadStatus(item models.WantedItem) {
	torrents, err := w.RDT.GetTorrents()
	if err != nil {
		w.DB.LogEvent(item.ID, "RDT-Client connection error")
		return
	}

	for _, t := range torrents {
		if (t.Status == "finished" || t.Progress >= 100) && (contains(t.Filename, item.Artist) || contains(t.Filename, item.Album)) {
			w.DB.LogEvent(item.ID, fmt.Sprintf("Download finished: %s", t.Filename))
			
			destDir := fmt.Sprintf("%s/%s/%s", w.Cfg.MusicDir, item.Artist, item.Album)
			os.MkdirAll(destDir, 0755)

			sourceDir := fmt.Sprintf("%s/%s", w.Cfg.DownloadDir, t.Filename)
			if _, err := os.Stat(sourceDir); err == nil {
				w.DB.LogEvent(item.ID, "Moving folder to music library...")
				moveFiles(sourceDir, destDir)
				w.DB.UpdateStatus(item.ID, "completed")
				w.DB.LogEvent(item.ID, "Done.")
			} else {
				sourceFile := sourceDir
				if _, err := os.Stat(sourceFile); err == nil {
					w.DB.LogEvent(item.ID, "Moving file to music library...")
					os.Rename(sourceFile, destDir+"/"+t.Filename)
					w.DB.UpdateStatus(item.ID, "completed")
					w.DB.LogEvent(item.ID, "Done.")
				}
			}
		}
	}
}

func contains(s, substr string) bool {
	return strings.Contains(strings.ToLower(s), strings.ToLower(substr))
}

func moveFiles(src, dst string) error {
	files, err := os.ReadDir(src)
	if err != nil {
		return err
	}
	for _, f := range files {
		os.Rename(src+"/"+f.Name(), dst+"/"+f.Name())
	}
	return nil
}

func (w *Worker) searchAndDownload(item models.WantedItem) {
	if item.DownloadURL != "" {
		w.DB.LogEvent(item.ID, "Using manual download override.")
		w.pushToRDT(item, item.DownloadURL, "Manual Selection")
		return
	}

	artist := strings.ReplaceAll(item.Artist, ".", " ")
	album := strings.ReplaceAll(item.Album, ".", " ")
	query := strings.TrimSpace(artist + " " + album)
	
	w.DB.LogEvent(item.ID, fmt.Sprintf("Searching Jackett for: %s", query))
	
	results, err := w.Jackett.Search(query)
	if err != nil {
		w.DB.LogEvent(item.ID, fmt.Sprintf("Jackett error: %v", err))
		return
	}

	if len(results) == 0 {
		w.DB.LogEvent(item.ID, "No results found on this pass.")
		w.DB.UpdateStatus(item.ID, "searching")
		w.DB.UpdateLastSearched(item.ID)
		return
	}

	// Filter and Rank
	best := w.pickBest(item.ID, results)
	if best == nil {
		w.DB.LogEvent(item.ID, "No results met quality requirements (DSD/FLAC, no MP3).")
		w.DB.UpdateStatus(item.ID, "searching")
		return
	}

	w.pushToRDT(item, best.Link, best.Title)
}

func (w *Worker) pushToRDT(item models.WantedItem, link string, title string) {
	w.DB.LogEvent(item.ID, fmt.Sprintf("Found match: %s. Sending to RDT-Client...", title))
	
	err := w.RDT.AddMagnet(link)
	if err != nil {
		w.DB.LogEvent(item.ID, fmt.Sprintf("RDT-Client error: %v", err))
		return
	}

	w.DB.UpdateStatus(item.ID, "downloading")
	w.DB.LogEvent(item.ID, "Submitted to RDT-Client.")
}

func (w *Worker) pickBest(wantedID int, results []api.TorznabItem) *api.TorznabItem {
	type rankedItem struct {
		item api.TorznabItem
		rank int // 1: DSD/DSF, 2: FLAC/Lossless, 0: Reject
	}

	var ranked []rankedItem
	for _, r := range results {
		title := strings.ToLower(r.Title)
		
		// 1. Reject MP3s
		if strings.Contains(title, "mp3") || strings.Contains(title, "320kbps") {
			continue
		}

		rank := 0
		if strings.Contains(title, "dsd") || strings.Contains(title, "dsf") {
			rank = 1
		} else if strings.Contains(title, "flac") || strings.Contains(title, "lossless") {
			rank = 2
		}

		if rank > 0 {
			ranked = append(ranked, rankedItem{r, rank})
		}
	}

	if len(ranked) == 0 {
		return nil
	}

	// Simple sort: Rank 1 first, then Rank 2. Within ranks, pick the one with most seeders (simplified: just take first in rank)
	// Actually, let's just pick the first Rank 1, if none, then first Rank 2.
	for _, r := range ranked {
		if r.rank == 1 {
			return &r.item
		}
	}
	for _, r := range ranked {
		if r.rank == 2 {
			return &r.item
		}
	}

	return nil
}
