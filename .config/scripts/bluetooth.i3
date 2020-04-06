#!/usr/bin/env bash
tooltip=$(bluetoothctl show)
state=`echo "$tooltip" |grep Powered|cut -d' ' -f2`
percentage=0
if [[ $state == "yes" ]]; then
    echo ""
    echo ""
    else
        echo ""
        echo ""
    echo \#2980b9

fi

case $BLOCK_BUTTON in
  1) bt 1>/dev/null;;
  3) bt-disconnect;;
esac
#echo "{\"text\": \"$state\", \"tooltip\": \"$tooltip\", \"class\": \"$state\", \"percentage\": $percentage }"|sed  ':a;N;$!ba;s/\n/\\n/g'
