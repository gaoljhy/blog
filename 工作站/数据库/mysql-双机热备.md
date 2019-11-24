# 双机热备


name: 
    mysql_1
Volume:
    - /home/lemon/Mariadb/master1:/etc/mysql
    - mariadb_master_1:/var/lib/mysql
enoviment:
    - MYSQL_ROOT_PASSWORD: Fq7C67%D
network:
    ip:172.18.1.2


name: 
    mysql_2
Volume:
    - /home/lemon/mysql/mysql_2:/etc/mysql/conf.d
    - mariadb_master_2:/var/lib/mysql
enoviment:
    - MYSQL_ROOT_PASSWORD: Fq7C67%D
network:
    ip:172.18.1.3

--------------

## mysql1

> 得得配置在my.conf中

```conf
[mysqld]
server_id = 1
log-bin= mysql-bin

replicate-ignore-db=mysql
replicate-ignore-db=sys
replicate-ignore-db=information_schema
replicate-ignore-db=performance_schema

read-only=0
relay_log=mysql-relay-bin
log-slave-updates=on
auto-increment-offset=1
auto-increment-increment=2

```

## mysql2

```conf
[mysqld]
server_id = 2
log-bin= mysql-bin

replicate-ignore-db=mysql
replicate-ignore-db=sys
replicate-ignore-db=information_schema
replicate-ignore-db=performance_schema

read-only=0
relay_log=mysql-relay-bin
log-slave-updates=on
auto-increment-offset=2
auto-increment-increment=2
```

-------------

# 添加用户

## mysql1

> master配置

### 创建用户

创建一个用户来同步数据
这里表示创建一个slave同步账号slave , % 为所有通配符匹配所有ip

```sql
create user 'slave'@'%' identified by 'A9o5p8!V';
grant REPLICATION SLAVE on *.* to 'slave'@'%' ;
ALTER USER 'slave'@'%' IDENTIFIED WITH mysql_native_password BY 'A9o5p8!V';
//高版本去掉动态验证方式

FLUSH PRIVILEGES;
select * from mysql.user;

//查看状态，记住File、Position的值，在mysql2中将用到
show master status;
```

> | File          | Position |
> | binlog.000003 |     1382 |

### 进入mysql2 配置

```sql
//设置主库链接
// master_host即为容器IP
// master_log_file和master_log_pos即为在mone容器中，通过show master status查出来的值；

change master to master_host='172.18.1.2',master_user='slave',master_password='A9o5p8!V',master_log_file='binlog.000003',master_log_pos=1382,master_port=3306;

//启动同步
start slave ;
 
//查看状态
show master status;

```

## mysql2

> master配置 ,于mysql1一致


```sql
create user 'slave'@'%' identified by 'A9o5p8!V';
grant REPLICATION SLAVE on *.* to 'slave'@'%' ;
ALTER USER 'slave'@'%' IDENTIFIED WITH mysql_native_password BY 'A9o5p8!V';

FLUSH PRIVILEGES;
select * from mysql.user;

//查看状态，记住File、Position的值，在mysql2中将用到
    show master status;

```

> | File          | Position | 
> | binlog.000003 |      872 |

### 进入mysql1 配置

```sql

change master to master_host='172.18.1.3',master_user='slave',master_password='A9o5p8!V',master_log_file='binlog.000003',master_log_pos=872,master_port=3306;

//启动同步
start slave ;
 
//查看状态
show master status;

```


-------------------------


## 验证

配置完成之后，可以验证双主配置是否正确

`show slave status\G;`

> 有错误对应找问题

### 实操验证

mysql1 

```sql
create database mone_demo;
use mone_demo;
create table userinfo(username varchar(50),age int);
insert into userinfo values('Tom',18);
select * from userinfo;
```

mysql2

```sql
show databases;
use mone_demo;
select * from userinfo;
insert into userinfo values('mtwo',20);
select * from userinfo;
```

### 删除

```sql
drop database mone_demo;
```