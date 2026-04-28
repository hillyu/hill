package models

import "time"

type WantedItem struct {
	ID           int       `json:"id"`
	Artist       string    `json:"artist"`
	Album        string    `json:"album"`
	MBID         string    `json:"mbid"`
	DownloadURL  string    `json:"download_url"`
	Status       string    `json:"status"` // "wanted", "searching", "downloading", "completed"
	AddedAt      time.Time `json:"added_at"`
	LastSearched *time.Time `json:"last_searched,omitempty"`
}
