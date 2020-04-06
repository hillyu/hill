#!/usr/bin/env bash
api=/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
mstate=`cat $api`
echo $((($mstate+1)%2)) |sudo tee $api
#echo $((($mstate+1)%2)) 
