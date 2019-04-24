#!/bin/bash
mpc clear
awk '{if ($6=="added") {sub(".*added ",""); line++; list[line]=$0}} END {for (i=line-100; i<line ;i++) {print list[i]}}' /var/lib/mpd/mpd.log |mpc add
