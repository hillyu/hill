#!/usr/bin/env bash
# xin pro official
#ryzenadj -a 25000 -b 50000 -c 42000 -d 5 -e 200 -f 80
#balanced
#ryzenadj -a 25000 -b 50000 -c 30000 -d 3 -e 200 -f 80
#ryzenadj -a 15000 -b 30000 -c 20000 -d 3 -e 200 -f 60
#sudo ryzenadj -a 15000 -b 35000 -c 10000 -d 5 -e 200 -f 40
# Xin pro official
#ryzenadj -a 35000 -b 50000 -c 42000 -f 80
 #lowest should be 15000, lower than that will cause lag 
ryzenadj -a 15000 -b 25000 -c 15000 -d 2 -f 80
# set power to low on GPU to prevent over use of power from vega 
#/home/hill/bin/chicony-ir-toggle on
#echo "low" > /sys/class/drm/card0/device/power_dpm_force_performance_level
# default is 24 which is too slow for my mx master (it uses 6 as min latency)
#echo 6 > /sys/kernel/debug/bluetooth/hci0/conn_min_interval
echo 20000 > /sys/bus/usb/devices/3-1/power/autosuspend_delay_ms
#echo 15 > /proc/sys/vm/swappiness
