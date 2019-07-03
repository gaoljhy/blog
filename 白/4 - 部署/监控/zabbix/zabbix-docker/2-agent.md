# agent

`docker run --name zba1 -e ZBX_HOSTNAME="zba1" -e ZBX_SERVER_HOST="172.17.0.1"  -p1005:10050 --link zabbix-server-mysql:zabbix-server -d zabbix/zabbix-agent:centos-3.4-latest`

查看ip

`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' zba1`

## 使用

docker start zasql
docker start zabbix-server-mysql
docker start zabbix-web-nginx-mysql

## 不支持中文

```bash
yum -y install kde-l10n-Chinese && yum -y reinstall glibc-common 
localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 
export LC_ALL=zh_CN.utf8
```
