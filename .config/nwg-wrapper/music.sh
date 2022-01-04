#!/usr/bin/env bash

title="Systemd Timers:"
color="$(fgcolor.sh  417x162+61+360)"
cmd="mpc -h $MPD_HOST"
textfont="Hard Gothic"
titlefont="c059"
MPD_HOST=$(tail -n1 $HOME/tmp/MPDHOST)

mpc -h $MPD_HOST|head -n1|grep -q "volume" && exit 0
title=`mpc -h $MPD_HOST -f "%title%"|head -n1|awk '{gsub("&", "&amp;"); gsub("<", "&lt;");gsub(">", "&gt;");gsub("\"", ""); print $0}'|fold -w 40 -s`
artist=`mpc -h $MPD_HOST -f "%artist%"|head -n1|awk '{gsub("&", "&amp;"); gsub("<", "&lt;");gsub(">", "&gt;");gsub("\"", ""); print $0}'|fold -w 60 -s`
album=`mpc -h $MPD_HOST -f "%album%"|head -n1|awk '{gsub("&", "&amp;"); gsub("<", "&lt;");gsub(">", "&gt;");gsub("\"", ""); print $0}'|fold -w 80 -s`

# fontsize="11pt"
# source ~/.config/nwg-wrapper/termout.sh

cat - << DOC
<span foreground="$color" font_family="$titlefont" style="oblique" size="24pt">${title}</span>

<span foreground="$color" font_family="$titlefont" style="oblique" size="x-large">$album</span>

<span foreground="$color" font_family="$textfont"  weight="bold" >$artist</span>
DOC
