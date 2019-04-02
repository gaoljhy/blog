# iptables命令高级网络

`iptables`命令是Linux上常用的防火墙软件，是`netfilter`项目的一部分。
可以直接配置，也可以通过许多前端和图形界面配置。

## 语法

`iptables(选项)(参数)`

### 选项

```bash
-t<表>：指定要操纵的表；

# 规则列操作
-A：--append 向规则链中添加条目；
-D：--drop 从规则链中删除条目；
-i：--insert 向规则链中插入条目；
-R：--replace 替换规则链中的条目；
-L：--list 显示规则链中已有的条目；
-F：--flush 清除规则链中已有的条目；
-Z：-zero 清空规则链中的 数据包计算器 和 字节计数器 ；
-N：--new 创建新的用户自定义规则链；
-P：--proto 定义规则链中的默认目标；

-h：显示帮助信息；

-p：--protocol 指定要匹配的数据包协议类型；
-s：--source 指定要匹配的 数据包中 源ip地址；
-d：--destination 指定要匹配的 数据包中 目的ip地址；

-j<目标>：--jump 指定要跳转的目标 或者动作；
-i<网络接口>：-in-interface 指定数据包进入本机的网络接口(网卡)；
-o<网络接口>：-out-interface 指定数据包要离开本机所使用的网络接口。
```

## `iptables`命令选项输入顺序：

`iptables -t 表名 <-A/I/D/R> 规则链名 [规则号] <-i/o 网卡名> -p 协议名 <-s 源IP/源子网> --sport 源端口 <-d 目标IP/目标子网> --dport 目标端口 -j 动作`

### 表名包括：

`raw`：高级功能，如：网址过滤。
`mangle`：数据包修改（QOS），用于实现服务质量。
`net`：地址转换，用于网关路由器。
`filter`：包过滤，用于防火墙规则。

### 规则链名包括：

`INPUT`链：处理输入数据包。
`OUTPUT`链：处理输出数据包。
`PORWARD`链：处理转发数据包。
`PREROUTING`链：用于目标地址转换（DNAT）。
`POSTOUTING`链：用于源地址转换（SNAT）。

### 动作包括：

`accept`：接收数据包。
`DROP`：丢弃数据包。
`REDIRECT`：重定向、映射、透明代理。
`SNAT`：源地址转换。
`DNAT`：目标地址转换。
`MASQUERADE`：IP伪装（NAT），用于ADSL。
`LOG`：日志记录。

## 注意

必须指定是大写

------

## 实例

清除已有`iptables`规则

`iptables -F`
`iptables -X`
`iptables -Z`

### 开放指定的端口

- 允许本地回环接口(即运行本机访问本机)

`iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT`

- 允许已建立的或相关连的通行

`iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT`

- 允许所有本机向外的访问
`iptables -A OUTPUT -j ACCEPT`

- 允许访问22端口
`iptables -A INPUT -p tcp --dport 22 -j ACCEPT`

- 允许访问80端口
`iptables -A INPUT -p tcp --dport 80 -j ACCEPT`

- 允许ftp服务的21端口
`iptables -A INPUT -p tcp --dport 21 -j ACCEPT`

- 允许FTP服务的20端口
`iptables -A INPUT -p tcp --dport 20 -j ACCEPT`

- 禁止其他未允许的规则访问
`iptables -A INPUT -j reject`

- 禁止其他未允许的规则访问
`iptables -A FORWARD -j REJECT`

### 屏蔽IP

- 屏蔽单个IP的命令
`iptables -I INPUT -s 123.45.6.7 -j DROP`

- 封整个段即从`123.0.0.1`到`123.255.255.254`的命令
`iptables -I INPUT -s 123.0.0.0/8 -j DROP`

- 封IP段即从123.45.0.1到123.45.255.254的命令
`iptables -I INPUT -s 124.45.0.0/16 -j DROP`

- 封IP段即从123.45.6.1到123.45.6.254的命令是
`iptables -I INPUT -s 123.45.6.0/24 -j DROP`

### 查看已添加的iptables规则

`iptables -L -n -v`

### 删除已添加的iptables规则

- 将所有`iptables`以序号标记显示，执行：
`iptables -L -n --line-numbers`

- 比如要删除INPUT里序号为8的规则，执行：
`iptables -D INPUT 8`

### 端口转发与映射

启动网络转发规则

- 公网210.14.67.7让内网192.168.188.0/24上网

`iptables -t nat -A POSTROUTING -s 192.168.188.0/24 -j SNAT --to-source 210.14.67.127`

端口映射

- 本机的 2222 端口映射到内网 虚拟机的22 端口

`iptables -t nat -A PREROUTING -d 210.14.67.127 -p tcp --dport 2222  -j DNAT --to-dest 192.168.188.115:22`

### 字符串匹配

比如，要过滤所有TCP连接中的字符串test，一旦出现它就重置这个连接

`iptables -A INPUT -p tcp -m string --algo kmp --string "test" -j REJECT --reject-with tcp-reset`

### 阻止Windows蠕虫的攻击

`iptables -I INPUT -j DROP -p tcp -s 0.0.0.0/0 -m string --algo kmp --string "cmd.exe"`

### 防止SYN洪水攻击

`iptables -A INPUT -p tcp --syn -m limit --limit 5/second -j ACCEPT`
