# 启动YARN集群

`[hadoop@hadoop-nn ~]$start-yarn.sh`

YARN集群启动完成后，可在各节点以`jps`命令等验证各进程是否正常运行。

hadoop-master：

```bash
[hadoop@c0a80a5b logs]$jps
4120 DataNode
1898 NameNode
2474 SecondaryNameNode
2922 NodeManager
2701 ResourceManager
5646 Jps
```

```bash
[hadoop@hadoop-snn ~]$ jps
10415 NodeManager
11251 Jps
9984 DataNode
hadoop-dn-01：
```

hadoop-dn-01：

```bash
[hadoop@hadoop-dn-01 ~]$ jps
10626 NodeManager
10020 DataNode
11423 Jps
```

通过JPS命令和开启的端口基本可以看出ResourceManager、NodeManager进程都各自启动。另外，NodeManager会在对应的DataNode节点都启动。

通过`ResourceManager`节点的`http://hadoop-nn:8088`访问`Web UI`界面：

`YARN`集群管理命令`YARN`命令有许多子命令，大体可分为用户命令和管理命令两类。

## 直接运行`yarn`命令，可显示其简单使用语法及各子命令的简单介绍(常见图)

这些命令中`jar、application、node、logs、classpath和version`是常用的用户命令

而`resourcemanager、nodemanager、proxyserver、rmadmin和daemonlog`是较为常用的管理类命令。
