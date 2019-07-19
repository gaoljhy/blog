# Redis 服务器

Redis 服务器命令主要是用于管理 `redis` 服务。

## 实例

以下实例演示了如何获取 redis 服务器的统计信息：

```sh
redis 127.0.0.1:6379> INFO

# Server
redis_version:4.0.14
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:d5cb9d9a74410bd0
redis_mode:standalone
os:Linux 4.4.0-105-generic x86_64
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:8.3.0
process_id:1
run_id:2bf2dffa69aced8acd7e079c8477dae864290d64
tcp_port:6379
uptime_in_seconds:12896
uptime_in_days:0
hz:10
lru_clock:3258007
executable:/data/redis-server
config_file:

# Clients
connected_clients:3
client_longest_output_list:0
client_biggest_input_buf:0
blocked_clients:0

# Memory
used_memory:890408
used_memory_human:869.54K
used_memory_rss:9916416
used_memory_rss_human:9.46M
used_memory_peak:890408
used_memory_peak_human:869.54K
used_memory_peak_perc:100.12%
used_memory_overhead:870010
used_memory_startup:786488
used_memory_dataset:20398
used_memory_dataset_perc:19.63%
total_system_memory:4143521792
total_system_memory_human:3.86G
used_memory_lua:37888
used_memory_lua_human:37.00K
maxmemory:10485760
maxmemory_human:10.00M
maxmemory_policy:noeviction
mem_fragmentation_ratio:11.14
mem_allocator:jemalloc-4.0.3
active_defrag_running:0
lazyfree_pending_objects:0

# Persistence
loading:0
rdb_changes_since_last_save:0
rdb_bgsave_in_progress:0
rdb_last_save_time:1563536683
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:0
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:6496256
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok
aof_last_cow_size:0

# Stats
total_connections_received:5
total_commands_processed:111
instantaneous_ops_per_sec:0
total_net_input_bytes:4498
total_net_output_bytes:56014
instantaneous_input_kbps:0.00
instantaneous_output_kbps:0.00
rejected_connections:0
sync_full:0
sync_partial_ok:0
sync_partial_err:0
expired_keys:0
expired_stale_perc:0.00
expired_time_cap_reached_count:0
evicted_keys:0
keyspace_hits:35
keyspace_misses:3
pubsub_channels:0
pubsub_patterns:0
latest_fork_usec:839
migrate_cached_sockets:0
slave_expires_tracked_keys:0
active_defrag_hits:0
active_defrag_misses:0
active_defrag_key_hits:0
active_defrag_key_misses:0

# Replication
role:master
connected_slaves:0
master_replid:571ebc4c6e7f7aeb814bb4289621a3c98bd85af9
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:0
second_repl_offset:-1
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0

# CPU
used_cpu_sys:8.06
used_cpu_user:3.42
used_cpu_sys_children:0.00
used_cpu_user_children:0.00

# Cluster
cluster_enabled:0

# Keyspace
db1:keys=3,expires=0,avg_ttl=0
```

------------

## Redis 服务器命令

下表列出了 redis 服务器的相关命令:

| 命令 | 描述| 
| ----- | ----- |
| `BGREWRITEAOF ` |  异步执行一个 AOF（AppendOnly File） 文件重写操作 | 
| `BGSAVE ` | 在后台异步保存当前数据库的数据到磁盘
| `SAVE `| 同步保存数据到硬盘
| `TIME` | 返回当前服务器时间
| `LASTSAVE `| 返回最近一次 Redis 成功将数据保存到磁盘上的时间，以 UNIX 时间戳格式表示
| `SHUTDOWN [NOSAVE] [SAVE] ` | 异步保存数据到硬盘，并关闭服务器
| `SLOWLOG subcommand [argument]` | 管理 redis 的慢日志
| `SYNC` | 用于复制功能(replication)的内部命令
| `DBSIZE`  | 返回当前数据库的 `key` 的数量
| `FLUSHALL ` |  删除所有数据库的所有key
| `FLUSHDB` | 删除当前数据库的所有key

### 客户端管理

| 命令 | 描述| 
| ----- | ----- |
| `CLIENT KILL [ip:port] [ID client-id]`|  关闭客户端连接
| `CLIENT LIST` | 获取连接到服务器的客户端连接列表
| `CLIENT GETNAME`|  获取连接的名称
| `CLIENT PAUSE timeout` | 在指定时间内终止运行来自客户端的命令
| `CLIENT SETNAME connection-name` | 设置当前连接的名称

### Redis 命令详情
| 命令 | 描述| 
| ----- | ----- |
| `COMMAND ` |  获取 Redis 命令详情数组
| `COMMAND COUNT `| 获取 Redis 命令总数
| `COMMAND GETKEYS ` |  获取给定命令的所有键
| `COMMAND INFO command-name [command-name ...]`| 获取指定 Redis 命令描述的数组

### config 配置文件
| 命令 | 描述| 
| ----- | ----- |
| `CONFIG GET parameter`|  获取指定配置参数的值
| `CONFIG REWRITE ` |  对启动 Redis 服务器时所指定的 `redis.conf` 配置文件进行改写
| `CONFIG SET parameter value ` | 修改 `redis` 配置参数，无需重启
| `CONFIG RESETSTAT` | 重置 `INFO` 命令中的某些统计数据
| `INFO [section]`| 获取 Redis 服务器的各种信息和统计数值

### 调试
| 命令 | 描述| 
| ----- | ----- |
| `DEBUG OBJECT key` |  获取 key 的调试信息
| `DEBUG SEGFAULT` | 让 Redis 服务崩溃
| `MONITOR` | 实时打印出 Redis 服务器接收到的命令，调试用

### 主从服务
| 命令 | 描述| 
| ----- | ----- |
| `ROLE` | 返回主从实例所属的角色
| `CLUSTER SLOTS `| 获取集群节点的映射数组
| `SLAVEOF host port` |  将当前服务器转变为指定服务器的从属服务器(slave server)