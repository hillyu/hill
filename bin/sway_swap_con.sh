#!/usr/bin/env bash
arr=($(swaymsg -t get_tree | jq -r 'path(..|try select(.focused == true))'|grep -oE "[[:digit:]]+"))
# swaymsg -t get_tree | jq -r 'path(..|try select(.focused == true))'|grep -oE "[[:digit:]]+"|tr '\n' ' ' |read a b rest
a=${arr[0]}
b=${arr[1]}
echo $a $b
id=`swaymsg -t get_tree |jq ".nodes[$a]|.nodes[$b]|.nodes[0]|.id"`
echo $id
swaymsg swap container with con_id $id

