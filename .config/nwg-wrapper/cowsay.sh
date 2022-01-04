#!/usr/bin/env bash

title="Today's Fortune:"
color="$(fgcolor.sh 391x323+426+0)"
cmd=$(fortune -s|cowthink -W 30)
# textfont="Fixedsys Excelsior MonoL"
fontsize="12pt"
source ~/.config/nwg-wrapper/termout.sh

