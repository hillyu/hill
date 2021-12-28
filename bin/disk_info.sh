#!/usr/bin/env bash
lsblk
echo -e "================================================"
df -h -xoverlay -xtmpfs
echo -e "================================================"
echo "Temp dirs:"
du -sh /tmp /var ~/tmp ~/.cache 2>/dev/null
echo -e "================================================"
echo "Big dirs:"
du -sh --time --time-style +%D ~/* 2>/dev/null |sort -h -r |head -8
