package server

import (
	"encoding/json"
	"net/http"
	"strconv"
	"strings"

	"github.com/go-chi/chi/v5"
	"github.com/hillyu/go-mini-arr/internal/api"
	"github.com/hillyu/go-mini-arr/internal/db"
	"github.com/hillyu/go-mini-arr/internal/models"
	"github.com/hillyu/go-mini-arr/internal/worker"
)

type Server struct {
	DB          *db.Database
	MusicBrainz *api.MusicBrainzClient
	Worker      *worker.Worker
}

func (s *Server) Routes() chi.Router {
	r := chi.NewRouter()

	r.Get("/search", s.HandleSearch)
	r.Get("/wanted", s.HandleListWanted)
	r.Post("/wanted", s.HandleAddWanted)
	r.Get("/wanted/{id}/torrents", s.HandleSearchTorrents)
	r.Put("/wanted/{id}/download", s.HandleUpdateDownload)
	r.Post("/search/now", s.HandleSearchNow)
	r.Get("/wanted/{id}/events", s.HandleGetEvents)
	r.Delete("/wanted/{id}", s.HandleDeleteWanted)

	return r
}

func (s *Server) HandleSearchNow(w http.ResponseWriter, r *http.Request) {
	s.Worker.TriggerSearch()
	w.WriteHeader(http.StatusAccepted)
}

func (s *Server) HandleGetEvents(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	events, err := s.DB.GetEvents(id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	json.NewEncoder(w).Encode(events)
}

func (s *Server) HandleSearch(w http.ResponseWriter, r *http.Request) {
	artist := r.URL.Query().Get("artist")
	album := r.URL.Query().Get("album")

	results, err := s.MusicBrainz.SearchReleases(artist, album)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(results)
}

func (s *Server) HandleSearchTorrents(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	item, err := s.DB.GetWantedItem(id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	artist := strings.ReplaceAll(item.Artist, ".", " ")
	album := strings.ReplaceAll(item.Album, ".", " ")
	query := strings.TrimSpace(artist + " " + album)

	results, err := s.Worker.Jackett.Search(query)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(results)
}

func (s *Server) HandleUpdateDownload(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	var body struct {
		URL string `json:"url"`
	}
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	if err := s.DB.UpdateDownloadURL(id, body.URL); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	s.Worker.TriggerSearch()
	w.WriteHeader(http.StatusAccepted)
}

func (s *Server) HandleListWanted(w http.ResponseWriter, r *http.Request) {
	items, err := s.DB.GetWantedItems()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	json.NewEncoder(w).Encode(items)
}

func (s *Server) HandleAddWanted(w http.ResponseWriter, r *http.Request) {
	var item models.WantedItem
	if err := json.NewDecoder(r.Body).Decode(&item); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	item.Status = "wanted"
	if err := s.DB.AddWantedItem(item); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	s.Worker.TriggerSearch()
	w.WriteHeader(http.StatusCreated)
}

func (s *Server) HandleDeleteWanted(w http.ResponseWriter, r *http.Request) {
	idStr := chi.URLParam(r, "id")
	id, _ := strconv.Atoi(idStr)

	if err := s.DB.DeleteWantedItem(id); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}
