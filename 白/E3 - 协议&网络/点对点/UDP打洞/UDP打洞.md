# UDP打洞

## 网络模型

[UDP打洞网络模型](./UDP打洞网络模型.drawio)

## 实现通信

Client A 向 Client B 发送网络数据 ，首先需要向 Client B NAT 以后的公网地址发送数据

当知道Client B的公网地址以后，直接向 Client B的NAT地址发送数据，此时NAT B 将会无视进入的数据(除非是Full Cone NAT)，原因是此时Client B 监听的端口并未实现NAT 地址的暴露

> B向A发送网络数据请求时也是如此


## 基本流程
 
A 到 B 的 UDP 会化建立流程为

1. A，B分别建立到Server S的UDP会话，那么Server S此时是知道A，B各自外网ip + 端口
2. Server S在和B的UDP会话里告诉 A的地址(外网ip+端口)，同理 把B的地址(外网ip+端口) 告诉A
3. B向A地址发送一个握手 `UDP`包 ,打通 A-> B 的UDP 链路
4. 此时A 可以向B发送UDO包，建立会话完成


## 先决条件

1. A，B所在的NAT网络类型(Full cone, Restricted cone, Port-restricted cone, Symmetric NAT)
2. 在一次UDP会话期间，NAT设备(路由器)会保持内网进程 `inner_ip:inner_port <-> share_public:share_port` 的映射关系
    一般根据具体路由器实现，这个映射关系可以维持几分钟到几个小时不等
3. 流程中第3步，NAT A收到握手包后并不会转发给A，因为它发现自己没有保存过B的地址,认为这是一个来历不明的包而直接丢弃

> 然而这个包的作用在于NAT 留下A的记录，使得 NAT B 认为A是可达或者说是可通过的
> 这样A -> B再发送UDP包就可以真正到达B了，所以握手包 的作用是可以打通 A->B 的通路 是必要的

握手包是不会到达的，目的是为了对应NAT下的主机认为可以到达自身，进而，使得 主机连接自身

## 使用

由于UDP打洞实现简单，P2P采用UDP打洞比较多，当建立通路成功以后一般使用tcp进行节点间通信，完成更好的通信效果

因为udp打完成后形成的nat映射与TCP/UDP无关，所以此时可以转为使用tcp建立连接，达到最终的p2p的tcp通信