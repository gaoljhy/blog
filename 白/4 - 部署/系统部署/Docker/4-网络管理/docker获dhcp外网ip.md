# DHCP 获取外网ip地址

## 问题

1. Container IP 是动态分配的
2. Container IP 是内部IP，外部无法访问（如对外提供HDFS服务可能会遇到Client无法访问DataNode，因为DataNode注册的是内部IP）

> 针对第一个问题有不少的方案，可以指定静态的IP

> 对第二个问题，可以使用`--net=host`解决，但这会导致对外只有一个`IP`，集群各个`Slave`的端口都要修改

## 简单的Solution

> 不采用条wave 或者kubernates

方法很简单：为`Docker`宿主网卡绑定多个`IP`，把这些`IP`分配给不同的容器。

```
root@default:~# ifconfig
docker0   Link encap:Ethernet  HWaddr 02:42:8C:8E:80:F1  
          inet addr:172.17.42.1  Bcast:0.0.0.0  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth1      Link encap:Ethernet  HWaddr 08:00:27:24:D1:F5  
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe24:d1f5/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:222 errors:0 dropped:0 overruns:0 frame:0
          TX packets:164 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:32277 (31.5 KiB)  TX bytes:28136 (27.4 KiB)
```

### 网卡添加多个ip

eth1网卡是可以与外部交互，所以添加IP到这个网卡上

1. 第一步：添加了两个IP

    ```sh
    root@default:~# ifconfig eth1:0 192.168.99.10 netmask 255.255.255.0 up
    root@default:~# ifconfig eth1:1 192.168.99.11 netmask 255.255.255.0 up
    ```

2. 再次查看，多了两个IP

    ```sh
    root@default:~# ifconfig

    eth1      Link encap:Ethernet  HWaddr 08:00:27:76:1D:9B  
            inet addr:192.168.99.100  Bcast:192.168.99.255  Mask:255.255.255.0
            inet6 addr: fe80::a00:27ff:fe76:1d9b/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:2258 errors:0 dropped:0 overruns:0 frame:0
            TX packets:1685 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:207033 (202.1 KiB)  TX bytes:209587 (204.6 KiB)

    eth1:0    Link encap:Ethernet  HWaddr 08:00:27:76:1D:9B  
            inet addr:192.168.99.10  Bcast:192.168.99.255  Mask:255.255.255.0
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

    eth1:1    Link encap:Ethernet  HWaddr 08:00:27:76:1D:9B  
            inet addr:192.168.99.11  Bcast:192.168.99.255  Mask:255.255.255.0
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
    ```

3. 运行容器，指定IP
    > 这里的示例容器开启的SSH服务，后面拿它测试

    ```sh
    docker run -d -p 192.168.99.10:222:22 --name ssh1 gudaoxuri/scala-2.11-env
    docker run -d -p 192.168.99.11:222:22 --name ssh2 gudaoxuri/scala-2.11-env
    ```
