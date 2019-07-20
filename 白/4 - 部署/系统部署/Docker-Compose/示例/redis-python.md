# 简介

> TODO 使用 `docker-compose` 构建 python + redis 开发环境

## python 环境

    dockerfile ./python/dockerfile
    镜像命名 mypyhton:3
    开放端口 8088:80 8087:8888
    Name mypyhton
    磁盘映射 /root/docker-workdir:/usr/src/myapp
    网络link redis:myredis
    WORKDIR /usr/src/myapp
    CMD ["python","/usr/src/myapp/index.py"]

## Redis 环境

    镜像 redis:4.0.14
    Expose端口 6379
    Name myredis
    磁盘映射 /root/docker-workdir/redis.conf:/usr/local/etc/redis/redis.conf:ro
    CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

------------

## docker-compose 编写

> docker-compose.yml

```yaml
version : "3"
services :

 redis:
    image : redis:4.0.14
    container_name : myredis
    expose:
        - "6379"
    volumes:
        - /root/docker-workdir/redis.conf:/usr/local/etc/redis/redis.conf:ro
    command : [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
 
 python:
    build :
        context: ./python
        dockerfile: dockerfile
    image: mypython:3.6.9-alpine
    container_name : mypython
    links :
        - redis:myredis
    ports:
        - "8088:80"
        - "8087:8888"
    volumes:
        - /root/docker-workdir/python:/usr/src/myapp:rw
    command : ["python","/usr/src/myapp/index.py"]
```

> 注意空格,换行不能随便乱用,会影响 `docker-compose
yaml`语法指定

> link 映射名 一定是 `服务名:/etc/hosts下名字`

--------------

## 整体路径

```txt
docker-workdir/
├── docker-compose.yaml
├── python
│   ├── dockerfile
│   ├── index.py
│   └── requirements.txt
└── redis.conf
```

## build

`docker-compose build`

> 如果直接使用已经构建好的image,则不需要`build`
    >> 默认会跳过


## 构建,启动

`docker-compose up`

## 单独启动一个服务

`docker-compose start redis`