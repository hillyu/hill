#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import requests
from multiprocessing.dummy import Pool as ThreadPool
from mutagen.id3 import ID3, TIT2, TPE1,TPE2,APIC,ID3NoHeaderError,TALB,TCMP
#from PIL import Image
#from io import BytesIO
from lxml import html
import os.path
playlistfile="/home/hill/Music/indieshuffle.xspf"
#get latest trackid to get the playlist and dump music from this playlist
dom=html.fromstring(requests.get('http://www.indieshuffle.com/new-songs/page/1').text)
mId=dom.xpath('//div[@class="cover col-4"]/div[2]/@data-track-id')[0]
mCount=1000
url="http://www.indieshuffle.com/mobile/player?id={}&key=04ffdb11a4c54c729c743eccc46da873&count={}&page=1&type=newest&sort=order".format(mId,mCount)
# print ("start downloading from: {}\n initial track id: {}\n count: {}".format(url,mId,mCount))
tracklist=set()
resp=requests.get(url)
jsonresp= resp.json()
# print (jsonresp['posts'])
f = open(playlistfile, "r")
for line in f:
    if "<track>" in line:
            tracklist.add(line)
            # print (line)
f.close()

def dumpIt(entry):
    title=entry["title"].replace("&", "\\&amp;").replace("<", "\\&lt;").replace(">", "\\&gt;").replace('"', "\\&quot;")
    artist=entry["artist"].replace("&", "\\&amp;").replace("<", "\\&lt;").replace(">", "\\&gt;").replace('"', "\\&quot;")
    # soundcloud use two artcover size 120x120 and 500x500, indieshuffle used 120x120 by default, so replace it.
    artwork=entry["artwork"].replace("120x120", "500x500")
    if "http" in entry["source"]:
        track="<track><location>%s</location><title>%s</title><creator>%s</creator><annotation>%s</annotation></track>\n"%(entry["source"],title,artist,artwork)
        l=len(tracklist)
        tracklist.add(track)
        if len(tracklist) != l:
            print ("added new item in playlist!", track)
    return
pool =ThreadPool(5)
pool.map(dumpIt,jsonresp['posts'])
pool.close()
pool.join()


header='<?xml version="1.0" encoding="UTF-8"?><playlist version="1" xmlns="http://xspf.org/ns/0/"><trackList>\n'
footer="</trackList></playlist>"

f = open(playlistfile, "w")

# print (header,"\n".join(tracklist),footer)
content=header+"".join(tracklist)+footer
f.write(content)
f.close()
