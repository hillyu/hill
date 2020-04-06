#!/usr/bin/perl -w
use strict;

# curl http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest| perl ./ssnft.pl > nfttables
# nft -f nfttables

my $local_port = 7892;              # 本地 ss-redir 服务的端口
my @noss = (                        # 不需要重定向的预定义地址，千万记得将 ss 远程服务器的地址加上！
    "127.0.0.0/8",
    "10.0.0.0/8",
    "172.16.0.0/12",
    "192.168.0.0/16",
    "169.254.0.0/16",
    "224.0.0.0/4",
    "240.0.0.0/4",
);

my %prefixlen;
foreach (1..31) {
    $prefixlen{2**$_} = 32-$_;
}

while(<>) {                         # 具体用法看上面的注释，从 apnic 下载地址信息处理下
    chomp;
    next unless /^apnic\|CN\|ipv4/;
    my @ent = split /\|/;
    push @noss, sprintf "%s/%s", $ent[3], $prefixlen{$ent[4]};
}

my $result = <<__NFT;
table ip shadowsocks {
    chain output {
        type nat hook output priority -100;                 # netfilter internal operation: NF_IP_PRI_NAT_DST (-100)
        ip daddr { NOSS_ADDRESSES } return                  # 不需要重定向的地址就 return 吧
        tcp sport {32768-61000} redirect to $local_port     # /proc/sys/net/ipv4/ip_local_port_range，本地发起的连接的端口范围
    }
    chain input {                                           # 即使这条 chain 是空的，也需要定义
        type nat hook input priority -100;
    }
}
__NFT

my $noss_addresses = join ", ", @noss;
$result =~ s/NOSS_ADDRESSES/$noss_addresses/;
print $result;


