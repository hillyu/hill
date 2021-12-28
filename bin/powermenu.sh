#!/usr/bin/env bash
opt=$(echo -e -n "Log Out\nBoot to Windows 10\nRestart\nShut Down"|rofi -dmenu -i -p "Select Shutdown Options:")

case $opt in
    Log* )
        pkill sway &
        pkill river &
        pkill dwm &
        ;;
    Restart)
        reboot
        ;;
    *Down )
        poweroff
        ;;
    *Windows )
        win10
        ;;
esac
