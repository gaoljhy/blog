## Flask + Gunicorn + Nginx 部署


我自己也经过多番的纠结与尝试，也终于找到了一个 Flask 上靠谱的部署方案。我现在公司的微信后端平台也采用这种部署方案。如果有兴趣的朋友也不妨一看，或者给我提些更好的方案，毕竟知识只有共享了才知道是否有价值。

我在 Flask 官方文档中找到其中一个有意思的内容，这里是原谅链接：Standalone WSGI Containers ，其中并没有 uwsgi 的身影。悻然，但是找到了一个不用折腾的 Flask 部署方案了 —— Gunicorn。

Ubuntu 上的准备
假定你是在腾迅云或者阿里云购买了VPS，那么直接执行以下指令吧，其它的不多解释了，无非就是准备一下 python 环境。

$ sudo apt-get update
$ sudo apt-get install python-dev python-pip python-virtualenv
然后安装 nginx

$ sudo apt-get install nginx
在 /var/www 目录下建立一个 myflask 的文件夹(你的项目目录)，然后用 chmod 改一下权限

$ sudo mkdir /var/www/myflask
$ sudo chmod 777 /var/www/myflask
注：当然你可以使用 nginx 的默认网站目录 /usr/share/nginx/html

然后用 scp 指令直接将本机上的 flask 项目传到服务器:

$ scp -r myflask root@www.mydomain.com:/var/www/myflask
域名就改成地址或者你的服务器正在使用的域名，我这里是用 root 用户进入的，你得按你的服务器的用户来修改。两大云的默认根用户是：

腾迅 ：ubuntu
阿里 ：root
Gunicorn
Gunicorn 绿色独角兽 是一个Python WSGI UNIX的HTTP服务器。这是一个pre-fork worker的模型，从Ruby的独角兽（Unicorn ）项目移植。该Gunicorn服务器大致与各种Web框架兼容，只需非常简单的执行，轻量级的资源消耗，以及相当迅速。

我曾经Google 过 Gunicorn 与 uwsgi ，都说uwsgi 的性能要比 gunicorn 高，所以最终结果就杯具了。不过，现在回过头来看这只 “独角兽”还为时不晚吧。

安装 Gunicorn
Gunicorn 应该装在你的 virtualenv 环境下，关于 virtualenv 就不多说了，如果没用过那就赶快脑补吧。安装前记得激活 venv

(venv) $ pip install gunicorn
运行 Gunicorn
(venv) $ gunicorn -w 4 -b 127.0.0.1:8080 wsgi:application
That's all！ 它的安装就这么简单。不过这里得作一个解释。就是最后的那个参数 wsgi:application 这个是程序入口，我得写个小小的范例来说明一下：

新建一个 wsgi.py 的文件, 注意，这里和 Flask 项目中常用的 manage.py 引导脚本是没有半点毛关系的。（这是我笨，以前一直没分清被uwsgi搞糊涂了）

# wsgi.py

from flask import Flask

def create_app():
  # 这个工厂方法可以从你的原有的 `__init__.py` 或者其它地方引入。
  app = Flask(__name__)
  return app

application = create_app()

if __name__ == '__main__':
    application.run()
好了，这个 wsgi:application 参数就很好理解了， 分两部：wsgi 就是引导用的 python 文件名称（不包括后缀/模块名）application 就是 Flask 实例的名称。这样 gunicorn 就会找到具体要 host 哪一个 flask 实例了。

从这里开始就可以体现 gunicorn 的好了，根本不用配什么配置文件的，一个指令就可以将它起动。

Nginx 的配置
关于 Nginx 我也就不详细讲了，就直奔主题，杀入 Nginx 的默认配置文件

sudo nano /etc/nginx/site-avalidable/default
暴力修改成为以下的内容

建议先备份一下 default 文件
sudo cp /etc/nginx/site-avalidable/default /etc/nginx/site-avalidable/default.bak

server {
    listen 80;
    server_name example.org; # 这是HOST机器的外部域名，用地址也行

    location / {
        proxy_pass http://127.0.0.1:8080; # 这里是指向 gunicorn host 的服务地址
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

  }
记得完成 nginx 需要重新起动 nginx 服务喔！

sudo service nginx restart
将 Gunicorn 作为服务运行
这就是最后一步了，在此将采用 UpStart 配置Flask程序作为服务程序在Linux起动时运行。首先建立起动配置文件:

sudo nano /etc/init/myflask.conf
然后加入如下配置

description "The myflask service"

start on runlevel [2345]
stop on runlevel [!2345]


respawn
setuid root
setgid www-data

env PATH= /var/www/myflask/venv/bin
chdir /var/www/myflask/

exec gunicorn -w 4 -b 127.0.0.1:8080 wsgi:application
OK 大功告成，启动 myflask 服务

sudo service myflask start
这里有一点必须补充的，请留意在 myflask.conf 中的

env PATH= /var/www/myflask/venv/bin
chdir /var/www/myflask/
这里所指向的地址就是你的项目路径和 virtualenv 的路径

小结
这个部署过程感觉比我之前所介绍的 uwsgi 那种简单很多吧。这里给一点小 Tips 如果你用 Fabric 来完成这个部署过程的话那么就是纯自动化部署了喔，值得尝试的。