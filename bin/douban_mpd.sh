#!/usr/bin/env bash

MPD_HOST=/home/hill/.config/mpd/socket 
#华语
# URL="https://douban.fm//j/mine/playlist?type=s&sid=186609&pt=39.6&channel=1&pb=64&from=mainsite"

URL='https://douban.fm//j/mine/playlist?type=s&sid=480884&pt=18.0&channel=8&pb=64&from=mainsite%22' 
header='<?xml version="1.0" encoding="UTF-8"?> <playlist version="1" xmlns="http://xspf.org/ns/0/"> <trackList>'
footer='</trackList> </playlist>'

#set header and curl the playlist from api "//" after hostname is important.
curl -s "$URL" \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
    -H 'Accept-Language: en-CA,en;q=0.9,en-GB;q=0.8,en-US;q=0.7,zh-CN;q=0.6,zh;q=0.5,ja;q=0.4,zh-TW;q=0.3' \
    --compressed \
    |jq -r '.song[]|[.url,.title,.length,.artist,.albumtitle,.picture]|@tsv'| awk -F$'\t' -v a="$header" -v b="$footer" 'BEGIN {print a} {gsub("&", "&amp;"); gsub("<", "&lt;");gsub(">", "&gt;"); printf "<track>  <location>%s</location> <title>%s</title> <duration>%d</duration> <creator>%s</creator> <album>%s</album>  <image>%s</image> </track>", $1, $2, $3, $4, $5, $6} END {print b}' > ~/Music/douban.xspf \
    && mpc --host=$MPD_HOST load douban.xspf \
    && mpc --host=$MPD_HOST playlist
    #|jq -r '.song[]|[.title,.url,.singers[].name,.picture]|@tsv' 
    #|jq -r '.song[]|[.title,.url,.singers[].name,.picture]|@tsv'| awk -F$'\t' 'BEGIN {print "#EXTM3U\n"} {print "#EXTINF:-1, " $3 " - " $1 "\n" $2}' >  ~/.config/mpd/playlists/douban.m3u \
    #|jq -r '.song[]|[.title,.url,.singers[].name,.picture]|@tsv'| awk -F$'\t' '{print "#EXTINF:-1, " $3 " - " $1 "\n" $2}' >>  ~/.config/mpd/playlists/douban.m3u \
