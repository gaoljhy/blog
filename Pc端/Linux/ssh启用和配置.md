## 一般系统会自带`ssh`,没有的话用自带包管理器，或者从官网下载，编译安装 

> 记得删除原文件

1. `sudo apt-get install openssh-server`

2. `./config`<br>
    `make `<br>
    `make install`

-------

## 服务命令操作 该服务

`sudo service ssh start`

`sudo service ssh reload`

`sudo service ssh restart`

`sudo service ssh stop`






------

## 任务查看 是否启动 

`sudo ps -e | grep ssh` 查到 `sshd` 就算启动成功


------
## 配置


1. 打开默认配置文件<br>
    `sudo leafpad /etc/ssh/sshd_config`

2. 对应操作(默认忽略大小写)<br>

   |设置项|所设值| 注解|
   |:-----:|:-----:|:-----|
   |`Host`|　`*`|　`Host`只对 能够匹配后面字串的计算机有效。`*`表示所有的计算机。　
   |`Port`|`　22　 `|`Port`设置`sshd`监听的端口号
   |`PermitRootLogin`|`yes`|设置是否允许以`root`用户登录
   |`AllowUsers`　|`admin　`|设置所允许登陆用户
    |`ForwardAgent`|`　no　 `|转发代理设置
    |`ForwardX11`　|`no`|　 `ForwardX11`设置`X11`连接是否被自动重定向到安全的通道和显示集（DISPLAY　set）。　
   

### 大型 `ssh` 服务器其他常用安全设置
``` 
# HostKey 设置包含计算机用户私人密匙的文件。　
   HostKey 　/etc/ssh/ssh_host_key　`

# ListenAddress 设置 sshd 服务器绑定的 IP 地址。　
    ListenAddress 192.168.1.1 

# 认证证书类
# 启用`RSA`认证
    RhostsAuthentication　no　 
    RhostsRSAAuthentication　no　 
    RSAAuthentication　yes　 
# 密码认证等
    PasswordAuthentication　yes　 
    PermitEmptyPasswords　no　 
```
