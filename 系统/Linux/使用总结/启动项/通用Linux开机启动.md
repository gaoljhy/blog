# linux 开机启动项

## 找对应的 运行 level

`rc0.d/ rc1.d/ rc2.d/ rc3.d/ rc4.d/ rc5.d/ rc6.d/ rcS.d/`

写入内容

## 编辑文件 /etc/rc.local

输入命令：`vim /etc/rc.local` 将出现类似如下的文本片段：

```conf
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

touch /var/lock/subsys/local
/etc/init.d/mysqld start #mysql开机启动
/etc/init.d/nginx start #nginx开机启动
/etc/init.d/php-fpm start #php-fpm开机启动
/etc/init.d/memcached start #memcache开机启动

#在文件末尾（exit 0之前）加上你开机需要启动的程序或执行的命令即可（执行的程序需要写绝对路径，添加到系统环境变量的除外），如：

/usr/local/thttpd/sbin/thttpd  -C /usr/local/thttpd/etc/thttpd.conf
```

## 写一个shell脚本

将写好的脚本 `.sh`文件 放到目录 `/etc/profile.d/` 下
系统启动后就会自动执行该目录下的所有shell脚本

----

## 通过`chkconfig`命令设置

> debian类linux 里没有对应命令

### `chkconfig --add 脚本文件名`

将启动脚本文件`cp`到 `/etc/init.d/`或者`/etc/rc.d/init.d/`（前者是后者的软连接）下

vim 启动脚本文件，文件前面务必添加如下三行代码，否侧会提示`chkconfig`不支持

```conf
#!/bin/sh 告诉系统使用的shell,所以的shell脚本都是这样
#chkconfig: 35 20 80 分别代表运行级别，启动优先权，关闭优先权，此行代码必须
#description: http server（自己随便发挥）//两行都注释掉！！！，此行代码必须
```

`chkconfig --add 脚本文件名` 操作后就已经添加了

> 让`chkconfig`指令得以管理它，并同时在系统启动的叙述文件内增加相关数据。

`chkconfig  --del 任务` 删除，不再由chkconfig管理

`chkconfig` 查看 启动任务

`chkconfig 任务 on/off` 启动关闭