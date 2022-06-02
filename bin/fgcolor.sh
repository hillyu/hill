#!/usr/bin/env bash
# caculate average color of background and select color for fg
wallpaper=$(tail -n1 $HOME/.cache/wallpaper.log)
geometry=${1:-100%}
f=${2:-$wallpaper}
dark=#202124
light="$eee"
hex=$(convert $wallpaper -gravity SouthWest -crop $geometry -resize 1x1\! -format "%[pixel:p{0,0}]" txt:- |grep -oE "\#[0-9A-Fa-f]+")
read a b c <<<$(printf "%d %d %d\n" 0x${hex:1:2} 0x${hex:3:2} 0x${hex:5:2})
# echo $hex
# echo "$a $b $c"
brightness=$(echo "$a*0.2126 + $b*0.7152 + $c*0.0722" |bc)
# echo $brightness
# printf '#%x%x%x' $(bc <<< "255-${a/.*}") $(bc <<< "255-${b/.*}") $(bc <<< "255-${c/.*}")
[ ${brightness/.*} -lt 140 ] && echo "#eee" || echo "$dark"

