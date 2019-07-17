## 启动默认的服务

Kali Linux自带了几个网络服务，但是默认是禁用的。

1. 启动Apache服务

    `root@kali:~# service apache2 start`

    输出信息如下所示：
    `[ok] Starting web server: apache2.`

> 为了确认服务是否正在运行，可以在浏览器中访问本地的地址。

2. 启动Secure Shell（SSH）服务

    `root@kali:~# service ssh start`

    输出信息如下所示：
    `[ok] Starting OpenBSD Secure Shell server: sshd.`
    
    看到以上的输出表示`SSH`服务已经启动。
    
    >为了确认服务的端口是否被监听，执行如下所示的命令：
    `root@kali:~# netstat -tpan | grep 22`
    `tcp  0   0 0.0.0.0:22     0.0.0.0:*       LISTEN   7658/sshd`
    `tcp6 0   0 :::22           :::*           LISTEN   7658/sshd`

3. 启动FTP服务
    `FTP`服务默认是没有安装的，所以首先需要安装FTP服务器。
    
    在`Kali Linux`操作系统的软件源中默认没有提供FTP服务器的安装包，这里需要配置一个软件源。配置软件源的具体操作步骤如下所示。
    
    安装FTP服务器。执行命令如下所示：
    `root@kali:~# apt-get install pure-ftpd`
    
    安装成功FTP服务器，就可以启动该服务了。执行命令如下所示：
    `root@kali:~# service pure-ftpd start`
