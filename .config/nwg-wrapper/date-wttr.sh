#!/usr/bin/env bash

# time=$(LC_ALL=C TZ='Europe/Warsaw' date +'%A, %d. %B')
time=$(date +'%A, %d. %B')
# wttr=$(curl -s https://wttr.in/Minxian?format=2)
wttr=$(curl -s https://wttr.in/HK?format="%c+%t+|+%w\n+%h+|+%p\n+%l\n")
echo '<span size="35000" foreground="#A795DD">'$time'</span><span size="20000" foreground="#cccc">'
echo "$wttr</span>"
