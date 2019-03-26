# dhcpd.conf参数说明

`/etc/dhcpd.conf`通常包括三部分：

 1. parameters
 2. declarations
 3. option

## DHCP配置文件中的`parameters`（参数）

1. 如何执行任务，
2. 是否要执行任务
3. 将哪些网络配置选项发送给客户

| 参数 | 作用 |
| :---: |-----|
|`ddns-update-style`|               配置DHCP-DNS 互动更新模式|
|`default-lease-time`|              指定确省租赁时间的长度，单位是秒|
|`max-lease-time`|                  指定最大租赁时间长度，单位是秒|
|`hardware`|                        指定网卡接口类型和MAC地址|
|`server-name`|                     通知DHCP客户服务器名称|
|`get-lease-hostnames flag`|        检查客户端使用的IP地址|
|`fixed-address ip`|                分配给客户端一个固定的地址|
|`authritative`|                    拒绝不正确的IP地址的要求|

## DHCP配置文件中的declarations （声明）

1. 描述网络布局
2. 提供客户的IP地址等

| 参数 | 作用 |
| :---: | --- |
| `shared-network`|用来告知是否一些子网络分享相同网络|
|`subnet`|描述一个IP地址是否属于该子网|
| `range 起始IP 终止IP`| 提供动态分配IP 的范围|
|`host 主机名称`| 参考特别的主机|
|`group`|为一组参数提供声明|
|`allow unknown-clients;deny unknown-client`|是否动态分配IP给未知的使用者|
|`allow bootp;deny bootp`|是否响应激活查询|
|`allow booting;deny booting`|是否响应使用者查询|
|`filename`|开始启动文件的名称. 应用于无盘工作站|
|`next-server`|设置服务器从引导文件中装如主机名，应用于无盘工作站|

## DHCP配置文件中的option（选项)

1. 用来配置`DHCP`可选参数
2. 全部用`option`关键字作为开始

| 参数 | 作用 |
| :---: | --- |
|`subnet-mask`|为客户端设定子网掩码。|
|`domain-name`|为客户端指明DNS名字。|
|`domain-name-servers`|为客户端指明DNS服务器IP地址|
|`host-name`|为客户端指定主机名称。|
|`routers`|为客户端设定默认网关。|
|`broadcast-address`|为客户端设定广播地址。|
|`ntp-server`|为客户端设定网络时间服务器IP地址。|
|`time－offset`|为客户端设定和格林威治时间的偏移时间，单位是秒。|

## 注意：

如果客户端使用的是视窗操作系统，不要选择`host-name`选项，即不要为其指定主机名称
