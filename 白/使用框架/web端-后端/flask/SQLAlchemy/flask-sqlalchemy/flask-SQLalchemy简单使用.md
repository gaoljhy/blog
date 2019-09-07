## 常规使用
```python
from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////tmp/test.db'
db = SQLAlchemy(app)


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True)
    email = db.Column(db.String(120), unique=True)

    def __init__(self, username, email):
        self.username = username
        self.email = email

    def __repr__(self):
        return '<User %r>' % self.username
```

## 创建表

为了创建初始数据库，只需要从交互式 `Python shell` 中导入 `db` 对象并且调用 `SQLAlchemy.create_all()` 方法来创建表和数据库:
```python
>>> from yourapplication import db
>>> db.create_all()
```





## 创建数据，并加入到数据库中

Boom, 您的数据库已经生成。现在通过表单对象 来创建一些用户:
```python
>>> from yourapplication import User
>>> admin = User('admin', 'admin@example.com')
>>> guest = User('guest', 'guest@example.com')
```

但是它们还没有真正地写入到数据库中，因此让来确保它们已经写入到数据库中:
```python
>>> db.session.add(admin)
>>> db.session.add(guest)
>>> db.session.commit()
```





## 访问数据库
访问数据库中的数据也是十分简单的:

```python
>>> users = User.query.all()
[<User u'admin'>, <User u'guest'>]
>>> admin = User.query.filter_by(username='admin').first()
<User u'admin'>
```




-----------
## 扩展关系表

```python

from datetime import datetime


class Post(db.Model):
    # 数值
    id = db.Column(db.Integer, autoincrement=True,primary_key=True)
    # 字符串
    title = db.Column(db.String(80))
    # 内容
    body = db.Column(db.Text)
    # 时间
    pub_date = db.Column(db.DateTime)

    # 外键
    category_id = db.Column(db.Integer, db.ForeignKey('category.id'))
    # 关系
    category = db.relationship('Category',
        backref=db.backref('posts', lazy='dynamic'))

    def __init__(self, title, body, category, pub_date=None):
        self.title = title
        self.body = body
        # 初始化时间
        if pub_date is None:
            pub_date = datetime.utcnow()
        self.pub_date = pub_date
        self.category = category

    def __repr__(self):
        return '<Post %r>' % self.title


class Category(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50),unique=True)

    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return '<Category %r>' % self.name

```


-------
# 常见问题解答
```python
from sqlalchemy import create_engine

sqlcont = create_engine('mysql://root:root@127.0.0.1:3306/test?charset=utf8')

报错：
ModuleNotFoundError: No module named 'MySQLdb'
```


解决方法：

`MySQLdb`只支持Python2.*，还不支持3.*


1. 可以用`PyMySQL`代替。安装方法：`pip install PyMySQL`
在

`from sqlalchemy import create_engine`
前加
```python
import pymysql
pymysql.install_as_MySQLdb()
```

2. 或只要在配置`SQLALCHEMY_DATABASE_URI`时，加上一个`pymysql`就可以了： 
`app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:dzd123@localhost/你的数据库名' `