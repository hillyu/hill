#!/usr/bin/env bash
pkill -f nwg-wrapper

nwg-wrapper -s date-wttr.sh -r 1800000 -c date-wttr.css -p left -ml 150 -o eDP-1 &
nwg-wrapper -t bindings.pango -c bindings.css -p right -mr 90 -mt 50 -o eDP-1 &
# nwg-wrapper -s timezones.sh -r 60000 -c timezones.css -p right -mr 50 -a start -mt 50 -j right -o eDP-1 &
