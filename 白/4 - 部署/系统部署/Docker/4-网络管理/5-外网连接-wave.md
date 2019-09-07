# 外网连接

> Docker的原生网络支持非常有限，且没有跨主机的集群网络方案。

目前实现Docker网络的开源方案有`Weave、Kubernetes、Flannel、Pipework以及SocketPlane`等，其中Weave被评价为目前最靠谱的，那么这里就对Weave的基本原理及使用方法做个总结。

## wave

### 简介

1. `Weave`是由Zett.io公司开发的，它能够创建一个虚拟网络，用于连接部署在多台主机上的Docker容器
2. 容器类似被接入了同一个网络交换机，那些使用网络的应用程序不必去配置端口映射和链接等信息。
3. 外部设备能够访问Weave网络上的应用程序容器所提供的服务，同时已有的内部系统也能够暴露到应用程序容器上。
4. Weave能够穿透防火墙并运行在部分连接的网络上，另外，Weave的通信支持加密，所以用户可以从一个不受信任的网络连接到主机。

### 安装与启动

- git安装

 `sudo wget -O /usr/local/bin/weave https://raw.githubusercontent.com/zettio/weave/master/weave`

 `sudo chmod a+x /usr/local/bin/weave`

- 启动`weave`路由器，这个路由器其实也是以容器的形式运行的。

 `weave launch`

此时会发现有两个网桥，一个是`Docker`默认生成的，另一个是`Weave`生成的。
 `drctl show`
 `docker ps -a` 中也包含`weave`容器

接下来就可以运行应用容器，使用`weave`提供的网络功能了。

------

### 简单使用

- 准备

1. 主机 host1: 10.0.2.6
2. 主机 host2: 10.0.2.8
3. host1上的应用容器1: 192.168.0.2/24 host1上的应用容器2: 192.168.1.2/24
4. host2上的应用容器1: 192.168.0.3/24

两台主机上均安装`Docker`及`Weave`，并均启动好`Weave`路由容器。

- 在两台机上均启动一个应用容器。

1. 可以直接使用`weave run`命令
2. 可以先使用`docker run`启动好容器，然后使用`weave attach`命令给容器绑定IP地址。

 `weave run 192.168.0.2/24 -itd ubuntu bash`

或者

 `docker run -itd ubuntu bash`
 `weave attach 192.168.0.2/24 $ID`

- 此时发现两个容器之间是不通的，需要使用`weave connect`命令在两台`weave`的路由器之间建立互相连接。

 `weave connect 10.0.2.8`

 此时位于两台不同主机上的容器之间可以相互ping通了。

> 但是处于不同子网的两个容器是不能互联的，这样就可以使用不同子网进行容器间的网络隔离了。

1. 如果不使用Docker的原生网络，在容器内部是不能访问宿主机以及外部网络的。
2. 此时可以使用`weave expose 192.168.0.1/24`来给`weave`网桥添加IP以实现容器与宿主机网络连通。
3. 但是，此时在容器内部依然不能访问外部网络。

------

1. 可以同时使用Docker的原生网络和weave网络来实现容器互联及容器访问外网和端口映射
2. 使用外部网络及端口映射的时候就使用`docker0`网桥，需要容器互联的时候就使用`weave`网桥。
3. 每个容器分配两个网卡。

## 其他特性

- 应用隔离：
  1. 不同子网容器之间默认隔离的，即便它们位于同一台物理机上也相互不通（使用`-icc=false`关闭容器互通）；
  2. 不同物理机之间的容器默认也是隔离的

- 安全性：
  可以通过`weave launch -password wEaVe`设置一个密码用于`weave peers`之间加密通信

- 查看weave路由状态：`weave ps`

## 问题:

- 容器重启问题

 1. 如果使用weave，则就不能再使用docker自带的`auto-restart feature`
    如`docker run –restart=always redis`
 2. 因为`weave`是在`docker`之外为容器配置的网络，容器重启的时候`docker`本身不会做这些事情。
 3. 因而，还需额外的工具来管理容器的状态（比如`systemd, upstart`等），这些工具要调用weave命令（`weave run/start/attach`）来启动容器
