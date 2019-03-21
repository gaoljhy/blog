# 环境搭建

`iptables -F`
 关闭 网络管理

`setenforce 0`
 设置enforcing

----

## vsftpd

1. 安装 vsftpd
   1. `yum install vsftp`
2. 启动
   1. `systemctl start vsftpd`
3. 默认配置
   1. ftp 对应 `/var/ftp` 文件夹下的文件

clinet 测试

1. 从浏览器中访问
2. 下载`ftp`，连接测试
   1. `yum install ftp`
   2. 连接 ftp 服务器
      1. `ftp 服务器ip`
      2. 默认匿名用户 为 `ftp:ftp` ，**只能下载，没有上传修改权限**
      3. 操作指令 `?`查看所有命令 , `help` 查看帮助
         1. `get , recv` 下载
         2. `put , send` 上传
         3. `mget , mput`  多个文件上传，多个文件下载
         4. `lcd , cd` 本地cd ， 服务器cd
         5. 
3. 下载`lftp` ,连接测试
   1. `yum install lftp`
   2. 连接服务器后
      1. `lftp 服务器ip`
      2. `?` 查看命令 ，俩次 Tab 也可以 ，`help` 查看用法
      3. 可以 Tab 自动补齐
      4. `local cmd` 在本地执行 指令
      5. `user 用户` 切换用户
