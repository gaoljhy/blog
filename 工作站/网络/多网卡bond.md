# NetworkManger


## 各种模式：

METHOD 是以下的其中一个：broadcast、activebackup、roundrobin、loadbalance 或者 lacp。

第一种模式：mod=0 ，即：(balance-rr)Round-robin policy（平衡抡循环策略）交换机配置Eth-Trunk
第二种模式：mod=1，即： (active-backup)Active-backup policy（主-备份策略）
第三种模式：mod=2，即：(balance-xor)XOR policy（平衡策略）
第四种模式：mod=3，即：broadcast（广播策略）
第五种模式：mod=4，即：(802.3ad)IEEE 802.3ad Dynamic link aggregation（IEEE802.3ad 动态链接聚合）
第六种模式：mod=5，即：(balance-tlb)Adaptive transmit load balancing（适配器传输负载均衡）
第七种模式：mod=6，即：(balance-alb)Adaptive load balancing（适配器适应性负载均衡）


1. 创建bond网卡

    `nmcli connection add type bond con-name bond0 ifname bond0 mode 0`

2. 查看创建网卡情况

    `nmcli con show`

3. 添加负载的网卡

    ```
    nmcli connection add type bond-slave ifname enp1s0 master bond0
    nmcli connection add type bond-slave ifname enp3s0 master bond0
    ```
4. 配置IP地址及网关(可配置文件)

    nmcli con mod team0 ipv4.addresses "171.16.41.x/24"
    nmcli con mod team0 ipv4.gateway "171.15.41.x"
    nmcli con mod team0 ipv4.method manual
    nmcli con up team0
5. 重启网络服务

    systemctl restart network

6. 查看撞塌
    
    nmcli connection show bond0

7. 检查网卡绑定效果
    nmcli dev dis bond0 //关闭绑定状态
    nmcli dev con bond0 //恢复绑定状态


## 直接修改文件时的配置

```
# 系统启动时就启动网卡设备
ONBOOT=yes
# 允许用从DHCP处获取的DNS覆盖本地的DNS
PEERDNS=yes
# 不允许普通用户修改网卡
USERCTL=no
```