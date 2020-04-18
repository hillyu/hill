ipset create whitelist hash:net
ipset create wisers hash:net
xargs -I IP ipset add whitelist IP < cn_ip.txt
xargs -I IP ipset add whitelist IP < wisers.txt
xargs -I IP ipset add whitelist IP < private.txt
xargs -I IP ipset add wisers IP < wisers.txt
