#!/usr/bin/env bash

MPD_HOST=/home/hill/.config/mpd/socket 
#华语
# 已知固定频道
# channel=0 私人兆赫 type=e()

# Region&Lang
# channel=1 公共兆赫【地区 语言】：华语MHZ
# channel=6 公共兆赫【地区 语言】：粤语MHZ
# channel=2 公共兆赫【地区 语言】：欧美MHZ
# channel=22 公共兆赫【地区 语言】：法语MHZ
# channel=17 公共兆赫【地区 语言】：日语MHZ
# channel=18 公共兆赫【地区 语言】：韩语MHZ
# Ages
# channel=3  公共兆赫【年代】：70年代MHZ
# channel=4  公共兆赫【年代】：80年代MHZ
# channel=5  公共兆赫【年代】： 90年代MHZ
# Genre
# channel=8 公共兆赫【流派】：民谣MHZ
# channel=7 公共兆赫【流派】：摇滚MHZ
# channel=13 公共兆赫【流派】：爵士MHZ
# channel=27 公共兆赫【流派】：古典MHZ
# channel=14 公共兆赫【流派】：电子MHZ
# channel=16 公共兆赫【流派】：R&BMHZ
# channel=15 公共兆赫【流派】：说唱MHZ
# channel=10 公共兆赫【流派】：电影原声MHZ
# Special
# channel=20 公共兆赫【特辑】：女声MHZ
# channel=28 公共兆赫【特辑】：动漫MHZ
# channel=32 公共兆赫【特辑】：咖啡MHZ
# channel=67 公共兆赫【特辑】：东京事变MHZ
# Com
# channel=52 公共兆赫【品牌】：乐混翻唱MHZ
# channel=58 公共兆赫【品牌】：路虎揽胜运动MHZ
# Artist
# channel=26 公共兆赫：豆瓣音乐人MHZ
# channel=dj DJ兆赫
# URL="https://douban.fm//j/mine/playlist?type=s&sid=186609&pt=39.6&channel=1&pb=64&from=mainsite"

# URL='https://douban.fm//j/mine/playlist?type=s&sid=480884&pt=18.0&channel=8&pb=64&from=mainsite%22' 
apikey="02646d3fb69a52ff072d47bf23cef8fd"
douban_udid="b635779c65b816b13b330b68921c0f8edc049590"
channel="-10"
kbps="192"
client="s:mainsite|y:3.0"
app_name="radio_website"
version="100"
mtype="n"
URL="https://api.douban.com/v2/fm/playlist?alt=json&apikey=$apikey&app_name=$app_name&channel=$channel&client=$client&douban_udid=$douban_udid&kbps=$kbps&pt=0.0&type=$mtype&udid=b88146214e19b8a8244c9bc0e2789da68955234d&version=$version"
header='<?xml version="1.0" encoding="UTF-8"?> <playlist version="1" xmlns="http://xspf.org/ns/0/"> <trackList>'
footer='</trackList> </playlist>'
playlistfile="/home/hill/Music/douban.xspf"

#set header and curl the playlist from api "//" after hostname is important.

# curl -s "$URL" \
#     -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36' \
#     -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
#     -H 'Accept-Language: en-CA,en;q=0.9,en-GB;q=0.8,en-US;q=0.7,zh-CN;q=0.6,zh;q=0.5,ja;q=0.4,zh-TW;q=0.3' \
#     --compressed \
#     |jq -r '.song[]|[.url,.title,.length,.artist,.albumtitle,.picture]|@tsv'| awk -F$'\t' -v a="$header" -v b="$footer" 'BEGIN {print a} {gsub("&", "&amp;"); gsub("<", "&lt;");gsub(">", "&gt;"); printf "<track>  <location>%s</location> <title>%s</title> <duration>%d</duration> <creator>%s</creator> <album>%s</album>  <annotation>%s</annotation> </track>", $1, $2, $3, $4, $5, $6} END {print b}' > ~/Music/douban.xspf \
#     && mpc --host=$MPD_HOST load douban.xspf \
#     && mpc --host=$MPD_HOST playlist
IFS=$'\n'
rawlist=($(\
curl -s "$URL" \
    -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36' \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
    -H 'Accept-Language: en-CA,en;q=0.9,en-GB;q=0.8,en-US;q=0.7,zh-CN;q=0.6,zh;q=0.5,ja;q=0.4,zh-TW;q=0.3' \
    --compressed \
    |jq -r '.song[]|[.url,.title,.length,.artist,.albumtitle,.picture]|@tsv'| awk -F$'\t' '{gsub("&", "&amp;"); gsub("<", "&lt;");gsub(">", "&gt;"); printf "<track>  <location>%s</location> <title>%s</title> <duration>%d</duration> <creator>%s</creator> <album>%s</album>  <annotation>%s</annotation> </track>\n", $1, $2, $3, $4, $5, $6}'))
for line in  "${rawlist[@]}"; do
    printf "adding $(echo $line|grep -oE "<title>.*</title>")\n"
    grep -qF "$line" "$playlistfile" && printf "found dupe!\n" || printf "\$i\n$line\\n.\\nw\\n" | ex -s /home/hill/Music/douban.xspf
done \
    && mpc --host=$MPD_HOST crop \
    && mpc --host=$MPD_HOST load douban.xspf
