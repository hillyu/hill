curl --socks5 localhost:1080 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' > raw
echo "define chnroute_list = {" > chnroute.nft
cat raw | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' | sed s/$/,/g >> chnroute.nft
echo "}" >> chnroute.nft
