curl --socks5 localhost:7891 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' > raw
cat raw | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }'  >> cn_ip.txt
sort -u cn_ip.txt > /tmp/cn_ip.txt
mv /tmp/cn_ip.txt cn_ip.txt
