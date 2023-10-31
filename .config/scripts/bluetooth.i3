#!/usr/bin/env bash
# tooltip=$(bluetoothctl show)
# state=`echo "$tooltip" |grep Powered|cut -d' ' -f2`
# percentage=0
# if [[ $state == "yes" ]]; then
#     echo ""
#     echo ""
#     else
#         echo ""
#         echo ""
#     echo \#2980b9

# fi
tooltip=$(bluetoothctl devices | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Connected\|Name"|sed -e 's/\t\+//g' -e 's/Connected/    Connected/g' -e 's/Name: //g' )
out=$(echo "$tooltip"|grep "Connected: yes"|wc -l)
percentage=0 
state="no"
[[ "$out" > "0" ]] && percentage=100 && state="yes" 
    printf "%2d\n" $out
#     echo ""


case $BLOCK_BUTTON in
  1) bt 1>/dev/null;;
  3) bt-disconnect;;
esac
#echo "{\"text\": \"$state\", \"tooltip\": \"$tooltip\", \"class\": \"$state\", \"percentage\": $percentage }"|sed  ':a;N;$!ba;s/\n/\\n/g'
