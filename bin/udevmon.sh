#!/usr/bin/bash
case $1 in
    added )
        grep -q "$PRODUCT" /tmp/udev.log || echo -e "$PRODUCT:$ID_MODEL" >> /tmp/udev.log
        ;;
    removed )
        [ -z "$ID_MODEL" ] && ID_MODEL=$(awk -F":" -v p="$PRODUCT" '$1==p {print $2}' </tmp/udev.log)
        ;;
esac
export XDG_RUNTIME_DIR=/run/user/1000
pgrep river || exit 0
# only do following in wayland or x11 session
devtype="Usb"
[ "$SUBSYSTEM" = "bluetooth" ] && pkill -RTMIN+9 waybar && devtype="Bluetooth" && exit 0
/usr/bin/su hill -c "/usr/bin/notify-send -i usb-device \"$devtype Device:\" \"$ID_MODEL $1\""
pw-play /usr/share/sounds/freedesktop/stereo/device-$1.oga
