#!/usr/bin/env bash
sensor=`sensors -j 2>/dev/null`
cpu=`echo "$sensor" | jq '[.[]|.[]]|.[3]|.["temp1_input"]'`
# gpu=`echo "$sensor" | jq '.["amdgpu-pci-0300"]|.["edge"]|.["temp1_input"]'`
tooltip=$( sensors -A )
cpu=${cpu%.*}
max=75
percentage=`echo "$cpu/$max*100" |bc -l`
class="cool"
if [[ $cpu -gt 50 ]]; then
    class="normal"
    elif [[ $cpu -gt 60 ]]; then
        class="critical"
fi
printf "%3d°C\n" $cpu
echo $tooltip
[[ $BLOCK_BUTTON = "1" ]] && st  -c prompt -g 70x40 bash -c "watch -n 1 sensors"
[[ $BLOCK_BUTTON = "3" ]] && st  -c prompt -g 70x40 bash -c "sudo watch -n 1 cat /sys/kernel/debug/dri/0/amdgpu_pm_info"
