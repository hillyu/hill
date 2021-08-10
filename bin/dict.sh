#!/usr/bin/env bash

#PUT THIS FILE IN ~/.local/share/rofi/finder.sh
#USE: rofi  -show find -modi find:~/.local/share/rofi/finder.sh
if [ ! -z "$@" ]
then

    coproc ( brave --window-size="600,700" --app-window-size="600,700" --app="https://www.merriam-webster.com/dictionary/$@" > /dev/null 2>&1 )
else
    if [ -z "$DISPLAY" ] 
    then 
        word=`wl-paste -p`
    else
        word=`xsel -p`
    fi
    if [ ! -z "$word" ]
    then
        echo "$word"
    else
        echo "Type your word to query merriam-webster dictionary!"
fi
fi
