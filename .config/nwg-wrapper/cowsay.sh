#!/usr/bin/env bash

title="Today's Fortune:"
color="#d6e1a6"
cmd=$(fortune -s|cowthink -W 30)
# textfont="Fixedsys Excelsior MonoL"
fontsize="12pt"
source ~/.config/nwg-wrapper/termout.sh

