## 添加普通用户，设置sudo权限

```sh
username='username'
password='passsword'
useradd $username ; echo $password | passwd --stdin $username
sed -i "98 a$username    ALL=(ALL)       NOPASSWD: ALL" /etc/sudoers
```

> 如果在进行sudo切换时需要输入密码，可以去掉 `NOPASSWD:`

## iptables 设置

```sh
/etc/init.d/iptables restart
iptables -F
iptables -X
iptables -Z
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
#允许某个IP段远程访问ssh
iptables -A INPUT -p tcp -m tcp --dport 2222 -s 192.168.64.0/24 -j ACCEPT
#开启80端口
iptables -A INPUT -P tcp -m tcp --dropt 80 -j ACCEPT
#允许某个IP的所有请求
# iptables -A INPUT -p all -s 124.43.56.90/30 -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

/etc/init.d/iptables save
/etc/init.d/iptables restart
```

## 修改默认DNS

echo "nameserver 223.5.5.5" > /etc/resolv.conf
echo "nameserver 223.6.6.6" >> /etc/resolv.conf

> 阿里 DNS

-------------------

## 内核优化


```bash
echo -e "net.ipv4.tcp_fin_timeout = 2 " >> /etc/sysctl.conf
echo -e "net.ipv4.tcp_retries2 = 5" >> /etc/sysctl.conf
echo -e "net.ipv4.tcp_syn_retries = 1" >> /etc/sysctl.conf
echo -e "net.ipv4.tcp_timestamps = 0" >> /etc/sysctl.conf
echo -e "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
echo -e "net.ipv4.tcp_slow_start_after_idle = 0" >> /etc/sysctl.conf
echo -e "kernel.panic = 5" >> /etc/sysctl.conf
echo -e "kernel.panic_on_oops = 1" >> /etc/sysctl.conf 
echo -e "kernel.core_pipe_limit = 0" >> /etc/sysctl.conf
#iptables 防火墙
echo -e "net.nf_conntrack_max = 25000" >> /etc/sysctl.conf
echo -e "net.netfilter.nf_conntrack_max = 25000" >> /etc/sysctl.conf
echo -e "net.netfilter.nf_conntrack_tcp_timeout_established = 180" >> /etc/sysctl.conf
echo -e "net.netfilter.nf_conntrack_tcp_timeout_time_wait = 20" >> /etc/sysctl.conf
echo -e "net.netfilter.nf_conntrack_tcp_timeout_close_wait = 20" >> /etc/sysctl.conf
echo -e "net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 20" >> /etc/sysctl.confo
```

## 减少磁盘 IO

Linux文件默认有3个时间，分别如下所示。

    atime：对此文件的访问时间。
    ctime：此文件inOde发生变化的时间。
    mtime：此文件的修改时间。

> 如果有多个小文件（比如 Web 服务器的页面上有多个小图片），通常是没有必要记录**文件的访问时间**的，这样就可以减少写磁盘的 I/O

```sh
vi /etc/fstab

// 然后，在包含大量小文件的分区中使用 noatime 和 nodiratime 这两个命令。例如：  
/dev/sda5 /data/pics ext3 noatime,nodiratime 0 0 
这样文件被访问时就不会再产生写磁盘的 I/O 了。
```

> 参考 <https://www.cnblogs.com/augusite/p/10774014.html>