# 语法

## links

> docker create --link list                      
>> Add link to another container

链接到另一个服务中的容器。

请指定**服务名称**和**链接**别名（`SERVICE：ALIAS`），或者仅指定服务名称。

```yaml
web:
  links:
   - db
   - db:database
   - redis
```

在当前的web服务的容器中可以通过链接的`db`服务的别名`database`访问`db`容器中的数据库应用，如果没有指定别名，则可直接使用`服务名`访问
> 等同于每次启动容器修改 `/etc/hosts` 映射文件

链接不需要启用服务进行通信
默认情况下，任何服务都可以以该服务的名称到达任何其他服务。
> 实际是通过设置`/etc/hosts`的域名解析，从而实现容器间的通信。
>> 故可以像在应用中使用`localhost`一样使用服务的别名链接其他容器的服务，前提是多个服务容器在一个网络中可路由联通

### `links`也可以起到和`depends_on`相似的功能，即定义服务之间的依赖关系，从而确定服务启动的顺序

------------

## external_links

链接到`docker-compose.yml` 外部的容器，甚至并非 `Compose` 管理的容器。

参数格式跟 `links` 类似。

```yaml
external_links:
 - redis_1
 - project_db_1:mysql
 - project_db_1:postgresql
```

-------------------

## expose

> docker create --expose list                    
>> Expose a port or a range of ports

暴露端口，但不映射到宿主机，只被连接的服务访问
仅可以指定`内部端口`为参数

```yaml
expose:
 - "3000"
 - "8000"
```

----------------

## ports

> docker create  -p, --publish list                   
>> Publish a container's port(s) to the host

> docker create -P, --publish-all                
>>Publish all exposed ports to random ports

暴露端口信息。
常用的简单格式：`使用宿主：容器` （`HOST:CONTAINER`）格式
或者
仅仅指定容器的端口（`宿主将会随机选择端口`）都可以

> 注意：当使用 `HOST:CONTAINER` 格式来映射端口时
  >> 如果你使用的容器端口小于 `60` 可能会得到错误得结果，因为 YAML 将会解析 `xx:yy` 这种数字格式为 `60` 进制。

> 所以建议采用字符串格式。

### 短格式

```yaml
ports:
 - "3000"
 - "3000-3005"
 - "8000:8000"
 - "9090-9091:8080-8081"
 - "49100:22"
 - "127.0.0.1:8001:8001"
 - "127.0.0.1:5000-5010:5000-5010"
 - "6060:6060/udp"
```

在v3.2中`ports`的长格式的语法允许配置不能用短格式表示的附加字段。

### 长格式

```yaml
ports:
  - target: 80
    published: 8080
    protocol: tcp
    mode: host
```

|参数|作用|
| ---- | ----- |
|`target`|容器内的端口|
|`published`|物理主机的端口|
|`protocol`|端口协议（tcp或udp）|
|`mode`|`host` 和`ingress` 两总模式|

> `host`用于在每个节点上发布主机端口，`ingress` 用于被负载平衡的`swarm`模式端口

--------------

## restart

> docker create  --restart string                
>> Restart policy to apply when a container exits (default "no")

`no`是默认的重启策略，在任何情况下都不会重启容器。
指定为`always`时，容器总是重新启动。
如果退出代码指示出现故障错误，则`on-failure`将重新启动容器。

```yaml
restart: "no"
restart: always
restart: on-failure
restart: unless-stopped
```
