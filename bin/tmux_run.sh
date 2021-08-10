#!/usr/bin/env bash

#if [[ -n "$@" ]]
#then
    #command tmux "$@"
    #return $?
#fi
#tmux_cmd="tmux" 
#[[ "$ZSH_TMUX_ITERM2" == "true" ]] && tmux_cmd+=(-CC) 
#[[ "$ZSH_TMUX_UNICODE" == "true" ]] && tmux_cmd+=(-u) 
#[[ "$ZSH_TMUX_AUTOCONNECT" == "true" ]] && $tmux_cmd attach
#tmux att || tmux new
# sleep 0.3
tmux has-session -t "term" && tmux attach-session -t "term" ||tmux new-session -s "term" 
exit
