# 配置文件

可使用命令
`docker info | grep Dir`

`/etc/default/docker`

## 环境配置文件

`/etc/sysconfig/docker-network`
`/etc/sysconfig/docker-storage`
`/etc/sysconfig/docker`

## Unit File

`/usr/lib/systemd/system/docker.service`

## Docker Registry配置文件

`/etc/containers/registers.conf`

## daemon配置文件

    配置文件：`/etc/docker/dameon.json`

不同的docker 时，可以直接移动该配置文件覆盖以配置为相同