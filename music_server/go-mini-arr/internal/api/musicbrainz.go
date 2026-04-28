package api

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
)

type MusicBrainzClient struct {
	BaseURL string
}

func NewMusicBrainzClient() *MusicBrainzClient {
	return &MusicBrainzClient{
		BaseURL: "https://musicbrainz.org/ws/2",
	}
}

type MBRelease struct {
	ID    string `json:"id"`
	Title string `json:"title"`
	Date  string `json:"date"`
	Country string `json:"country"`
	Status  string `json:"status"`
	ArtistCredit []struct {
		Artist struct {
			Name string `json:"name"`
		} `json:"artist"`
	} `json:"artist-credit"`
}

type MBReleaseResponse struct {
	Releases []MBRelease `json:"releases"`
}

func (c *MusicBrainzClient) SearchReleases(artist, album string) ([]MBRelease, error) {
	query := fmt.Sprintf("artist:\"%s\" AND release:\"%s\"", artist, album)
	if album == "" {
		query = fmt.Sprintf("artist:\"%s\"", artist)
	}

	u, _ := url.Parse(c.BaseURL + "/release")
	q := u.Query()
	q.Set("query", query)
	q.Set("fmt", "json")
	u.RawQuery = q.Encode()

	req, _ := http.NewRequest("GET", u.String(), nil)
	req.Header.Set("User-Agent", "Go-Mini-Arr/0.1.0 ( mail@example.com )") // MusicBrainz requires a descriptive User-Agent

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("musicbrainz returned status %d", resp.StatusCode)
	}

	var data MBReleaseResponse
	if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
		return nil, err
	}

	return data.Releases, nil
}
