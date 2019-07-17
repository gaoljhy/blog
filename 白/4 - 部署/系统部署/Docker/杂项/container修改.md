# 修改

修改 inspect 文件

linux `cd /var/lib/docker/aufs/diff/`

`find ./ -name 容器名字.conf`

## 本质上是修改 container 的配置

1. attach 到 container 中执行命令 后， `Ctrl+P+Q`退出，但不关闭
2. exec 处理 命令执行
   `docker exec [OPTIONS] CONTAINER COMMAND [ARG...]`

## update 修改

`docker update [OPTIONS] CONTAINER [CONTAINER...]`
> 有些无法更改