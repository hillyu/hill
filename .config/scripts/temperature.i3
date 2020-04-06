#!/usr/bin/env bash
sensor=`sensors -j 2>/dev/null`
cpu=`echo "$sensor" | jq '.["k10temp-pci-00c3"]|.["Tdie"]|.["temp1_input"]'`
gpu=`echo "$sensor" | jq '.["amdgpu-pci-0300"]|.["edge"]|.["temp1_input"]'`
cpu=${cpu%.*}
gpu=${gpu%.*}
class="cool"
echo  "C/G:$cpu/$gpu °C"
echo  "$cpu/$gpu °C"
if [[ $cpu -gt 50 ]]; then
    class="normal"
    echo  \#FFFC00
    elif [[ $cpu -gt 60 ]]; then
        class="critical"
        echo \#FF0000
fi
