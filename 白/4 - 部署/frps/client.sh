#!/bin/sh

FRP_VERSION=0.30.0
OS_KIND=amd64

wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${OS_KIND}.tar.gz \
    && tar -xf frp_${FRP_VERSION}_linux_${OS_KIND}.tar.gz \
    && cd frp_${FRP_VERSION}_linux_${OS_KIND} \
    && rm -rf ./frps \
    && rm -rf frps.ini


cat > frpc.ini <<EOF
[common]
server_addr = 47.107.239.180
server_port = 18800
token = JpnewT2EJz0FkF6ETvwid2snW

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 55555

[web]
type = http
local_port = 80
custom_domains = yun.grj321.com
EOF

./frpc -c ./frpc.ini &

