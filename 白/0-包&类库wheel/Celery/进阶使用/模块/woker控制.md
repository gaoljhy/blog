# 远程控制

- 使用 `RabbitMQ（AMQP）、Redis 或 Qpid` 作为中间人（Broker），可以在运行时控制和检查职程（Worker）。

  例如，查看当前职程（Worker）正在处理的任务：

  `$ celery -A proj inspect active`

- 这是通过广播消息实现的，集群中所有职程（`Worker`）都会所有收到远程控制发出的指令。

  也可以通过 `--destination` 选项指定一个或多个职程（`Worker`）进行操作，使用`,`进行分割职程（`Worker`）主机列表：

  `$ celery -A proj inspect active --destination=celery@example.com`

如果没有提供目的地，那么每个工作人员都将采取行动并回复请求。

- `celery inspect` 命令不能修改程序，只能进行查看职程（Worker）概况以及统计信息，可以通过 help 进行查看：

  `$ celery -A proj inspect --help`

- `celery control` 命令可以查看实际上改变了工作在运行时的状况：

  `$ celery -A proj control --help`

  例如，可以强制职程（Worker）启用事件消息（用于监控任务以及职程（Worker））：

  `$ celery -A proj control enable_events`

- 启动事件后，可以启动事件转储程序，进行查看职程（Worker）目前执行的状况：

  `$ celery -A proj events --dump`

- 或者可以启动 curses 接口：

  `$ celery -A proj events`

- 当监控完毕之后，可以禁用事件：

  `$ celery -A proj control disable_events`

- celery status 命令可以远程控制并且显示集群中职程（Worker）的列表：

  `$ celery -A proj status`

> 可以通过查阅 监控和管理手册：`Monitoring and Management Guide` ，查看 Celery 有关命令以及监控信息。
