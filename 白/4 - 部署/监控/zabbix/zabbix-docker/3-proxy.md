# proxy

`docker run --name zabbix-proxy-mysql -e DB_SERVER_HOST="172.17.0.1" -e DB_SERVER_PORT=3300 -e MYSQL_DATABASE="zabbixAgent" -e MYSQL_USER="root" -e MYSQL_PASSWORD="123456dd" -e ZBX_HOSTNAME="zabbix-proxy-mysql" -e ZBX_PROXYMODE=1 -e ZBX_SERVER_HOST="172.17.0.1" -e ZBX_SERVER_PORT=10051 -p10052:10051 --link zabbix-server-mysql:zabbix-server --link zasql:mysql -d zabbix/zabbix-proxy-mysql:centos-3.4-latest`

> ZBX_PROXYMODE 0 为 主动(默认)，但需要端口对应 1 被动

+ 手动加入数据库
`mysql -uroot -ppassword`

+ 创建数据库
`CREATE DATABASE zabbixAgent;`

+ 导入数据
`use zabbixAgent;`
`set names utf8;`
`source /work/create.sql`

---------------------------
主动模式

`docker run --name zabbix-proxy-mysql-a -e DB_SERVER_HOST="172.17.0.1" -e DB_SERVER_PORT=3300 -e MYSQL_DATABASE="zabbixAgent" -e MYSQL_USER="root" -e MYSQL_PASSWORD="123456dd" -e ZBX_HOSTNAME="zabbix-proxy-mysql-a" -e ZBX_SERVER_HOST="172.17.0.1" -e ZBX_SERVER_PORT=10051 -p10053:10051 --link zabbix-server-mysql:zabbix-server --link zasql:mysql -d zabbix/zabbix-proxy-mysql:centos-3.4-latest`

-----------------------------------；

## sqlite3

`docker run --name zabbix-proxy-sqlite -e DB_SERVER_HOST="172.17.0.1" -e DB_SERVER_PORT=3300 -e MYSQL_DATABASE="zabbixAgent" -e MYSQL_USER="root" -e MYSQL_PASSWORD="123456dd" -e ZBX_HOSTNAME="zabbix-proxy-sqlite3" -e ZBX_SERVER_HOST="172.17.0.1" -e ZBX_SERVER_PORT=10051 -p10052:10051 -d zabbix/zabbix-proxy-sqlite3:centos-3.4-latest`
