# 双机热备

1. 拉取mariadb镜像

    `docker pull mariadb`

2. 创建好数据卷文件

    `mkdir /home/lxj/hedisql/data/master`

    `mkdir /home/lxj/hedisql/data/slave1`

3. 运行主容器

    `docker run --name mariadb_master -e MYSQL_ROOT_PASSWORD=123456 -v /home/lxj/heidisql/data/master:/var/lib/mysql --restart always -d mariadb`

3. 进入主容器执行(添加备份的账号)

    `docker exec -it master /bin/bash`

    `mysql -uroot -p123456`

    `MariaDB [(none)]> grant replication slave on . to ‘backup’@’%’ identified by ‘123456’;`

    `MariaDB [(none)]> flush privileges;`

4. 从容器中拷贝一份mariadb配置文件

    sudo docker cp master:/etc/mysql/my.cnf

    /home/lxj/hedisql/data/master_my.cnf

5. 修改master_my.cnf，在 [mysqld] 节点下添加

    [mysqld]
    server-id=1

    log_bin=master-bin

    binlog-ignore-db=mysql

    binlog-ignore-db=information_schema

    binlog-ignore-db=performance_schema

    binlog-ignore-db=test

    innodb_flush_log_at_trx_commit=1

    binlog_format=mixed

6. 复制master_my.cnf并覆盖master中的my.cnf

    docker cp /home/lxj/heidisql/data/master_my.cnf master:/etc/mysql/my.cnf

7. 重启master容器

    docker restart master


----------

1. 运行主容器2

    docker run --name master2 -e MYSQL_ROOT_PASSWORD=123456 -v /home/lxj/heidisql/data/master2:/var/lib/mysql -p 23307:3306 --restart always -d mariadb

进入主容器2执行(添加备份的账号)

    MariaDB [(none)]> grant replication slave on . to ‘backup’@’%’ identified by ‘123456’;

    MariaDB [(none)]> flush privileges;

拷贝一份MySQL配置文件

    sudo docker cp master2:/etc/mysql/my.cnf /home/lxj/hedisql/data/master2_my.cnf

修改master2_my.cnf，在 [mysqld] 节点下添加

    [mysqld]

    server-id=11

    log_bin=master2-bin

    binlog-ignore-db=mysql

    binlog-ignore-db=information_schema

    binlog-ignore-db=performance_schema

    binlog-ignore-db=test

    innodb_flush_log_at_trx_commit=1

    binlog_format=mixed

复制master_my.cnf并覆盖master中的my.cnf

    docker cp /home/lxj/heidisql/data/master2_my.cnf master2:/etc/mysql/my.cnf

重启master2容器

    docker restart master2

进入master容器执行

    MariaDB [(none)]> SHOW MASTER status;

查找master的log文件及其地址

    如File 为master-bin.000005
    Position为4719

进入master2容器执行

    MariaDB [(none)]> SHOW MASTER status;

查找master2的log文件及其地址

    如File 为master2-bin.000001
    Position为330

master容器执行

    MariaDB [(none)]> change master to
    MASTER_HOST=‘10.18.139.141’,
    master_user=‘root’,
    master_password=‘123456’,
    MASTER_PORT=23307,
    master_log_file=‘master2-bin.000001’,
    MASTER_LOG_POS=330;
    MariaDB [(none)]> start SLAVE;
    MariaDB [(none)]> show slave status;

master2容器执行

    MariaDB [(none)]> change master to
    MASTER_HOST=‘10.18.139.141’,
    master_user=‘root’,
    master_password=‘123456’,
    MASTER_PORT=23306,
    master_log_file=‘master-bin.000005’,
    MASTER_LOG_POS=4719;
    MariaDB [(none)]> start SLAVE;
    MariaDB [(none)]> show slave status;

查看结果

    当结果中的Slave_IO_Running与Slave_SQL_Running都为Yes时表示配置成功。

进行测试

    在master容器运行 MariaDB [(none)]> create database edslxj2;
    在master2容器能够同步。
    在master容器运行 MariaDB [(none)]> create database edslxj2222;
    在master2容器能够同步。

部署成功
