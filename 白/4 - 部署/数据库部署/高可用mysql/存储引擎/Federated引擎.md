# Federated

## 特点

1. 提供远程访问 `MySQL`服务器 **表** 的方法
2. 本地不储存数据,数据全在远程服务器上
3. 本地会保存表结构`.frm`和远程服务器的连接信息

>  `MySQL`数据引擎层 默认是没有使用远程数据文件
>> SQL server,Oracle有

## 使用

> 默认禁止,启用时需要在`my.cnf`增加`federated`参数

`mysql://usr_name[:password]@host[:port]/db_name/table_name`

如: 

```sql
# 本地数据库

 CREATE TABLE `local` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT 'zyg',
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


# 远程数据库

CREATE TABLE `remote` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT 'zyg',
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=FEDERATED DEFAULT CHARSET=utf8 CONNECTION='mysql://root:123456@localhost:3306/remote/local'

```

> 所有操作俩个库都会同步发生变化

## 使用场景

不适合生产环境

检查排查,手工查询分析使用