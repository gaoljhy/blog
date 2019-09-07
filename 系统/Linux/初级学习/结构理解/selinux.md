SELinux(Security-Enhanced Linux)
=============
是美国国家安全局（NSA）对于强制访问控制的实现，是 `Linux`历史上最杰出的新安全子系统。
> 但是一般都不用它，因为它管的东西太多了，想做安全可以用防火墙等其他措施。

通过查看配置文件的命令 `cat /etc/selinux/config` 来查看状态，

发现`SELinux`共有3个状态

1. `enforcing` （执行中）
2. `permissive` （不执行但产生警告）
3. `disabled`（关闭）

可以通过修改配置文件来修改SELinux的状态

> 最后重启服务器，SELinux状态由enforcing变为disabled 。 

当然，一般的Linux都不能重启，
可以使用这个命令 `setenforce 1 `临时（重启即失效）

1. 设置`SELinux` 成为enforcing模式（`setenforce 0` 设置SELinux 成为`permissive`模式）

2. 用`getenforce`这个命令来检查。
