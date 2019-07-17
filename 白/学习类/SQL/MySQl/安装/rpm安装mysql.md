rpm 安装 mysql
==========

1.检查是否预安装了MYSQL
------------------

[root@lgr ~]# rpm -qa | grep -i mysql

perl-DBD-MySQL-4.013-3.el6.x86_64

mysql-connector-odbc-5.1.5r1144-7.el6.x86_64

mysql-devel-5.1.71-1.el6.x86_64

MySQL-python-1.2.3-0.3.c1.1.el6.x86_64

mysql-5.1.71-1.el6.x86_64

mysql-server-5.1.71-1.el6.x86_64

mysql-libs-5.1.71-1.el6.x86_64

2.移除预安装的MYSQL
------------------

rpm -e mysql-server-5.1.71-1.el6.x86_64 --nodeps

rpm -e mysql-devel-5.1.71-1.el6.x86_64 --nodeps

rpm -e mysql-5.1.71-1.el6.x86_64 --nodeps

rpm -e mysql-connector-odbc-5.1.5r1144-7.el6.x86_64 --nodeps

rpm -e MySQL-python-1.2.3-0.3.c1.1.el6.x86_64 --nodeps

rpm -e perl-DBD-MySQL-4.013-3.el6.x86_64 --nodeps

rpm -e mysql-libs-5.1.71-1.el6.x86_64 --nodeps

rm -rf /var/lib/mysql*

rm -rf /usr/share/mysql*

userdel mysql 

3.创建安装包上传目录
------------------

    [root@lgr ~]# mkdir -p /usr/local/mysql

4.上传安装包到mysql目录
------------------

   --上传过程略--

5.创建用户和组
------------------

    [root@lgr ~]# groupadd -g 1000 mysql

    [root@lgr ~]# useradd mysql -g mysql -p mysql

6.解压缩安装包
------------------

    [root@lgr mysql]# tar -xvf MySQL-5.6.35-1.linux_glibc2.5.x86_64.rpm-bundle.tar

    MySQL-devel-5.6.35-1.linux_glibc2.5.x86_64.rpm

    MySQL-test-5.6.35-1.linux_glibc2.5.x86_64.rpm

    MySQL-shared-5.6.35-1.linux_glibc2.5.x86_64.rpm

    MySQL-shared-compat-5.6.35-1.linux_glibc2.5.x86_64.rpm

    MySQL-server-5.6.35-1.linux_glibc2.5.x86_64.rpm

    MySQL-embedded-5.6.35-1.linux_glibc2.5.x86_64.rpm

    MySQL-client-5.6.35-1.linux_glibc2.5.x86_64.rpm

7.安装mysql，只需要安装如下包
------------------

 ##Server包：

    [root@lgr mysql]# rpm -ivh MySQL-server-5.6.35-1.linux_glibc2.5.x86_64.rpm

 ##Client包：

    [root@lgr mysql]# rpm -ivh MySQL-client-5.6.35-1.linux_glibc2.5.x86_64.rpm

 ##库函数包：

    [root@lgr mysql]# rpm -ivh MySQL-devel-5.6.35-1.linux_glibc2.5.x86_64.rpm

    [root@lgr mysql]# rpm -ivh MySQL-shared-5.6.35-1.linux_glibc2.5.x86_64.rpm

8.查看进程、端口是否启动
------------------

    [root@lgr ~]# ps -ef|grep mysqld       ##查看mysqld进程是否启动

    [root@lgr ~]# netstat -an |grep :3306  ##查看端口是否正常，LISTEN 为正常状态

> 如果没有开启，运行：service mysql start

9.登录mysql，修改root密码
------------------

    [root@lgr ~]# mysqladmin -u root -p password

    ##root  ---用户名

10.登录MySQL数据库
---------------

    [root@lgr ~]# mysql -u root -p

注意
---------------

    1. 安装 一个 rpm 时，会提示所需要先安装的哪些rpm包
    2. 先安装 需要的才可以安装 后面的