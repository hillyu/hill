#!/usr/bin/bash

# /usr/bin/date >> /tmp/udev.log
sleep 2
pkill -RTMIN+9 waybar
export XDG_RUNTIME_DIR=/run/user/1000
pw-play /usr/share/sounds/freedesktop/stereo/device-$1.oga
# DISPLAY=:0 /usr/bin/canberra-gtk-play -i device-added
# /usr/bin/notify-send "Bluetooth:" "$1"
# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
