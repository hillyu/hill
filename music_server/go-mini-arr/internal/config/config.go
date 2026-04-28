package config

import (
	"encoding/json"
	"os"
)

type Config struct {
	Port           int    `json:"port"`
	MusicDir       string `json:"music_dir"`
	DownloadDir    string `json:"download_dir"`
	JackettURL     string `json:"jackett_url"`
	JackettKey     string `json:"jackett_key"`
	RDTURL         string `json:"rdt_url"`
	RDTKey         string `json:"rdt_key"`
	RDTUsername    string `json:"rdt_username"`
	RDTPassword    string `json:"rdt_password"`
	SearchInterval string `json:"search_interval"` // e.g., "1h"
	DBPath         string `json:"db_path"`
}

func LoadConfig(path string) (*Config, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var cfg Config
	decoder := json.NewDecoder(file)
	if err := decoder.Decode(&cfg); err != nil {
		return nil, err
	}

	if cfg.Port == 0 {
		cfg.Port = 8080
	}
	if cfg.DBPath == "" {
		cfg.DBPath = "mini-arr.db"
	}
	if cfg.SearchInterval == "" {
		cfg.SearchInterval = "1h"
	}

	return &cfg, nil
}
