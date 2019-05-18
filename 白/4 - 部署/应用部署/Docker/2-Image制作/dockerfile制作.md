# Dockerfile

## 语法

1. 注释 `#`
2. 指令 大写
3. 参数

## 创建指令

一般制指定
  `docker build  -t name:tag -f <dockerfile> <PATH>`

 例如：
  `docker build -t nginx:0.1 -f temp/file .`

## 查看一个Image的dockerfile

 `docker history`

## DOCKERFILE指令

> 外部docker 操作指令(API)操作时会覆盖这些命令

1. `FROM <image[:TAG]>`
   1. image 必须是已存在的
   2. 基础镜像
   3. 必须是第一条非注释镜像
2. `MAINTAINER author string`
   1. 作者名和相关信息
3. `RUN <command> (shell模式)`
   1. 等同于`/bin/sh -c <command>`
   2. 也可采用`exec` 模式 - `RUN ["executable","param1"]`
        > `executable` 为 各种不同的`shell` ，如`/bin/bash`,`/bin/python`等
4. `CMD`
   1. 等同于`RUN`采用`exec` 模式 - `RUN ["executable","param1"]`
      > `executable` 为 各种不同的`shell` ，如`/bin/bash`,`/bin/python`等
   2. `dameon off/on` 作用为设定是否前台使用
5. `EXPOSE <port>[<port>...]`
   1. 指定运行该镜像的容器所需要使用的端口
   2. 该端口并不会默认打开，仍需要`docker run -p`开启端口映射
6. `ADD/COPY <src> ...<dest>`
   1. `ADD/COPY ["<src>"..."<dest>"]`(适用于文件路径中有空格的情况)
   2. `dest`为容器内文件目录
   3. 如果单纯复制文件，推荐使用`COPY` ,`ADD`类似于压缩解压缩
7. `VOLUME ["data"]` - 添加卷
8. `WORKDIR` - 工作目录
   1. 最好采用绝对路径，因为会叠加传递 
      > 如

       ```dockerfile
       WORKDIR /a
       WORKDIR b
       ```

       结果工作目录为 `/a/b`
9. `ENV<key><value>`- 设置环境变量
    1. 或者 `ENV<key>=<value> ...`
    2. 运行过程中也可有效
10. `USER` - 指定运行的用户
    1. 默认会使用`root`用户
11. `ONBUILD [INSTRUCTION]`
    1. Image 触发器
    2. 当该镜像作为其他镜像的基础镜像执行时，会在构建(`build`)过程中执行`ONBUILD`参数指令

## 使用 dockerfile 创建

 `docker build -f file 存放的PATH`

## 构建的缓存
  
  `docker` 会默认开启缓存（创建同一类container时，使用快速）
  `docker build --no--cache` 关闭缓存

## 注意

> ADD 和 COPY 是复制源文件夹下所有有内容到 目标内，不会复制源文件夹
> 目标文件如果为`~`，是不会定位到家目录，会在根目录下创建一个`~`目录，所以最好选用的是绝对路径

> 每天一条 RUN 命令都以根目录为初始路径，或者之前设置好`WORKDIR`