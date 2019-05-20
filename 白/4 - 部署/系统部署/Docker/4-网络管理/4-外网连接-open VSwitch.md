# 外网连接

Docker 默认使用的是 Linux 自带的网桥实现
实际上，OpenvSwitch 项目作为一个成熟的虚拟交换机实现，具备更丰富的功能。

## OpenSwitch

> 开源，使用GRE隧道技术，可以通过再次封装实现跨设备交互

### 安装 OpenvSwitch

通过如下命令安装 OpenvSwitch。

`sudo yum install openvswitch-switch`

### 测试添加一个网桥 `br0` 并查看。

`sudo ovs-vsctl add-br br0`
`sudo ovs-vsctl show`

```bash
20d0b972-e323-4e3c-9e66-1d8bb57c7ff5
    Bridge ovs-br
        Port ovs-br
            Interface br0
                type: internal
    ovs_version: "2.0.2"
```

### 配置容器连接到 OpenvSwitch 网桥

   目前 `OpenvSwitch` 网桥还不能直接支持挂载容器,需要手动在 `OpenvSwitch` 网桥上创建虚拟网口并挂载到容器中。

1. 创建无网口容器

 启动一个 ubuntu 容器，并指定不创建网络，后面手动添加网络。
 > 较新版本的 Docker 默认不允许在容器内修改网络配置，需要在 `run` 的时候指定参数 `--privileged=true`

 `sudo docker run --net=none --privileged=true -it ubuntu:14.04 bash`

 容器的 id 为 298bbb17c244。

此时在容器内查看网络信息，只能看到一个本地网卡 lo。

    ```bash
    root@298bbb17c244:/# ifconfig
    lo        Link encap:Local Loopback  
            inet addr:127.0.0.1  Mask:255.0.0.0
            inet6 addr: ::1/128 Scope:Host
            UP LOOPBACK RUNNING  MTU:65536  Metric:1
            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
            TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:0 
            RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
    ```

2. 手动为容器添加网络

- 下载 `OpenvSwitch` 项目提供的支持 `Docker` 容器的辅助脚本 `ovs-docker`

 `wget https://github.com/openvswitch/ovs/raw/master/utilities/ovs-docker`
 `sudo chmod a+x ovs-docker`

- 为容器添加网卡，并挂载到 `br0` 上，命令为

 `sudo ./ovs-docker add-port br0 eth0 298bbb17c244`

- 添加成功后，在容器内查看网络信息，多了一个新添加的网卡 `eth0`，但是默认并没有 IP 地址。

    ```bash
    root@298bbb17c244:/# ifconfig
    eth0      Link encap:Ethernet  HWaddr 7e:df:97:ac:1a:6a  
            inet6 addr: fe80::7cdf:97ff:feac:1a6a/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:22 errors:0 dropped:0 overruns:0 frame:0
            TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:3197 (3.1 KB)  TX bytes:508 (508.0 B)
    ```

- 手动给它添加一个，例如 `172.17.0.2/16`，并查看。

    ```bash
    root@298bbb17c244:/# ifconfig eth0 172.17.0.2/16
    root@298bbb17c244:/# ifconfig
    eth0      Link encap:Ethernet  HWaddr ae:3d:75:2c:18:ba  
            inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
            inet6 addr: fe80::ac3d:75ff:fe2c:18ba/64 Scope:Link
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:187 errors:0 dropped:2 overruns:0 frame:0
            TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000 
            RX bytes:33840 (33.8 KB)  TX bytes:1170 (1.1 KB)
    ```

- 在容器外，配置 `OpenvSwitch` 的网桥 br0 内部接口地址为 `172.17.42.2/16`
  > 只要与所挂载容器 IP 在同一个子网内即可

 `sudo ifconfig br0 172.17.42.2/16`

 > 也可以在另一个容器中接入`br0` ,进行互相通信

- 测试连通

 经过上面步骤，容器已经连接到了网桥 `br0` 上了，拓扑如下所示。

 `容器（172.17.0.2/16）<--> br0 网桥 <--> br0 内部端口（172.17.42.2/16）`

 此时，在容器内就可以测试是否连通到网桥 `br0` 上了。

 `root@298bbb17c244:/# ping 172.17.42.2`

- 在容器内也可以配置默认网关为 `br0` 接口地址。

`root@298bbb17c244:/# route add default gw 172.17.42.2`

- 删除该接口的命令为

 `sudo ./ovs-docker del-port br0 eth0 <CONTAINER_ID>`

> 在 Docker 原生支持 OpenvSwitch 之前，可以通过编写脚本或更高级的工具来让这一过程自动化。
