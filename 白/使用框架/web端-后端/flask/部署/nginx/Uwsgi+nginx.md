## `Web` 服务器采用`uWSGI`
> 用`Supervisor`引用`uwsgi` 作为常规启动服务

系统采用Ubuntu 15.10
> 基于Nginx作反向代理

1. 安装Python环境，Flask
------------------------------------

    先安装`python3`环境，安装`pip`、`virtualenv`。

新建一个虚拟环境`venv`并激活：
`source venv/bin/activate`


接下来安装`Flask`和`Flask`的依赖，这个根据项目来定。

项目的启动文件`manage.py`如下：
```python
import os

if os.path.exists('.env'):
    print('Importing environment from .env...')
    for line in open('.env'):
        var = line.strip().split('=')
        if len(var) == 2:
            os.environ[var[0]] = var[1]

from flask.ext.script import Manager,Shell

app = create_app(os.getenv('FLASK_CONFIG') or 'default')

app.debug= True

manager = Manager(app)

def make_shell_context():
    return dict(app=app,db=db,User=User)

manager.add_command("shell",Shell(make_context=make_shell_context))


if __name__=='__main__':
    manager.run()
```
所以运行Flask的方式如下：

`python manage.py runserver --host 0.0.0.0 --port 80`

> 然后打开浏览器，输入你的云主机IP加端口号,就可以看到你的网站了。


2. 安装`uWSGI`
------------------------------------
安装uWSGI的方式也很简单，pip安装即可：

`(venv) wb@vultr:~/myBlog$pip install uwsgi`
安装完了之后就是配置

在项目目录下新建`config.ini`，在`config.ini`中输入以下内容：

```cgi
[uwsgi]
master = true
home = /var/html/venv
wsgi-file = run.py
callable = app
socket = 172.20.10.72:3031
processes = 4
threads = 2
buffer-size = 32768
```

其中，
    1. `home`是虚拟环境的目录
    2. `wsgi-file`是`python`启动文件
    3. `callable=app`这个`app`是 `manage.py` 程序文件内的一个变量，这个变量的类型是 `Flask`的 `application` 类 4. `socket`指定了启动时使用的端口。


## 运行`uwsgi`：

```cgi
$ uwsgi config.ini
[uWSGI] getting INI configuration from config.ini
*** Starting uWSGI 2.0.12 (64bit) on [Thu Apr 21 08:41:52 2016] ***
compiled with version: 5.2.1 20151010 on 19 April 2016 02:03:42
```
此时已经正常启动 `uWSGI` 已将 `Flask` 项目载入其中了
`ctrl+c` 关闭程序。

这只是命令启动形式，关闭了就无法访问了。
要使其随同服务器启动并作为后台服务运行才是运行环境的实际所需要。

> 因此需要另外的工具引导uWSGI。


3. 安装supervisor
----------------------------------
使用`supervisor`引导`uWSGI`
安装方法：
```bash
sudo apt-get install supervisor
```
`supervisor`的全局配置文件在`/etc/supervisor/supervisor.conf`中

一般不改动，新建一个文件`blog_supervisor.conf`放在`/etc/supervisor/conf.d`目录下
输入以下内容：
```cgi
[program:blog] 
# 启动命令入口 
command=/home/wb/myBlog/venv/bin/uwsgi /home/wb/myBlog/config.ini            
# 命令程序所在目录 
directory=/home/wb/myBlog
#运行命令的用户名 
user=wb
autostart=true
autorestart=true
#日志地址 
stdout_logfile=/home/wb/myBlog/logs/uwsgi_supervisor.log
```
启动`supervisor`服务：`sudo service supervisor start`

4. `Nginx` 反向代理
----------------------------------
`Nginx`是个著名的反向代理服务器。
安装方法：

`sudo apt-get install nginx`
配置文件在`/etc/nginx/sites-available`中的`default`中，将其替换掉即可。

新的default文件内容如下：
```cgi
server { 
  listen 80; 
  server_name X.X.X.X; #公网地址 
  location / { 
  include uwsgi_params;
  uwsgi_pass 127.0.0.1:3031; # 指向uwsgi 所应用的内部地址,所有请求将转发给uwsgi 处理 
  uwsgi_param UWSGI_PYHOME /home/wb/myBlog/venv; # 指向虚拟环境目录 
  uwsgi_param UWSGI_CHDIR /home/wb/myBlog; # 指向网站根目录 
  uwsgi_param UWSGI_SCRIPT manage:app; # 指定启动程序
  uwsgi_read_timeout 100; 
 }  
}
```
重启Nginx服务：`sudo service nginx restart`
这时候打开浏览器，输入你的主机IP，就可以看到你的项目了。
