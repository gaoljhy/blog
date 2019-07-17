# 六、启动Hadoop集群

启动Hadood集群的方法有两种：

1. 在各节点分别启动需要启动的服务
2. 是在master节点启动整个集群（推荐方法）

----

## 分别启动方式

`Master`节点需要启动`HDFS`的`NameNode`、`SecondaryNameNode`、`DataNode`服务，以及`YARN`的`ResourceManager`服务。

```bash
[hadoop@hadoop-nn ~]$hadoop-daemon.sh start namenode
[hadoop@hadoop-nn ~]$hadoop-daemon.sh start secondarynamenode
[hadoop@hadoop-nn ~]$hadoop-daemon.sh start datanode
[hadoop@hadoop-nn ~]$yarn-daemon.sh start resourcemanager
```

各`Slave`节点需要启动`HDFS`的`DataNode`服务，以及`YARN`的`NodeManager`服务。

```bash
[hadoop@hadoop-nn ~]$hadoop-daemon.sh start datanode
[hadoop@hadoop-nn ~]$yarn-daemon.sh start nodemanager
```

## 集群启动方式

集群规模较大时，分别启动各节点的各服务过于繁琐和低效，为此，`Hadoop`专门提供了`start-dfs.sh`和`stop-dfs.sh`来启动及停止整个`hdfs`集群
以及`start-yarn.sh`和`stop-yarn.sh`来启动及停止整个yarn集群。

```bash
[hadoop@hadoop-nn ~]$start-dfs.sh
[hadoop@hadoop-nn ~]$start-yarn.sh
```

> 较早版本的Hadoop会提供`start-all.sh`和`stop-all.sh`脚本来统一控制`hdfs`和`mapreduce`，但`Hadoop 2.0`及之后的版本不建议再使用此种方式。

### 启动HDFS集群

`start-dfs.sh`

HDFS集群启动完成后，可在各节点以`jps`命令等验证各进程是否正常运行，也可以通过`Web UI`来检查集群的运行状态。

- 查看NameNode节点启动的进程：
hadoop-nn：

```bash
[hadoop@hadoop-nn ~]$ jps
14576 NameNode
14887 SecondaryNameNode
14714 DataNode
15018 Jps
```

`[hadoop@hadoop-nn ~]$ netstat -anplt | grep java`

- 查看DataNode节点启动进程：

hadoop-dn-01：

```bash
[hadoop@hadoop-dn-01 ~]$ jps
741 DataNode
862 Jps
```


`[hadoop@hadoop-snn ~]$ netstat -anplt | grep java`

hadoop-dn-02：

```bash
[hadoop@hadoop-dn-02 ~]$ jps
410 DataNode
539 Jps
```

通过JPS命令和开启的端口基本可以看出

1. `NameNode、SecondaryNameNode、DataNode`进程各自开启的对应端口
2. 可以看到`DataNode`都正常连接到了`NameNode`的`8020`端口。

## 注意

如果相关节点起不来

1. 可能是权限不对
2. 相关目录没有创建
3. 具体可以看相关节点的日志：`/usr/local/hadoop/logs/*.log`

## 可通过`NameNode`节点的`http://hadoop-nn:50070`访问Web UI界面：

1. 可以看到3个`DataNode`节点都运行正常。
2. 此时其实HDFS集群已经好了，就可以往里面存储数据了

下面简单使用HDFS命令演示一下：

- 在HDFS集群创建目录：

 `[hadoop@hadoop-nn ~]$ hdfs dfs -mkdir /test`

 如果出现报错：`mkdir: Cannot create directory /test. Name node is in safe mode.`
 则需要执行命令：

 `[hadoop@hadoop-nn ~]$ hadoop dfsadmin -safemode leave`

- 上传文件到HDFS集群：

 `[hadoop@hadoop-nn ~]$ hdfs dfs -put /etc/fstab /test/fstab`
 `[hadoop@hadoop-nn ~]$ hdfs dfs -put /etc/init.d/functions /test/functions`

- 查看HDFS集群的文件：

`[hadoop@hadoop-nn ~]$ hdfs dfs -ls /test/`

然后再看一下Hadoop Web UI界面：

可以看到Blocks字段，在所有节点共占用4个块，HDFS默认未64M一个块大小。
由于上传的文件太小，所以也没有做切割
再启动集群时设置的是2个副本，所以这里就相当于存储了两份。

HDFS集群管理命令(参见图)
