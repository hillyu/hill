package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/hillyu/go-mini-arr/internal/api"
	"github.com/hillyu/go-mini-arr/internal/config"
	"github.com/hillyu/go-mini-arr/internal/db"
	"github.com/hillyu/go-mini-arr/internal/server"
	"github.com/hillyu/go-mini-arr/internal/worker"
)

func main() {
	configPath := "config.json"
	if len(os.Args) > 1 {
		configPath = os.Args[1]
	}

	cfg, err := config.LoadConfig(configPath)
	if err != nil {
		log.Fatalf("Failed to load config: %v", err)
	}

	database, err := db.InitDB(cfg.DBPath)
	if err != nil {
		log.Fatalf("Failed to init DB: %v", err)
	}

	mbClient := api.NewMusicBrainzClient()

	w := worker.NewWorker(cfg, database)
	w.Start()

	srv := &server.Server{
		DB:          database,
		MusicBrainz: mbClient,
		Worker:      w,
	}

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	r.Mount("/api", srv.Routes())

	// Serve static files from web directory
	workDir, _ := os.Getwd()
	filesDir := http.Dir(fmt.Sprintf("%s/web", workDir))
	FileServer(r, "/", filesDir)

	log.Printf("Starting server on port %d...", cfg.Port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", cfg.Port), r))
}

func FileServer(r chi.Router, path string, root http.FileSystem) {
	if path != "/" && path[len(path)-1] != '/' {
		r.Get(path, http.RedirectHandler(path+"/", http.StatusMovedPermanently).ServeHTTP)
		path += "/"
	}
	path += "*"

	r.Get(path, func(w http.ResponseWriter, r *http.Request) {
		rctx := chi.RouteContext(r.Context())
		pathPrefix := rctx.RoutePattern()
		if pathPrefix[len(pathPrefix)-2:] == "/*" {
			pathPrefix = pathPrefix[:len(pathPrefix)-2]
		}
		fs := http.StripPrefix(pathPrefix, http.FileServer(root))
		fs.ServeHTTP(w, r)
	})
}
