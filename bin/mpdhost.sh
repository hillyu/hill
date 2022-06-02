#!/usr/bin/env bash
cat $HOME/.config/mpd/hosts|rofi -dmenu -i -p "Select MPD Host:" >$HOME/tmp/MPDHOST
export MPD_HOST=$(tail -n1 $HOME/tmp/MPDHOST)
systemctl --user restart mpdmon
pkill waybar && waybar &
