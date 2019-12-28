## 后台运行

在生产环境中，如果需要后台运行职程（`Worker`）
可以参阅 守护进程：[Daemonization](https://www.celerycn.io/yong-hu-zhi-nan/shou-hu-jin-cheng-daemonization)

### 启动

可以使用 `celery multi` 命令在后台启动一个或多个职程（`Worker`）：
`celery multi start w1 -A proj -l info`

### 重启：

`celery multi restart w1 -A proj -l info`

### 停止

`celery multi stop w1 -A proj -l info`

`stop` 命令是异步的，所以不会等待职程（`Worker`）关闭。

- 可以通过 `stopwait` 命令进行停止运行，可以保证在退出之前完成当前正在执行的任务：

`celery multi stopwait w1 -A proj -l info`

### 注意

`celery multi` 不存储有关职程（`Worker`）的信息，所以在重新启动时需要使用相同的命令参数，停止运行时只能通过`pidfile`和`logfile`参数来进行停止运行。

默认情况下会在当前目录中创建 `pid 文件`和`日志文件`，为防止多个职程（`Worker`）干扰，建议将这些文件存放在专门的目录中：

```sh
$ mkdir -p /var/run/celery
$ mkdir -p /var/log/celery
$ celery multi start w1 -A proj -l info --pidfile=/var/run/celery/%n.pid \
                                        --logfile=/var/log/celery/%n%I.log
```

也可以使用 `multi` 命令启动多个职程（`Worker`），有一个强大的语法为不同职程（`Worker`）设置不同的参数：

`$ celery multi start 10 -A proj -l info -Q:1-3 images,video -Q:4,5 data -Q default -L:4,5 debug`

> 更多实例，可也参阅 multi API 模块。

---

## 关于 --app 参数

使用 `--app` 参数可也指定运行的 `Celery` 应用程序实例，格式必须为 `module.path:attribute`

但如果只设置包名，它将进行搜索 `app` 实例，顺序如下：
用 `--app=proj：`

1. 名为 `proj.app` 的属性
2. 名为 `proj.celery` 的属性
3. 模块 `proj` 中值为 `Celery` 应用程序的任何属性，如果还没有找到，将尝试检索名为 `proj.celery` 的子模块
4. 名为 `proj.celery.app` 的属性
5. 名为 `proj.celery.celery` 的属性
6. 模块 `proj.celery` 中值为 `Celery` 应用程序的任何属性
7. 在此方案模仿文档中使用的实例，即 针对单个模块包含的 `proj:app` ，以及 大型项目的 `proj.celery:app`
