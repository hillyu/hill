#!/usr/bin/env bash

if ! ip link |grep -q ppp0 
then 
exit 1
fi
ip link|grep -q ppp1 && ip link del ppp1 ||:
sleep 5
ip rule del fwmark 1 lookup 1
ip route del default via 10.0.8.2 metric 1 table 1
ip rule add fwmark 1 lookup 1 && \
pppd updetach noauth silent nodeflate pty "/usr/bin/ssh -i /home/hill/.ssh/id_rsa root@hills.ml -p 2003 /usr/sbin/pppd nodetach notty noauth" ipparam vpn 10.0.8.1:10.0.8.2 && \
ip route add default via 10.0.8.2 metric 1 table 1
ip route add 192.168.1.0/24 via 192.168.31.1
