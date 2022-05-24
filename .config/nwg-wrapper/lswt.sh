#!/usr/bin/env bash
#!/usr/bin/env bash

title="Windows:"
color="#d6e1a6"
cmd="$(lswt -t|awk -F'\t' '{gsub(/"/,""); printf "%8s: %29s|%-20s\n", $7, substr($2,1,25),substr($1,1,8)}')"
textfont="Fixedsys Excelsior MonoL"
# fontsize="6pt"
source ~/.config/nwg-wrapper/termout.sh

