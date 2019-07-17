# 工具简介

+ dsh - dancer's shell / distributed shell

dsh是专为在远程系统上运行shell命令设计的，可以简化对大量计算机的操作。尽管很方便，但是dsh有一个重大的缺陷：它无法复制文件。如果希望把数据部署到多台计算机上，就必须编写一个新脚本，利用发行版的基础设施（比如 rsync），或者考虑使用更健壮的工具（比如 Parallel SSH (pssh)）。

<http://xukaizijian.blog.163.com/blog/static/17043311920110319301199/>

+ pssh - Parallel ssh

与dsh一样，pssh的目标也是简化大量计算机的管理。除了具备dsh的所有功能之外，pssh还可以把文件从一组系统复制到中心服务器或反向复制，以及杀死一组系统上的进程。这个 shell 和它的底层库是用 Python 编写的，如果系统上已经安装了Python 解释器和核心库，就很容易安装它。

<http://www.ibm.com/developerworks/cn/aix/library/au-spunix_remoteserver/index.html>

+ pdsh

pdsh可以在指定的一组机器上执行同一个命令。pdsh软件包还自带了pdcp命令，可以将文件拷贝到一组机器上。

<http://scmbob.org/parallel-distributed-shell.html>

<http://linux.die.net/man/1/pdsh>

<http://bbs.chinaunix.net/thread-2002080-1-1.html>

+ ClusterSSH

Cluster SSH是一个可以用来通过SSH协议同时管理多台远程计算机的工具。它非常适合用来快速配置一个集群中的所有运行相同服务和具备相同配置的计算机节点。

<http://os.51cto.com/art/201103/250014.htm>

+ mussh

mussh是一款管理多主机的ssh软件，mussh可以让你把本地的脚本，在多台ssh目的机器上执行。

<http://rtxbc.blog.163.com/blog/static/1228936592010825105416832/>

+ Saltstack可以看做是func的增强版+的弱化版。使用Python编写。非常好用,快速可以基于EPEL部署。Salt 是一个开源的工具用来管理你的基础架构，可轻松管理成千上万台服务器。

<http://zhoulg.blog.51cto.com/48455/1140178>
