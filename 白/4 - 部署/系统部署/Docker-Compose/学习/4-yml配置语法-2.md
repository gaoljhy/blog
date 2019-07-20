# 语法

## image

> docker create IMAGE
>> 一定程度上可以类似为 run,create 中的image

指定启动容器的镜像，可以是镜像仓库/标签或者镜像id（或者id的前一部分）

```yaml
image: redis
image: ubuntu:14.04
image: tutum/influxdb
image: example-registry.com:4000/postgresql
image: a4bc65fd
```

如果镜像不存在，`Compose`将尝试从官方镜像仓库将其`pull`下来
如果你还指定了build，在这种情况下，它将使用指定的build选项构建它，并使用image指定的名字和标记对其进行标记。

------------------

## container_name

> docker create --name string                    
> Assign a name to the container

指定一个自定义容器名称，而不是生成的默认名称。

`container_name: my-web-container`

> 由于Docker容器名称必须是唯一的，因此如果指定了自定义名称，则无法将服务扩展到多个容器。

------------

## volumes

> docker create -v, --volume list                    
>> Bind mount a volume

卷挂载路径设置。

可以设置宿主机路径 （`HOST:CONTAINER`） 或加上访问模式 （`HOST:CONTAINER:ro`）
挂载数据卷的默认权限是读写（`rw`），可以通过`ro`指定为只读。

可以在主机上挂载**相对路径**，该路径将相对于当前正在使用的`Compose`配置文件的目录进行扩展。
> 相对路径应始终以 `.` 或者 `..` 开始。

```yml
volumes:
  # 只需指定一个路径，让引擎创建一个卷
  - /var/lib/mysql

  # 指定绝对路径映射
  - /opt/data:/var/lib/mysql

  # 相对于当前compose文件的相对路径
  - ./cache:/tmp/cache

  # 用户家目录相对路径
  - ~/configs:/etc/configs/:ro

  # 命名卷
  - datavolume:/var/lib/mysql
```

但是，如果要跨多个服务并重用挂载卷，请在顶级`volumes`关键字中命名挂载卷，但是并不强制

### 重用挂载卷

如下的示例亦有重用挂载卷的功能，但是**不提倡**

```yaml
version: "3"

services:
  web1:
    build: ./web/
    volumes:
      - ../code:/opt/web/code
  web2:
    build: ./web/
    volumes:
      - ../code:/opt/web/code
```

>注意：通过顶级`volumes`定义一个挂载卷，并从每个服务的卷列表中引用它， 这会替换早期版本的`Compose`文件格式中`volumes_from`

```yaml
version: "3"

services:
  db:
    image: db
    volumes:
      - data-volume:/var/lib/db
  backup:
    image: backup-service
    volumes:
      - data-volume:/var/lib/backup/data

volumes:
  data-volume:
```

-------------------

## command

>  docker create IMAGE [COMMAND]
>> 对应 COMMAND ,可自己指定覆盖

覆盖容器启动后默认执行的命令

`command: bundle exec thin -p 3000`

该命令也可以是一个类似于dockerfile的`CMD`列表：

`command: ["bundle", "exec", "thin", "-p", "3000"]`

