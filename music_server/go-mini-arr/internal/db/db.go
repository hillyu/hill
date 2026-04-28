package db

import (
	"database/sql"
	"fmt"
	"time"

	"github.com/hillyu/go-mini-arr/internal/models"
	_ "modernc.org/sqlite"
)

type Database struct {
	conn *sql.DB
}

func InitDB(path string) (*Database, error) {
	db, err := sql.Open("sqlite", path)
	if err != nil {
		return nil, err
	}

	schema := `
	CREATE TABLE IF NOT EXISTS wanted_albums (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		artist TEXT NOT NULL,
		album TEXT NOT NULL,
		mbid TEXT,
		download_url TEXT,
		status TEXT NOT NULL,
		added_at DATETIME NOT NULL,
		last_searched DATETIME
	);
	CREATE TABLE IF NOT EXISTS events (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		wanted_id INTEGER,
		message TEXT NOT NULL,
		created_at DATETIME NOT NULL,
		FOREIGN KEY(wanted_id) REFERENCES wanted_albums(id) ON DELETE CASCADE
	);`

	if _, err := db.Exec(schema); err != nil {
		return nil, err
	}

	return &Database{conn: db}, nil
}

func (db *Database) LogEvent(wantedID int, message string) error {
	_, err := db.conn.Exec("INSERT INTO events (wanted_id, message, created_at) VALUES (?, ?, ?)", wantedID, message, time.Now())
	return err
}

func (db *Database) GetEvents(wantedID int) ([]string, error) {
	rows, err := db.conn.Query("SELECT message, created_at FROM events WHERE wanted_id = ? ORDER BY created_at DESC LIMIT 10", wantedID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var events []string
	for rows.Next() {
		var msg string
		var t time.Time
		if err := rows.Scan(&msg, &t); err != nil {
			return nil, err
		}
		events = append(events, fmt.Sprintf("[%s] %s", t.Format("15:04:05"), msg))
	}
	return events, nil
}

func (db *Database) AddWantedItem(item models.WantedItem) error {
	_, err := db.conn.Exec(
		"INSERT INTO wanted_albums (artist, album, mbid, download_url, status, added_at) VALUES (?, ?, ?, ?, ?, ?)",
		item.Artist, item.Album, item.MBID, item.DownloadURL, item.Status, time.Now(),
	)
	return err
}

func (db *Database) GetWantedItems() ([]models.WantedItem, error) {
	rows, err := db.conn.Query("SELECT id, artist, album, mbid, download_url, status, added_at, last_searched FROM wanted_albums")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var items []models.WantedItem
	for rows.Next() {
		var item models.WantedItem
		var lastSearched sql.NullTime
		var downloadUrl sql.NullString
		err := rows.Scan(&item.ID, &item.Artist, &item.Album, &item.MBID, &downloadUrl, &item.Status, &item.AddedAt, &lastSearched)
		if err != nil {
			return nil, err
		}
		if downloadUrl.Valid {
			item.DownloadURL = downloadUrl.String
		}
		if lastSearched.Valid {
			item.LastSearched = &lastSearched.Time
		}
		items = append(items, item)
	}
	return items, nil
}

func (db *Database) UpdateDownloadURL(id int, url string) error {
	_, err := db.conn.Exec("UPDATE wanted_albums SET download_url = ?, status = 'searching' WHERE id = ?", url, id)
	return err
}

func (db *Database) GetWantedItem(id int) (*models.WantedItem, error) {
	row := db.conn.QueryRow("SELECT id, artist, album, mbid, download_url, status, added_at, last_searched FROM wanted_albums WHERE id = ?", id)
	var item models.WantedItem
	var lastSearched sql.NullTime
	var downloadUrl sql.NullString
	err := row.Scan(&item.ID, &item.Artist, &item.Album, &item.MBID, &downloadUrl, &item.Status, &item.AddedAt, &lastSearched)
	if err != nil {
		return nil, err
	}
	if downloadUrl.Valid {
		item.DownloadURL = downloadUrl.String
	}
	if lastSearched.Valid {
		item.LastSearched = &lastSearched.Time
	}
	return &item, nil
}

func (db *Database) UpdateStatus(id int, status string) error {
	_, err := db.conn.Exec("UPDATE wanted_albums SET status = ? WHERE id = ?", status, id)
	return err
}

func (db *Database) UpdateLastSearched(id int) error {
	_, err := db.conn.Exec("UPDATE wanted_albums SET last_searched = ? WHERE id = ?", time.Now(), id)
	return err
}

func (db *Database) DeleteWantedItem(id int) error {
	_, err := db.conn.Exec("DELETE FROM wanted_albums WHERE id = ?", id)
	return err
}
