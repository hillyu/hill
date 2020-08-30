#!/usr/bin/env bash
sudo modprobe ideapad_laptop
api=/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
mstate=`cat $api`
result=`echo $((($mstate+1)%2)) |sudo tee $api`
[ "$result" == "1" ] && echo "Conservation mode: On" || echo "Conservation mode: Off"
sleep 3
#echo $((($mstate+1)%2)) 
