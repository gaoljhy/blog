# 初步

Redis 命令用于在 redis 服务上执行操作。

> 要在 redis 服务上执行命令需要一个 `redis` 客户端。

启动 `redis` 客户端，打开终端并输入命令 `redis-cli`

该命令会连接本地的 `redis` 服务。

`redis 127.0.0.1:6379> PING`


执行 PING 命令，该命令用于检测 `redis` 服务是否启动,返回 `PONG` 为启动成功

## 在远程服务上执行命令

如果需要在远程 redis 服务上执行命令，同样使用的也是 `redis-cli` 命令。

### 语法

`$ redis-cli -h host -p port -a password`

### 实例

以下实例演示了如何连接到主机为 `127.0.0.1`，端口为 `6379` ，密码为 `mypass` 的 `redis` 服务上。

`redis-cli -h 127.0.0.1 -p 6379 -a "mypass"`

--------------

## Redis 连接命令

| 命令 | 描述 |
| --- | ---- | 
| `AUTH password` | 验证密码是否正确
| `ECHO message `|  打印字符串 |
| `PING ` | 查看服务是否运行 |
| `QUIT ` | 关闭当前连接|
| `SELECT index`|  切换到指定的数据库|
------------------

## 命令参考 

<https://redis.io/commands>