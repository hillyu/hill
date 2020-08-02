#!/usr/bin/env bash
# xin pro official
#ryzenadj -a 25000 -b 50000 -c 42000 -d 5 -e 200 -f 80
#balanced
#ryzenadj -a 25000 -b 50000 -c 30000 -d 3 -e 200 -f 80
ryzenadj -a 15000 -b 50000 -c 30000 -d 3 -e 200 -f 80
#sudo ryzenadj -a 15000 -b 35000 -c 10000 -d 5 -e 200 -f 40
# magicbook pro official
#sudo ryzenadj -a 35000 -b 50000 -c 42000 -d 5 -e 200 -f 80
# set power to low on GPU to prevent over use of power from vega 
#/home/hill/bin/chicony-ir-toggle on
#echo "low" > /sys/class/drm/card0/device/power_dpm_force_performance_level
