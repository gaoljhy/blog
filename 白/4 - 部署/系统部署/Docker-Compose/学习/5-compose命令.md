# compose 命令

## 工程、服务、容器

`Docker Compose` 将所管理的容器分为三层

1. 工程（`project`）
2. 服务（`service`）
3. 容器（`container`）

----------

1. Docker Compose 运行目录下的一个 `docker-compose.yml` 文件 组成一个工程
2. 一个工程包含多个服务
3. 每个服务中定义了容器运行的镜像、参数、依赖
    > 一个服务可包括多个容器实例


## Docker Compose 常用命令与配置

> 前提是必须有 `docker-compose.yml` 配置文件在所运行的命令目录下才可以

### 常见命令

+ `ps`：列出所有运行容器

    `docker-compose ps`

+ `logs`：查看服务日志输出

    `docker-compose logs`


+ `port`：打印绑定的公共端口
    >下面命令可以输出 `eureka` 服务 `8761` 端口所绑定的公共端口

    `docker-compose port eureka 8761`

+ `build`：构建或者重新构建服务

    `docker-compose build`

+ `start`：启动指定服务已存在的容器

    `docker-compose start eureka`

+ `stop`：停止已运行的服务的容器

    `docker-compose stop eureka`

+ `rm`：删除指定服务的容器

    `docker-compose rm eureka`

+ `up`：构建、启动容器

    `docker-compose up`

+ `kill`：通过发送 SIGKILL 信号来停止指定服务的容器

    `docker-compose kill eureka`

+ `pull`：下载服务镜像

+ `scale`：设置指定服务运气容器的个数，以 service=num 形式指定

    `docker-compose scale user=3 movie=3`

+ `run`：在一个服务上执行一个命令

    `docker-compose run web bash`
