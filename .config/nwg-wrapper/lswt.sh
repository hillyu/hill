#!/usr/bin/env bash
#!/usr/bin/env bash

title="Windows:"
color="#d6e1a6"
cmd="$(lswt -t|awk -F'\t' '{ printf "%-20s|%8s|%25s\n", substr($1,1,20), $7, substr($2,1,25) }')"
textfont="Fixedsys Excelsior MonoL"
# fontsize="6pt"
source ~/.config/nwg-wrapper/termout.sh

