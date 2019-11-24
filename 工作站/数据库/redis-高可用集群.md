# redis

1. redis 集群需要至少三个节点（因为领导者选举需要至少一半加1个节点，奇数个节点可以在满足该条件的基础上节省一个节点）
2. 搭建三个主节点，每个主节点下面在提供一个从节点，共6个 redis 节点（三主三从）。

> tip：这里我们使用 docker 搭建在同一台服务器上，实际使用时肯定是不同的服务器，不然没有意义（Redis 版本 5.0.3）。

## 主redis

（为了测试是否可以使用Docker 来 搭建 Redis，可以跳过）
由 docker 仓库中拉取相应的 Redis 镜像

`docker pull redis:5.0.3`


创建文件夹
/usr/local/redis/conf
/usr/local/redis/data
conf 存放配置文件目录，data 存放映射数据目录

修改 redis 配置文件，设置密码(获取的linux下安装后的配置文件)。

requirepass 123456


编写 docker-compose-redis.yaml [数据映射、配置文件映射] 启动镜像:

```yaml
version: "3.4"
services:
  redis:
    image: redis:5.0.3
    container_name: redis5-m1
    command: redis-server /etc/redis/redis.conf
    ports:
      - "6379:6379"
    volumes:
      - ./data:/data
      - ./conf/redis.conf:/etc/redis/redis.conf
```

docker-compose 命令启动

`docker-compose -f docker-compose-redis.yaml up -d`


启动后，测试是否可以正常访问。

## 集群搭建

    创建对应的文件夹
    在 /usr/local/redis-cluster 下创建6个文件夹 6388 6389 6378 6379 6368 6369，每个文件夹下都创建 conf、data 目录。
    编辑配置文件

    端口、密码、集群密码、节点信息文件配置（按需修改）
    （1）绑定端口，port 63xx (对应文件夹名称)
    （2）绑定IP，bind 192.168.2.128 or 0.0.0.0
    （3）指定数据存放路径，dir /usr/local/redis-cluster/7031
    （4）启动集群模式，cluster-enabled yes
    （5）指定集群节点配置文件，cluster-config-file nodes-7031.conf
    （6）后台启动，daemonize yes
    （7）指定集群节点超时时间，cluster-node-timeout 5000
    （8）指定持久化方式，appendonly yes # 这是AOF 持久化，按需要选择是否开启

前5项建议修改，63xx 最好指定为文件夹名称，将63xx的redis.conf改完后再拷贝到剩下的5个目录中，然后只要全局替换redis.conf中的 port 为相应的节点即可。
注意，如果是docker运行不要设置后台运行（ daemonize ），否则运行后直接退出，因为没有前台线程。且无需指定数据存放路径，通过文件映射出来即可。

    启动这6个容器
    使用 docker-compose 一键启动：
    x-xxx 指定了全局变量，后面对应的 xxx 引用
    需要设置：network_mode: host （参考后面解释）

```yaml
version: "3.4"

x-image:
  &default-image
  redis:5.0.3
x-restart:
  &default-restart
  always
x-command:
  &default-command
  redis-server /etc/redis/redis.conf      
x-netmode:
  &default-netmode
  host

services:
  redis1:
    image: *default-image
    restart: *default-restart
    container_name: redis5-m1
    command: *default-command
    volumes:
      - ./6368/data:/data
      - ./6368/conf/redis.conf:/etc/redis/redis.conf
    network_mode: *default-netmode
  
  redis2:
    image: *default-image
    restart: *default-restart
    container_name: redis5-m2
    command: *default-command
    volumes:
      - ./6378/data:/data
      - ./6378/conf/redis.conf:/etc/redis/redis.conf
    network_mode: *default-netmode
  
  redis3:
    image: *default-image
    restart: *default-restart
    container_name: redis5-m3
    command: *default-command
    volumes:
      - ./6388/data:/data
      - ./6388/conf/redis.conf:/etc/redis/redis.conf
    network_mode: *default-netmode

  redis4:
    image: *default-image
    restart: *default-restart
    container_name: redis5-s1
    command: *default-command
    volumes:
      - ./6369/data:/data
      - ./6369/conf/redis.conf:/etc/redis/redis.conf
    network_mode: *default-netmode

  redis5:
    image: *default-image
    restart: *default-restart
    container_name: redis5-s2
    command: *default-command
    volumes:
      - ./6379/data:/data
      - ./6379/conf/redis.conf:/etc/redis/redis.conf
    network_mode: *default-netmode   
    
  redis6:
    image: *default-image
    restart: *default-restart
    container_name: redis5-s3
    command: *default-command
    volumes:
      - ./6389/data:/data
      - ./6389/conf/redis.conf:/etc/redis/redis.conf
    network_mode: *default-netmode   

```

启动命令：

`docker-compose -f  docker-compose-redis.yaml up -d`


查看启动的服务：
在这里插入图片描述

## 用redis-cli创建整个redis集群
(redis5以前的版本集群是依靠ruby脚本redis-trib.rb实现)
可以下载一个redis-cli镜像： goodsmileduck/redis-cli:v5.0.3

docker run --rm -it goodsmileduck/redis-cli:v5.0.3 redis-cli -a 123456 --cluster-replicas 1 --cluster create 192.168.6.181:6369 192.168.6.181:6379 192.168.6.181:6389 192.168.6.181:6368 192.168.6.181:6378 192.168.6.181:6388

# -a 表示连接密码
# --cluster-replicas 1 表示 一主一从
# --cluster create 后面表示需要集群的redis主机和端口


在这里插入图片描述
出现的问题1：
  一直显示等待加入 （Waiting for the cluster to join…）
猜测原因：
  redis集群不仅需要开通redis客户端连接的端口，而且需要开通集群总线端口，集群总线端口为redis客户端连接的端口 + 10000。如redis端口为7001，则集群总线端口为17001。
解决方法：
  端口映射 6378:6379, 16378:16379
结果：
  无效
实际原因：
  当前Cluster尚不支持NATted环境，在一般环境中IP地址或者port会重新映射（remapped）。Docker使用了一种称为“port mapping”技术：在Docker容器内运行的程序使用的端口，将以另一个端口的方式暴露出去（Docket的宿主环境）。这可以允许一个Server（物理环境）上允许多个Docker容器，而且每个容器内的程序可以使用相同的端口。为了让Redis Cluster与Docker机制兼容，Docker需要使用“host networking mode”，具体信息请参考Dorcker文档。
真正解决：
  网络模式改成host，docker run 的方式加上–net host，docker-compose方式加上network_mode: host。

出现的问题2：
  提示节点不为空

Node 192.168.6.181:6369 is not empty. Either the node already knows other nodes (check with CLUSTER NODES) or contains some key in database 0


原因：
  该节点下面存在数据，新增的集群下面不能存有数据
解决方法：
1).将需要新增的节点下 aof、rdb 等本地备份文件删除；
2).同时将新Node的集群配置文件删除，即：删除 redis.conf 里面 cluster-config-file 所在的文件；
3).再次添加新节点如果还是报错，则登录新Node，对数据库进行清除

# 登录 redis-cli
./redis-cli–h x –p
# 清空当前数据库
172.168.63.201:7001>  flushdb


    连接任意一个客户端，设置数据

# 连接 181:6368 客户端
docker run --rm -it goodsmileduck/redis-cli:v5.0.3 redis-cli -c -h 192.168.6.181 -p 6368 -a 123456


注意原本是 6368，然后变成了 6369 （解释见后文）
在这里插入图片描述
RedisDesktopManager 查看：
在这里插入图片描述
cluster info 查看集群信息:
在这里插入图片描述
cluster nodes 查看节点信息（0-5460,5461-10922,10923-16383 表示各哈希槽区间）：
在这里插入图片描述
6. 高可用测试
  我们关闭一个主节点容器，重新调用查询命令，提示一个失去连接，且其对应的从节点被投票选举为新的主节点，之前的主节点被更换为从节点（发现主从地址未改变，因为当客户端试图连接失效的主服务器时, 集群会向客户端返回新主服务器的地址, 使得集群可以使用新主服务器代替失效服务器）
在这里插入图片描述
重新启动该节点，再次调用查询命令，发现其已成功连接到了集群中，恢复原样
在这里插入图片描述
至此，Redis 集群搭建完毕。