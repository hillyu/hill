#!/usr/bin/env bash

# Some countries below have more than one time zone,
# and it makes sense to use cities instead of countries.
# Use tzselect to find their time zones.

echo '<span size="large" face="SF Mono" weight="bold" foreground="#EEEEEE">'
time=$(TZ='America/Atikokan' date +"%H:%M")
echo 'Canada    <b>'$time'</b>'

time=$(TZ='America/California' date +"%H:%M")
echo 'California    <b>'$time'</b>'

time=$(TZ='Europe/Rome' date +"%H:%M")
echo 'Rome    <b>'$time'</b>'


time=$(TZ='Asia/Shanghai' date +'%H:%M')
echo '<span size="32768" foreground="#ccc" face="SF Pro Display" weight="semibold">China '$time'</span>'
echo '</span>'

# time=$(TZ='Asia/Shanghai' date +"%H:%M")
# echo 'China	<b>'$time'</b>'
