# client 配置

修改 网卡信息

```conf
BOOTPROTO="static"
IPADDR=192.168.0.50
NETMASK=255.255.255.0
GATEWAY=192.168.0.1
DNS1=192.169.0.2
```

`systemctl restart network`

`ip a`

-------

## 正向测试

### 客户端测试方法一：

```bash
ping www.bgl.net
ping ftp.bgl.net
ping mail.bgl.net
```

均能解析成对应的IP地址

### 客户端测试方法二：

```bash
yum -y install bind*
nslookup
exit
```

### 客户端测试方法三：

`dig www.bgl.net`

## 反向测试

## 客户端测试时

测试方法一：
`host 192.168.122.51` 可以看到反向解析出来对应的域名

测试方法二：
`dig -x 192.168.122.51`

测试方法三：
`nslookup`(exit退出)
