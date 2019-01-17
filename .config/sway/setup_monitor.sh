#!/bin/bash
for i in $(swaymsg -t get_outputs |jq -r '.[]|.name'); do
    echo $i
    w_str='.[]|select(.name =='\""$i"\"')|.modes|.[-1]|.width'
    width=$(swaymsg -t get_outputs |jq -r "$w_str")
    height=$(swaymsg -t get_outputs |jq -r '.[]|select(.name =='\""$i"\"')|.modes|.[-1]|.height')
    refresh=$(swaymsg -t get_outputs |jq -r '.[]|select(.name =='\""$i"\"')|.modes|.[-1]|.refresh') 
    (( refresh /= 1000))
    swaymsg output $i mode "$width"x"$height"@"$refresh"Hz
done

