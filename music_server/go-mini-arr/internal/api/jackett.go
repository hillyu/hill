package api

import (
	"encoding/xml"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"strings"
)

type JackettClient struct {
	BaseURL string
	APIKey  string
}

func NewJackettClient(baseURL, apiKey string) *JackettClient {
	return &JackettClient{
		BaseURL: baseURL,
		APIKey:  apiKey,
	}
}

type TorznabRss struct {
	Channel struct {
		Items []TorznabItem `xml:"item"`
	} `xml:"channel"`
}

type TorznabItem struct {
	Title       string `xml:"title" json:"title"`
	Description string `xml:"description" json:"description"`
	Link        string `xml:"link" json:"link"`
	Guid        string `xml:"guid" json:"guid"`
	Size        int64  `xml:"size" json:"size"`
	Enclosure   struct {
		URL    string `xml:"url,attr" json:"url"`
		Length int64  `xml:"length,attr" json:"length"`
	} `xml:"enclosure" json:"enclosure"`
	Attrs []struct {
		Name  string `xml:"name,attr" json:"name"`
		Value string `xml:"value,attr" json:"value"`
	} `xml:"attr" json:"attrs"`
	Indexer string `xml:"jackettindexer" json:"indexer"`
}

func (c *JackettClient) Search(query string) ([]TorznabItem, error) {
	u, err := url.Parse(c.BaseURL + "/api/v2.0/indexers/all/results/torznab")
	if err != nil {
		return nil, err
	}

	q := u.Query()
	q.Set("apikey", c.APIKey)
	q.Set("t", "search")
	q.Set("cat", "3000") // Limit to Audio category
	q.Set("q", query)
	u.RawQuery = q.Encode()

	resp, err := http.Get(u.String())
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("jackett returned status %d", resp.StatusCode)
	}

	body, _ := io.ReadAll(resp.Body)
	// log.Printf("Jackett XML Response: %s", string(body))

	var rss TorznabRss
	if err := xml.Unmarshal(body, &rss); err != nil {
		return nil, err
	}

	for i := range rss.Channel.Items {
		item := &rss.Channel.Items[i]
		
		// 1. Fallback for Title
		if item.Title == "" {
			item.Title = item.Description
		}
		
		// 2. Fallback for Size
		if item.Size == 0 {
			item.Size = item.Enclosure.Length
		}

		// 3. Robust Link Extraction
		magnet := ""
		for _, attr := range item.Attrs {
			if attr.Name == "magneturl" {
				magnet = attr.Value
				break
			}
		}

		if magnet != "" {
			item.Link = magnet
		} else if strings.HasPrefix(item.Guid, "http") || strings.HasPrefix(item.Guid, "magnet:") {
			item.Link = item.Guid
		} else if item.Link == "" && item.Enclosure.URL != "" {
			item.Link = item.Enclosure.URL
		}

		// 4. Rewrite internal hostname for download links
		if strings.Contains(item.Link, "http://jackett:9117") {
			item.Link = strings.Replace(item.Link, "http://jackett:9117", "http://192.168.8.2:9117", 1)
		}
		
		seeders := ""
		peers := ""
		for _, attr := range item.Attrs {
			if attr.Name == "seeders" {
				seeders = attr.Value
			}
			if attr.Name == "peers" {
				peers = attr.Value
			}
		}

		log.Printf("RESULT [%d]: Title='%s', Size=%d, Link='%s', Seeders=%s, Peers=%s, Indexer=%s", i, item.Title, item.Size, item.Link, seeders, peers, item.Indexer)
	}

	return rss.Channel.Items, nil
}
