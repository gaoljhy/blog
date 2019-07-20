# 语法

## yaml常用服务配置简介

`Compose`文件是一个定义**服务**，**网络**和**卷**的`YAML`文件。
> Compose文件的默认文件名为docker-compose.yml。
>> 可使用`.yml`或`.yaml`扩展名

默认情况下，Dockerfile中指定的选项（例如`CMD，EXPOSE，VOLUME，ENV`）都被遵守
不需要在docker-compose.yml中再次指定它们,docker-compose 目的是`替代 docker 命令组成的 shell 脚本`

同时可以使用类似`Bash`的 `${VARIABLE}` 语法在配置值中使用环境变量，有关详细信息，请参阅变量替换。

### 配置选项

> 包含yml版本`3`中服务定义支持的所有配置选项。

------------------

## docker-compose.yml 属性

> 参考 <https://docs.docker.com/compose/compose-file/>
>> 可在该页下找到对应的`yml`配置所有选项

+ `version`：指定 `docker-compose.yml` 文件的写法格式

+ `services`：多个容器集合

+ `build`：配置构建时
  > Compose 会利用它自动构建镜像
  >> 该值可以是一个路径，也可以是一个对象，用于指定 `Dockerfile`

### build

> `docker build`
>> 等同于docker命令行中使用 build 构造 image

> 其中选项对应dockerfile中的参数

`build` 可以指定包含构建上下文的路径：

```yaml
version: '3'
services:
  webapp:
    build: ./dir
```

或者，作为一个对象，该对象具有上下文路径和指定的Dockerfile文件以及`args`参数值：

```yaml
version: '3'
services:
  webapp:
    build:
      context: ./dir
      dockerfile: Dockerfile-alternate
      args:
        buildno: 1
```

> `webapp`服务将会通过`./dir`目录下的`Dockerfile-alternate`文件构建容器镜像

如果同时指定`image`和`build`，则`compose`会通过`build`指定的目录构建容器镜像

而构建的镜像名为`image`中指定的镜像名和标签。

```yaml
build: ./dir
image: webapp:tag
```

> 这将由`./dir`构建的名为`webapp`和标记为`tag`的镜像。

--------------------

### context

> docker build  -f, --file string             
>> Name of the Dockerfile (Default is 'PATH/Dockerfile')

包含`Dockerfile`文件的目录路径，或者是`git`仓库的`URL`

当提供的值是相对路径时，它被解释为相对于当前`compose`文件的位置

> 该目录也是发送到`Docker`守护程序构建镜像的上下文。

-----------------

### dockerfile

备用`Docker`文件。

`Compose`将使用备用文件来构建。 还必须指定构建路径。

--------------

### args

> 映射 dockerfile 中参数

添加构建镜像的参数，环境变量只能在构建过程中访问。

1. 首先，在`Dockerfile`中指定要使用的参数

```dockerfile
ARG buildno
ARG password

RUN echo "Build number: $buildno"
RUN script-requiring-password.sh "$password"
```

2. 然后在`args`键下指定参数

可以传递映射或列表：

```yaml
build:
  context: .
  args:
    buildno: 1
    password: secret

build:
  context: .
  args:
    - buildno=1
    - password=secret
```

> 注意：`YAML`布尔值（`true，false，yes，no，on，off`）必须用引号括起来，以便解析器将它们解释为字符串

