#!/usr/bin/env bash
date=`date +%F`
header="Dear all,\nHere is my update for your information:\n"
sig="\nSincerely,\nHill Xiaochuan YU"
diary="$HOME/vimwiki/diary"
update=`tp $diary/$date.md`
email="$header$update$sig"
emailto="staff.wisersallrec@wisers.com"
if [ `echo "$update"|grep -Eo "[0-9]+%" |awk '{s+=$1} END {print s}'` != 100 ]; then
    echo "Not add up to 100%, wanna look stupid? ;D"
    exit 1
fi
echo -e "$email"|tee >(sed  ':a;N;$!ba;s/.*Update:\(.*\)\nTodo.*/\1/g'|xclip -selection clipboard)
read -r -p "Are You Sure? [Y/n] " input
case $input in
    [yY][eE][sS]|[yY])
        echo -e "$email" |mail -c hillyu@wisers.com -s "Daily Update ($date)" -- $emailto
        echo "Sent!"
        ;;
    [nN][oO]|[nN])
        echo "Canceled! Email NOT sent!"
        ;;
    *)
        echo "Invalid input..."
        exit 1
        ;;
esac
#emailto="hillyu@wisers.com"
#echo "$sig"
