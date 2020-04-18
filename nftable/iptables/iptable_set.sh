#iptables -t mangle -N CLASH
#iptables -t mangle -A CLASH -m set --match-set whitelist dst -j RETURN
#iptables -t mangle -A CLASH -p udp -j TPROXY --on-port 7892 --tproxy-mark 0x01/0x01
#iptables -t mangle -A PREROUTING -p udp -j CLASH
# define CLASH chain
#iptables -t nat -N CLASH
#iptables -t nat -A CLASH -m set --match-set whitelist dst -j RETURN
#iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports 7892

# mangle (udp go through sshVPN -- ppp1,mark 1 will match a rule on table 1, it defines default gateway using ppp1 ip address 10.0.8.2 )
iptables -t mangle -A PREROUTING -m set --match-set whitelist dst -j RETURN
iptables -t mangle -A PREROUTING -i eth0 -p udp -j MARK --set-mark 1

# nat (redirect to clash for tcp proxy load-balancing)
iptables -t nat -A PREROUTING -m set --match-set whitelist dst -j RETURN
iptables -t nat -A PREROUTING -p tcp -j REDIRECT --to-ports 7892

# masquerade
iptables -t nat -A POSTROUTING -m set --match-set wisers dst -j MASQUERADE
iptables -t nat -A POSTROUTING -m set --match-set whitelist dst -j RETURN
iptables -t nat -A POSTROUTING -j MASQUERADE

#local gen traffic
iptables -t nat -A OUTPUT -m set --match-set whitelist dst -j RETURN
iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-ports 7892
