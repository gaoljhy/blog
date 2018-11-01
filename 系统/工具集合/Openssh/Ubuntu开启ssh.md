## ubuntu开启SSH服务

SSH分客户端`openssh-client`和`openssh-server`

1. 如果只是想登陆别的机器的SSH只需要安装`openssh-client`
> ubuntu有默认安装，如果没有则`sudo apt-get install openssh-client`

2. 如果要使本机开放SSH服务就需要安装`openssh-server`
> `sudo apt-get install openssh-server`

然后确认sshserver是否启动了：
`ps -e |grep ssh`
1. 如果看到sshd那说明`ssh-server`已经启动了。

2. 如果没有则可以这样启动：`sudo /etc/init.d/ssh start` 或者 `service ssh start`

-----------------------------------------------

`ssh-server`配置文件位于`/etc/ssh/sshd_config`
> 在这里可以定义SSH的服务端口，默认端口是22，可以自己定义成其他端口号

然后重启SSH服务：
`sudo /etc/init.d/ssh stop`
`sudo /etc/init.d/ssh start`

然后使用以下方式登陆SSH：
`ssh username@192.168.1.112 username`为192.168.1.112 机器上的用户，需要输入密码。
