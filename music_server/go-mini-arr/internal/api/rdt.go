package api

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"mime/multipart"
	"net/http"
	"net/http/cookiejar"
	"net/url"
	"strings"
)

type RDTClient struct {
	BaseURL  string
	Username string
	Password string
	Client   *http.Client
}

func NewRDTClient(baseURL, username, password string) *RDTClient {
	jar, _ := cookiejar.New(nil)
	return &RDTClient{
		BaseURL:  baseURL,
		Username: username,
		Password: password,
		Client:   &http.Client{Jar: jar},
	}
}

type RDTTorrent struct {
	Hash     string  `json:"hash"`
	Name     string  `json:"name"`
	Status   string  `json:"state"` // qBittorrent uses 'state'
	Progress float64 `json:"progress"`
}

// Map qBittorrent fields to our internal struct
func (t RDTTorrent) ToInternal() RDTTorrentInternal {
	status := "downloading"
	if t.Progress >= 1 || t.Status == "uploading" || t.Status == "stalledUP" || t.Status == "queuedUP" {
		status = "finished"
	}
	return RDTTorrentInternal{
		Id:       t.Hash,
		Filename: t.Name,
		Status:   status,
		Progress: t.Progress * 100,
	}
}

type RDTTorrentInternal struct {
	Id       string  `json:"id"`
	Filename string  `json:"filename"`
	Status   string  `json:"status"`
	Progress float64 `json:"progress"`
}

func (c *RDTClient) Login() error {
	u, _ := url.Parse(c.BaseURL + "/api/v2/auth/login")
	data := url.Values{}
	data.Set("username", c.Username)
	data.Set("password", c.Password)

	resp, err := c.Client.PostForm(u.String(), data)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("login failed with status %d", resp.StatusCode)
	}

	return nil
}

func (c *RDTClient) AddMagnet(link string) error {
	log.Printf("DEBUG [AddMagnet START] link: '%s'", link)
	// Ensure we are logged in
	if err := c.Login(); err != nil {
		log.Printf("DEBUG [AddMagnet] Login failed: %v", err)
		return err
	}

	link = strings.TrimSpace(link)
	log.Printf("DEBUG [AddMagnet] trimmed link: '%s'", link)

	if strings.HasPrefix(strings.ToLower(link), "magnet:") {
		log.Printf("DEBUG [AddMagnet] matches magnet: prefix, calling addUrl")
		return c.addUrl(link)
	}

	log.Printf("DEBUG [AddMagnet] NOT a magnet, calling http.Get on link")
	
	// Custom client to catch magnet redirects
	client := &http.Client{
		CheckRedirect: func(req *http.Request, via []*http.Request) error {
			if strings.HasPrefix(strings.ToLower(req.URL.String()), "magnet:") {
				return http.ErrUseLastResponse // Stop here, we'll handle the magnet manually
			}
			return nil
		},
	}

	resp, err := client.Get(link)
	if err != nil {
		log.Printf("DEBUG [AddMagnet] http.Get failed: %v", err)
		return fmt.Errorf("failed to download torrent from jackett: %v", err)
	}
	defer resp.Body.Close()

	// Check if we were redirected to a magnet
	loc := resp.Header.Get("Location")
	if strings.HasPrefix(strings.ToLower(loc), "magnet:") {
		log.Printf("DEBUG [AddMagnet] Redirected to magnet, calling addUrl")
		return c.addUrl(loc)
	}

	log.Printf("DEBUG [AddMagnet] http.Get status: %d", resp.StatusCode)
	
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("jackett download returned %d", resp.StatusCode)
	}
	
	torrentData, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}
	log.Printf("DEBUG [AddMagnet] read %d bytes of torrent data", len(torrentData))

	var filename string = "download.torrent"
	cd := resp.Header.Get("Content-Disposition")
	if strings.Contains(cd, "filename=") {
		parts := strings.Split(cd, "filename=")
		filename = strings.Trim(parts[1], "\"")
	}
	log.Printf("DEBUG [AddMagnet] using filename: %s", filename)

	u, _ := url.Parse(c.BaseURL + "/api/v2/torrents/add")
	
	var b bytes.Buffer
	w := multipart.NewWriter(&b)
	
	part, err := w.CreateFormFile("torrents", filename)
	if err != nil {
		return err
	}
	part.Write(torrentData)
	w.Close()

	req, err := http.NewRequest("POST", u.String(), &b)
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", w.FormDataContentType())

	log.Printf("DEBUG [AddMagnet] sending POST to %s with multipart data", u.String())
	resp2, err := c.Client.Do(req)
	if err != nil {
		log.Printf("DEBUG [AddMagnet] POST failed: %v", err)
		return err
	}
	defer resp2.Body.Close()
	log.Printf("DEBUG [AddMagnet] POST status: %d", resp2.StatusCode)

	if resp2.StatusCode != http.StatusOK {
		return fmt.Errorf("add torrent file failed with status %d", resp2.StatusCode)
	}

	return nil
}

func (c *RDTClient) addUrl(urlStr string) error {
	u, _ := url.Parse(c.BaseURL + "/api/v2/torrents/add")
	
	var b bytes.Buffer
	w := multipart.NewWriter(&b)
	
	fw, err := w.CreateFormField("urls")
	if err != nil {
		return err
	}
	fw.Write([]byte(urlStr))
	w.Close()

	req, err := http.NewRequest("POST", u.String(), &b)
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", w.FormDataContentType())

	resp, err := c.Client.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("add torrent url failed with status %d", resp.StatusCode)
	}
	return nil
}

func (c *RDTClient) GetTorrents() ([]RDTTorrentInternal, error) {
	if err := c.Login(); err != nil {
		return nil, err
	}

	u, _ := url.Parse(c.BaseURL + "/api/v2/torrents/info")
	resp, err := c.Client.Get(u.String())
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("get torrents failed with status %d", resp.StatusCode)
	}

	var qTorrents []RDTTorrent
	if err := json.NewDecoder(resp.Body).Decode(&qTorrents); err != nil {
		return nil, err
	}

	var torrents []RDTTorrentInternal
	for _, t := range qTorrents {
		torrents = append(torrents, t.ToInternal())
	}

	return torrents, nil
}
