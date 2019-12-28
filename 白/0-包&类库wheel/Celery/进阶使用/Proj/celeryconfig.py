
BROKER_URL = 'amqp://dongwm:123456@localhost:5672/web_develop' # 使用RabbitMQ作为消息代理
# 该 `broker` 参数为指定的中间人（Broker）URL。

CELERY_RESULT_BACKEND = 'redis://localhost:6379/0' # 把任务结果存在了Redis

# 该 `backend` 参数为指定的结果后端 `URL`。
# 它主要用于跟踪任务的状态的信息，默认情况下禁用结果后端，在此实例中已经开启了该功能
# 主要便于后续检索，可能在会在程序中使用不同的结果后端。
# 每一个后端都有不同的优点和缺点，如果不需要结果，最好禁用。
# 也可以通过设置 @task(ignore_result=True) 参数，针对单个任务禁用。

CELERY_TASK_SERIALIZER = 'msgpack' # 任务序列化和反序列化使用msgpack方案

CELERY_RESULT_SERIALIZER = 'json' # 读取任务结果一般性能要求不高，所以使用了可读性更好的JSON

CELERY_TASK_RESULT_EXPIRES = 60 * 60 * 24 # 任务过期时间，不建议直接写86400，应该让这样的magic数字表述更明显

CELERY_ACCEPT_CONTENT = ['json', 'msgpack'] # 指定接受的内容类型
