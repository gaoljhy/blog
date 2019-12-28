from __future__ import absolute_import, unicode_literals
# "from __future__ import absolute_import"是拒绝隐式引入，因为celery.py的名字和celery的包名冲突，需要使用这条语句让程序正确地运行。
from celery import Celery

app = Celery('proj', include=['proj.tasks'])
# app是Celery类的实例

app.config_from_object('proj.celeryconfig')
# 把Celery配置存放进 proj/celeryconfig.py 文件，使用 app.config_from_object 加载配置。

# 该 `include` 参数是程序启动时添加的对应文件模块列表，可以该处添加任务模块，便于职程能够对应相应的任务。
# 创建的时候添加了proj.tasks这个模块，也就是包含了proj/tasks.py这个文件。



# Optional configuration, see the application user guide.
app.conf.update(
    result_expires=3600,
)

if __name__ == '__main__':
    app.start()




