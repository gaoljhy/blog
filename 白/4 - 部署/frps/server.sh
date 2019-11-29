#!/bin/bash

touch frps.ini

cat > frps.ini <<EOF
[common]
bind_port = 18800
token = JpnewT2EJz0FkF6ETvwid2snW
vhost_http_port = 8888
# 留 http port

dashboard_port = 5555
dashboard_user = Vy78LV
dashboard_pwd = %5G6#oM

tcp_mux = true
max_pool_count = 10
EOF

# docker 安装
# curl -fsSL get.docker.com -o get-docker.sh
# sudo sh get-docker.sh --mirror Aliyun

docker run -d --name frp-server -p 18800:18800 -p 8888:8888 -p 55555:55555 -p 5555:5555 -v $(pwd):/conf --restart=always cloverzrg/frps-docker