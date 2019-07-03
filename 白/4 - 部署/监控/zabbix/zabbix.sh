echo "
TYPE=Ethernet
BOOTPROTO=none
IPADDR=X.X.X.X
PREFIX=24
GATEWAY=X.x.x.x
NAME=ens33
DEVICE=ens33
ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-ens33 

clear
nmcli conn reload
nmcli conn up ens33

ping 10.100.100.252

systemctl stop firewalld
systemctl disable firewalld
systemctl mask firewalld
iptables -F

mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
ls /etc/yum.repos.d/

echo "
[centos]
name=centos
baseurl=ftp://10.100.100.252/software/centos7.6
enabled=1
gpgcheck=0" > /etc/yum.repos.d/centos.repo

yum repolist

hostnamectl set-hostname zabbix-server.linux.com
ntpdate 10.100.100.252
date

yum install -y httpd php php-gd gd mariadb-server php-mysql 


systemctl start httpd mariadb
systemctl enable httpd mariadb

netstat -antp | grep :80
netstat -antp | grep :3306


echo "
<?php
   phpinfo();
?>" > /var/www/html/test.php


#############################创建数据库

# mysql -uroot

# create database zabbix charset utf8;
# grant all on zabbix.* to 'admin'@'localhost' identified by 'redhat';
# flush privileges;
# exit

#############################；




echo "
[zabbix34]
name=zabbix34
baseurl=ftp://10.100.100.252/software/zabbix3.4
enabled=1
gpgcheck=0" > /etc/yum.repos.d/zabbix34.repo

yum install zabbix-server-mysql zabbix-web-mysql 

cd /usr/share/doc/zabbix-server-mysql-3.4.11/

zcat create.sql.gz | mysql -uroot zabbix 

#############################zabbix conf设置

# vim /etc/zabbix/zabbix_server.conf 

# 91 DBHost=localhost
# 101 DBName=zabbix
# 117 DBUser=admin
# 	DBPassword=redhat
# 132 DBSocket=/var/lib/mysql/mysql.sock

#############################；

systemctl start zabbix-server
systemctl enable zabbix-server
netstat -antp | grep zabbix

#############################zabbix 时区设置

# vim /etc/httpd/conf.d/zabbix.conf 

#         php_value date.timezone Asia/shanghai

#############################；


systemctl restart httpd