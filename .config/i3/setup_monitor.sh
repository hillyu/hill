#!/bin/bash


#PRIMARY="eDP-1"
PRIMARY="eDP1"
EXT2="HDMI2"
#EXT1="HDMI-2"
#EXT2="DP-1"
EXT1="DP1"
INFO=$(xrandr)

xrandr --output $PRIMARY --primary --auto
if (echo "$INFO" | grep "^$EXT1 connected"); then
    xrandr --output $EXT1 --primary --auto --right-of $PRIMARY --rotate left
    echo "second screen (HDMI) enabled"
else
    xrandr --output $EXT1 --off
    echo "second screen (HDMI) disabled"
fi
if (echo "$INFO" | grep "^$EXT2 connected"); then
    if (echo "$INFO" | grep "^$EXT1 connected"); then
        xrandr --output $EXT2  --auto --right-of $EXT1
        echo "third screen (DP) enabled"
    else
        xrandr --output $EXT2 --primary --auto --right-of $PRIMARY
        echo "second screen (DP) enabled"
    fi
else
    xrandr --output $EXT2 --off
    echo "second screen (DP) disabled"
fi
feh --bg-fill ~/Pictures/wallpapers/lake.png
