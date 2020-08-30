#!/usr/bin/env bash
sensor=`sensors -j 2>/dev/null`
cpu=`echo "$sensor" | jq '.["k10temp-pci-00c3"]|.["Tctl"]|.["temp1_input"]'`
# gpu=`echo "$sensor" | jq '.["amdgpu-pci-0300"]|.["edge"]|.["temp1_input"]'`
cpu=${cpu%.*}
gpu=${gpu%.*}
class="cool"
#echo  "C/G:$cpu/$gpu °C"
echo  "$cpu °C"
#echo  "$cpu/$gpu °C"
echo  "$cpu °C"
if [[ $cpu -gt 50 ]]; then
    class="normal"
    echo  \#FFFC00
    elif [[ $cpu -gt 60 ]]; then
        class="critical"
        echo \#FF0000
fi
#[[ $BLOCK_BUTTON = "1" ]] && notify-send -i temperature "Sensors:" "`sensors`"
[[ $BLOCK_BUTTON = "1" ]] && st  -c prompt -g 70x40 bash -c "watch -n 1 sensors"
[[ $BLOCK_BUTTON = "3" ]] && st  -c prompt -g 70x40 bash -c "sudo watch -n 1 cat /sys/kernel/debug/dri/0/amdgpu_pm_info"
