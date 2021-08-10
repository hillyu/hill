data=`<"${1:-/dev/stdin}"`
echo "$data"|awk -F '|' '
$4 ~ "[[:digit:]]h"  { i++; s+=$4; cat[i]=$3;title[i]=$2;time[i]=$4;status[i]=$5}
$3 !="" && $5 !~ "one" {e++;todo[e] ="[" $3 "] " $2}
END {
print "Update:"
for (d=1;d<i; ++d) {
    percent=int(time[d]*100/s)
    acc+=percent
    printf ("[%s] %s (%d%% - %s)\n",cat[d],title[d],percent,status[d]~"one"?"Done":"WIP")
}
printf ("[%s] %s (%d%% - %s)\n",cat[i],title[i],100-acc,status[d]~"one"?"Done":"WIP");
print "Todo:"
for (ii in todo)
    print todo[ii]
printf ("Total %.2fh spent today!",s)
}
'
