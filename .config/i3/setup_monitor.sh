#!/bin/bash


PRIMARY="eDP-1"
EXT1="HDMI-2"
EXT2="DP-1"

xrandr --output $PRIMARY --primary --auto
if (xrandr | grep "$EXT1 connected"); then
    xrandr --output $EXT1 --primary --auto --right-of $PRIMARY
    echo "second screen (HDMI) enabled"
else
    xrandr --output $EXT1 --off
    echo "second screen disabled"
fi
if (xrandr | grep "$EXT2 connected"); then
    xrandr --output $EXT2 --primary --auto --right-of $EXT1
    echo "second screen (DP) enabled"
else
    xrandr --output $EXT2 --off
    echo "second screen disabled"
fi
