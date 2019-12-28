## 使用

`celery -A proj worker -l info`

`-A` 参数默认会寻找 `proj.celery` 这个模块，其实使用 `celery` 作为模块文件名字不怎么合理。可以使用其他名字。

举个例子，假如是 proj/app.py，可以使用如下命令启动：
`celery -A proj.app worker -l info`

### 当职程（Worker）开始运行时，可以看到一部分日志消息：

```log
-------------- celery@halcyon.local v4.0 (latentcall)
---- **** -----
--- * ***  * -- [Configuration]
-- * - **** --- . broker:      amqp://guest@localhost:5672//
- ** ---------- . app:         __main__:0x1012d8590
- ** ---------- . concurrency: 8 (processes)
- ** ---------- . events:      OFF (enable -E to monitor this worker)
- ** ----------
- *** --- * --- [Queues]
-- ******* ---- . celery:      exchange:celery(direct) binding:celery
--- ***** -----

[2012-06-08 16:23:51,078: WARNING/MainProcess] celery@halcyon.local has started.
```

- `broker` 为 `Celery` 程序中指定的中间人（Broker）的连接 URL，也可以通过 `-b` 选项在命令行进行设置其他的中间人（Broker）。
- `concurrency` 为同时处理任务的工作进程数量，所有的进程都被占满时，新的任务需要进行等待其中的一个进程完成任务才能执行进行任务。

  ### 并发处理

  默认的并发数为当前计算机的 `CPU` 数，可以通过设置 `celery worker -c` 项进行自定义设置并发数。

  > 没有推荐的并发数，因为最佳的并发数取决于很多因素
  >
  > > 如果任务主要是 `I/O` 限制，可以进行增加并发数，经过测试，设置超过`两倍的 CPU` 数量效果不是很好，很有可能会降低性能。
  > > 包括默认的 `prefork` 池，`Celery` 也支持在单个线程中使用 `Eventlet`、`Gevent`。（详情参阅：[并发：Concurrency](https://www.celerycn.io/yong-hu-zhi-nan/bing-fa-concurrency)）

- Events 选项设置为启用状态时， `Celery` 会开启监控事件来进行监视 职程（`Worker`）。一般情况用于监控程序，如 `Flower` 和 `实时 Celery` 监控，详情参阅 监控和管理手册：[Monitoring and Management Guide](https://www.celerycn.io/yong-hu-zhi-nan/jian-kong-he-guan-li-shou-ce-monitoring-and-management-guide)。

- Queues 为单个职程（`Worker`）任务队列，可以告诉职程（`Worker`）同时从**多个任务队列**中进行消费。
  通常用于将任务消息路由到特定的职程（`Worker`）、**提升服务质量**、**关注点分离**、**优先级排序的常用手段**。
  详情参阅 路由任务：[Routing Tasks](https://www.celerycn.io/yong-hu-zhi-nan/lu-you-ren-wu-routing-tasks)。
  > 可以通过 --help 参数进行查看完整的使用列表：

`$ celery worker --help`

[worker 文档配置项](https://www.celerycn.io/yong-hu-zhi-nan/zhi-cheng-worker-wen-dang-workers-guide)
