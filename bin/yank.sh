#!/bin/bash

set -eu

is_app_installed() {
  type "$1" &>/dev/null
}

# get data either form stdin or from file
buf=$(cat "$@")

#copy_backend_remote_tunnel_port=$(tmux show-option -gvq "@copy_backend_remote_tunnel_port")
#copy_use_osc52_fallback=$(tmux show-option -gvq "@copy_use_osc52_fallback")
copy_use_osc52_fallback="on"

# Resolve copy backend: pbcopy (OSX), reattach-to-user-namespace (OSX), xclip/xsel (Linux)
# copy_backend=""
# if is_app_installed pbcopy; then
#   copy_backend="pbcopy"
# elif is_app_installed reattach-to-user-namespace; then
#   copy_backend="reattach-to-user-namespace pbcopy"
#elif [ -n "${DISPLAY-}" ] && is_app_installed xsel; then
  #copy_backend="xsel -i --clipboard"
#elif [ -n "${DISPLAY-}" ] && is_app_installed xclip; then
  #copy_backend="xclip -i -f -selection primary | xclip -i -selection clipboard"
# elif [ -n "${copy_backend_remote_tunnel_port-}" ] && [ "$(ss -n -4 state listening "( sport = $copy_backend_remote_tunnel_port )" | tail -n +2 | wc -l)" -eq 1 ]; then
  # copy_backend="nc localhost $copy_backend_remote_tunnel_port"
# fi

# if copy backend is resolved, copy and exit above case $buf is not b64 encoded thus may have chars has special meaning in double quote, hence use %s to output safe literal string.
# echo $copy_backend
# if [ -n "$copy_backend" ]; then
#   printf %s "$buf" | eval "$copy_backend" 
#   exit;
# fi



 #If no copy backends were eligible, decide to fallback to OSC 52 escape sequences
 #Note, most terminals do not handle OSC
if [ "$copy_use_osc52_fallback" == "off" ]; then
  exit;
fi

# Copy via OSC 52 ANSI escape sequence to controlling terminal
buflen=$( printf %s "$buf" | wc -c )

# https://sunaku.github.io/tmux-yank-osc52.html
# The maximum length of an OSC 52 escape sequence is 100_000 bytes, of which
# 7 bytes are occupied by a "\033]52;c;" header, 1 byte by a "\a" footer, and
# 99_992 bytes by the base64-encoded result of 74_994 bytes of copyable text
maxlen=74994 

# warn if exceeds maxlen
if [ "$buflen" -gt "$maxlen" ]; then
  echo "input is %d bytes too long" "$(( buflen - maxlen ))" >&2
fi

# build up OSC 52 ANSI escape sequence
esc="\033]52;c;$( printf %s "$buf" | head -c $maxlen | base64 | tr -d '\r\n' )\a"
erase='\033]52;c;!\a'
if [[ -n "${TMUX+x}" ]]; then
    # as of tmux 3.3 following safe measure is no longer working, tmux should be able to handle osc52 directly.
    # esc="\033Ptmux;\033$esc\033\\"
    # erase="\033Ptmux;\033$erase\033\\"
    MTTY=$(tmux list-panes -F "#{pane_active} #{pane_tty}" | awk '$1=="1" { print $2 }')
else
# macos tend to return multiple ttys and will add a trailing space which 
# interferes with following printf cmd
MTTY=${MTTY:-"/dev/$(ps hotty $$|tail -n1|tr -d ' ')"}
fi

# resolve target terminal to send escape sequence
# it has to be a tty detectedd by ps hotty $$ as in script no tty is allocated.

printf "$erase" > "$MTTY"
printf "$esc" > "$MTTY"
