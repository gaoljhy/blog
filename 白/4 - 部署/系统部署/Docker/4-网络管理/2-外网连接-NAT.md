# 外网连接

## NAT模式 - ip_forward

物理机默认是开启的端口转发的 结果为1(true)

也可在物理机中启动

 `sysctl net.ipv4.conf.all.forwarding`

### 允许端口转发

`docker -p 端口`

### 查看端口转发

`docker port container`

`container port -> 0.0.0.0:port`

## 禁止外部网络访问

可以在物理机使用 `iptables`

`sudo iptables -I DOCKER -s <banIp> -d <destIp> -p <TCP/UDP> --dport <destPort> -j <DROP/ACCEPT/>`
