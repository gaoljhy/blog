## 关闭 不需要的服务

> 或者使用 `ntsysv` 命令工具来进行关闭

###  查看开启的服务

```bash
systemctl list-unit-files | grep enable
```

### 关闭所有服务

```bash
for sun in `systemctl list-unit-files --type=service | grep enable |awk '{print $1}'`;do systemctl disable  $sun ;done
```

### 开启指定服务

```bash
for sun in crond rsyslog sshd network  NetworkManager iptables;do systemctl enable $sun ;done
```

> 重启 reboot

-------------------

## 3. 关闭不需要的TTY

`vi /etc/init/start-ttys.conf`

> 修改 `/dev/tty[1-2]` 即可 ,开启 `1-2`

> 最新的centos 不需要修改这一项默认由系统决定开启几个

------------------

## 4. 网络优化

> 查看当前连接数
> > `netstat -n |awk '/^tcp/ {++S[$NF]} END{for(a in S) print a, S[a]}'`

面对web 服务器的个性化配置

```bash
vi /etc/sysctl.d/default.conf

    net.ipv4.tcp_syncookies = 1        #可以加强对抗SYN Flood的能力        #表示开启SYN Cookies。当出现SYN等待队列溢出时，启用cookies来处理，可防范少量SYN攻击，默认为0，表示关闭；    
    net.ipv4.tcp_tw_recycle = 1        #表示开启TCP连接中TIME-WAIT sockets的快速回收，默认为0，表示关闭
    net.ipv4.ip_local_port_range = 40000    65000    #表示用于向外连接的端口范围。缺省情况下：32768到61000

sysctl -p #使配置生效
```

> 其他配置
```bash
net.ipv4.tcp_tw_reuse = 1          #表示开启重用。允许将TIME-WAIT sockets重新用于新的TCP连接，默认为0，表示关闭；
net.ipv4.tcp_fin_timeout = 30  #表示如果套接字由本端要求关闭，这个参数决定了它保持在FIN-WAIT-2状态的时间。
　　net.ipv4.tcp_keepalive_time = 1200 　　　　　　#表示当keepalive起用的时候，TCP发送keepalive消息的频度。缺省是2小时，改为20分钟。
　　net.ipv4.tcp_max_syn_backlog = 8192　　　　　　#表示SYN队列的长度，默认为1024，加大队列长度为8192，可以容纳更多等待连接的网络连接数。
　　net.ipv4.tcp_max_tw_buckets = 5000 　　　　　　#表示系统同时保持TIME_WAIT套接字的最大数量，如果超过这个数字，TIME_WAIT套接字将立刻被清除并打印警告信息。默认为180000，改为5000
```

-------------

##  时间同步

```bash
yum install -y ntpdate
crontab -e

# 添加
*/5 * * * * /usr/sbin/ntpdate ntp2.aliyun.com && hwclock -w && hwclock --systoh &> /dev/null
```
> 可以采用阿里服务器
ntp1.aliyun.com
ntp2.aliyun.com
ntp3.aliyun.com
ntp4.aliyun.com

> 可修改也可不修改 配置文件 `/etc/ntp/step-tickers` 加入 

更新时间并且写入BOIS

`ntpdate ntp1.aliyun.com && hwclock -w && hwclock --systoh`

### 修改时区

```sh
timedatectl list-timezones |grep Shanghai    #查找中国时区的完整名称
# Asia/Shanghai
timedatectl set-timezone Asia/Shanghai    #其他时区以此类推
```



## 修改同时最大打开文件数目(句柄)限制

要调整一下 Linux 的最大文件打开数，否则服务器在高负载时执行性能将会很差；
> 另外，在 Linux 下部署应用时，有时候会遇上 “Too many open files” 这样的问题，这个值也会影响服务器的最大并发数。其实 Linux 是有文件句柄限制的。但默认值下是很高，一般是1024，生产服务器很容易就会达到这个值，所以需要改动此值。


`vi /etc/security/limits.conf`
或者在
`/etc/security/limits.d` 添加一个配置文件

添加以下俩行

```
*   hard  nofile    1000
*   soft  nofile    1000
```

> 大型服务器一般根据并发端口数填 65535


```sh
vi /etc/rc.local
// 添加如下内容
ulimit -SHn 1000
```

> ulimit -n 查看此设置值

----------

## 停止 ipv6

> 不建议停用

可用如下命令查看：

`lsmod | grep ipv6`

> 有些网络和应用程序还不支持 IPv6 ，因此，禁用 IPv6 可以说是一个非常好的选择
> 加强系统的安全性，并提高系统的整体性能。不过，首先要确认一下：IPv6是不是处于动的状态，命令如下：

列出全部网络接口信息

`ifconfig -a`

> 修改相应的配置文件，停止 IPv6 ，命令如下：
echo "install ipv6 /bin/true" > /etc/modprobe.d/disable-ipv6.conf
# 每当系统需要加载IPv6时，强制执行 /bin/true 来替代实际加载的模块
echo "IPV6INIT=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
# 禁用基于IPv6网络，使之不会被触发启动

或者

内核调参

`echo -e "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf`
