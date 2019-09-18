# harbor 的搭建

`docker` 官方提供的私有仓库 `registry`，用起来虽然简单 ，在管理的功能上存在不足。 

`Harbor`是一个用于存储和分发`Docker`镜像的企业级`Registry`服务器

`harbor`使用的是官方的`docker registry`(`v2`命名是`distribution`)服务去完成。
`harbor`在`docker distribution`的基础上增加了一些安全、访问控制、管理的功能以满足企业对于镜像仓库的需求。

## 1.搭建

1. 下载
    地址：`https://github.com/goharbor/harbor/releases`
    本文是有 `v1.2.2`

2. 配置
    解压下载的安装包 `harbor-offline-installer-v1.2.2.tgz`

    `tar -xvf harbor-offline-installer-v1.2.2.tgz`

    修改 `harbor.cfg`

    ```cfg
    #hostname 改为本地ip，非 Mac OS系统 可以不指定端口
    hostname = 192.168.31.143:9090

    #设置secretkey_path 的路径为 当前目录的data下
    secretkey_path = ./data
    ```

    > 需要注意的是，非 Mac 用户只需要 修改 `harbor.cfg` 中的 `hostname` 
    > > 就可以直接通过 `./install.sh` 就可以构建镜像，并把服务启动起来。
    > > 不需要 `secretkey_path` 和 下面 `docker-compose.yml` 的修改

3. 修改 `docker-compose.yml`

    因为`harbor`使用了很多目录挂载，`Mac`有很多目录是不允许挂载的
    所以如果是Mac用户，需要修改`docker-compose.yml` 中的挂载目录，修改后的 `docker-compose.yml` 如下：

    ```yml
    version: '2'
    services:
    log:
        image: vmware/harbor-log:v1.2.2
        container_name: harbor-log 
        restart: always
        volumes:
        - ./log/:/var/log/docker/:z
        ports:
        - 127.0.0.1:1514:514
        networks:
        - harbor
    registry:
        image: vmware/registry:2.6.2-photon
        container_name: registry
        restart: always
        volumes:
        - ./data/registry:/storage:z
        - ./common/config/registry/:/etc/registry/:z
        networks:
        - harbor
        environment:
        - GODEBUG=netdns=cgo
        command:
        ["serve", "/etc/registry/config.yml"]
        depends_on:
        - log
        logging:
        driver: "syslog"
        options:  
            syslog-address: "tcp://127.0.0.1:1514"
            tag: "registry"
    mysql:
        image: vmware/harbor-db:v1.2.2
        container_name: harbor-db
        restart: always
        volumes:
        - ./data/database:/var/lib/mysql:z
        networks:
        - harbor
        env_file:
        - ./common/config/db/env
        depends_on:
        - log
        logging:
        driver: "syslog"
        options:  
            syslog-address: "tcp://127.0.0.1:1514"
            tag: "mysql"
    adminserver:
        image: vmware/harbor-adminserver:v1.2.2
        container_name: harbor-adminserver
        env_file:
        - ./common/config/adminserver/env
        restart: always
        volumes:
        - ./data/config/:/etc/adminserver/config/:z
        - ./data/secretkey:/etc/adminserver/key:z
        - ./data/:/data/:z
        networks:
        - harbor
        depends_on:
        - log
        logging:
        driver: "syslog"
        options:  
            syslog-address: "tcp://127.0.0.1:1514"
            tag: "adminserver"
    ui:
        image: vmware/harbor-ui:v1.2.2
        container_name: harbor-ui
        env_file:
        - ./common/config/ui/env
        restart: always
        volumes:
        - ./common/config/ui/app.conf:/etc/ui/app.conf:z
        - ./common/config/ui/private_key.pem:/etc/ui/private_key.pem:z
        - ./data/secretkey:/etc/ui/key:z
        - ./data/ca_download/:/etc/ui/ca/:z
        - ./data/psc/:/etc/ui/token/:z
        networks:
        - harbor
        depends_on:
        - log
        - adminserver
        - registry
        logging:
        driver: "syslog"
        options:  
            syslog-address: "tcp://127.0.0.1:1514"
            tag: "ui"
    jobservice:
        image: vmware/harbor-jobservice:v1.2.2
        container_name: harbor-jobservice
        env_file:
        - ./common/config/jobservice/env
        restart: always
        volumes:
        - ./data/job_logs:/var/log/jobs:z
        - ./common/config/jobservice/app.conf:/etc/jobservice/app.conf:z
        - ./data/secretkey:/etc/jobservice/key:z
        networks:
        - harbor
        depends_on:
        - ui
        - adminserver
        logging:
        driver: "syslog"
        options:  
            syslog-address: "tcp://127.0.0.1:1514"
            tag: "jobservice"
    proxy:
        image: vmware/nginx-photon:1.11.13
        container_name: nginx
        restart: always
        volumes:
        - ./common/config/nginx:/etc/nginx:z
        networks:
        - harbor
        ports:
        - 9090:80
        - 443:443
        - 4443:4443
        depends_on:
        - mysql
        - registry
        - ui
        - log
        logging:
        driver: "syslog"
        options:  
            syslog-address: "tcp://127.0.0.1:1514"
            tag: "proxy"
    networks:
    harbor:
        external: false
    ```

    通过运行 `install.sh` 构建镜像，并把服务启动起来：

    `./install.sh`
## 2. 使用

1. 访问 `http://127.0.0.1:9090/` 如下：


    默认 `admin` 用户的密码为 `Harbor12345` 
    可以在 `harbor.cfg` 进行修改。


2. 可以创建项目，创建用户，给项目分配用户等等，操作都很简单 。

## 3. 上传镜像

1. 首先登录私有仓库，可以使用 `admin` 用户 ，也可以使用自己创建的具有上传权限的用户：

    `docker login -u admin -p Harbor12345 127.0.0.1:9090`

2. 要通过`docker tag`将该镜像标志为要推送到私有仓库，例如：

    `docker tag nginx:latest 127.0.0.1:9090/library/nginx:latest`

3. 上传镜像：

    `docker push 127.0.0.1:9090/library/nginx:latest`

4. 访问 `http://127.0.0.1:9090/harbor/projects` ，在 library 项目下可以看见刚上传的 nginx镜像了：
