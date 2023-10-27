#!/usr/bin/env bash
pkill -f nwg-wrapper

# internal mon

nwg-wrapper  -r 1800000 -c date-wttr.css -p left -a start   -mt 50 -ml 50 -o eDP-1 -s date-wttr.sh &
nwg-wrapper  -r 1800000 -c date-wttr.css -p left -a start   -mt 50 -ml 50 -o DP-2 -s date-wttr.sh &
nwg-wrapper  -r 1800000 -c date-wttr.css -p left -a start   -mt 50 -ml 50 -o HDMI-A-1 -s date-wttr.sh &
nwg-wrapper  -r 0 -c album.css -p left -a end  -mb 10 -ml 50 -sr 8 -o eDP-1 -s album.sh &
nwg-wrapper  -r 0 -c album.css -p left -a end  -mb 10 -ml 50 -sr 8 -o HDMI-A-1 -s album.sh &
nwg-wrapper  -r 0 -c album.css -p left -a end  -mb 10 -ml 50 -sr 8 -o DP-2 -s album.sh &
nwg-wrapper  -s timezones.sh -r 60000 -c timezones.css -p right -a end -mb 0 -mr 65 -sr 8 -j right -o eDP-1 &
nwg-wrapper  -s timezones.sh -r 60000 -c timezones.css -p right -a end -mb 0 -mr 65 -sr 8 -j right -o HDMI-A-1 &
nwg-wrapper  -s timezones.sh -r 60000 -c timezones.css -p right -a end -mb 0 -mr 65 -sr 8 -j right -o DP-2 &
nwg-wrapper  -c bindings.css -p right -a start -mt 50 -mr 20 -o eDP-1 -t bindings.pango -sr 9&
nwg-wrapper -s music.sh  -c timezones.css -p left -a end -mb 350 -ml 90 -o eDP-1 -sr 8 &
nwg-wrapper -s music.sh  -c timezones.css -p left -a end -mb 350 -ml 90 -o HDMI-A-1 -sr 8 &
nwg-wrapper -s music.sh  -c timezones.css -p left -a end -mb 350 -ml 90 -o DP-2 -sr 8 &
nwg-wrapper  -l 1 -c timezones.css -p right -a end  -mr 500 -mb 20 -o eDP-1 -sr 8 -s cowsay.sh &
nwg-wrapper  -l 1 -c timezones.css -p right -a end  -mr 500 -mb 20 -o DP-2 -sr 8 -s cowsay.sh &

# ext mon
nwg-wrapper -r 0 -c album.css -p left -a end -ml 50 -mb 50 -sr 8 -o DP-1 -s album.sh &
nwg-wrapper -r 0 -c album.css -p left -a end -ml 50 -mb 50 -sr 8 -o VGA-1 -s album.sh &
nwg-wrapper -c termout.css -r 0 -p right -a start -mr 0 -mt 50 -o DP-1 -s neofetch.sh &
nwg-wrapper -c termout.css -r 30000 -p right -a end -mb 280 -o DP-1 -s lswt.sh &
nwg-wrapper -c termout.css -r 30000 -p right -a end -mb 280 -o VGA-1 -s lswt.sh &
nwg-wrapper -c termout.css -r 60000 -p right -a end  -mb 50 -o DP-1 -s timer.sh &
# nwg-wrapper -c termout.css -r 60000 -p right -a end  -mb 50 -o VGA-1 -s timer.sh &
nwg-wrapper -c termout.css -r 1800000 -p left -a start  -ml 50 -mt 50 -o DP-1 -s calendar.sh &
nwg-wrapper -c termout.css -r 1800000 -p left -a start  -ml 50 -mt 50 -o VGA-1 -s calendar.sh &
# nwg-wrapper -c termout.css -r 0 -p left -a end -ml 400 -mb 50 -o DP-1 -s disk.sh &
nwg-wrapper -c termout.css -r 0 -p left -a end -ml 400 -mb 50 -o DP-1 -s lastupgraded.sh &
# nwg-wrapper  -c termout.css -r 0 -p right -a start -mt 50 -mr 600 -s lastupgraded.sh -o DP-1 &
nwg-wrapper  -c termout.css -r 0 -p right -a start -mt 50 -mr 600 -s disk.sh -o DP-1 &
nwg-wrapper  -c termout.css -r 0  -p right -a end  -mb 280 -mr 600 -o DP-1 -s failedservice.sh &
nwg-wrapper -s music.sh  -c timezones.css -p left -a end -mb 450 -ml 90 -o DP-1 -sr 8 &
nwg-wrapper -s music.sh  -c timezones.css -p left -a end -mb 450 -ml 90 -o VGA-1 -sr 8 &
