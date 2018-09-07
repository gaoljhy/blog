## `Flask`是一个使用 `Python` 编写的轻量级 `Web` 应用框架。

其 `WSGI` (在 Web 应用和多种服务器之间的标准 Python 接口) 工具箱采用 `Werkzeug` ，模板引擎则使用 `Jinja2`。
> 很多功能的实现都参考了`django`框架。


## 一、平台说明

操作系统：`window 7`    
数据库：`mysql5.6`  `python：v2.7`  
开发集成软件：`PyCharm5.0`

## 二、开发环境搭建

1. 安装flask框架包
    
    打开windows的命令行：`pip install flask`

    从安装过程中可以看到安装的包有
```
    Jinja2-2.10
    MarkupSafe-1.0
    Werkzeug-0.14.1
    click-6.7
    flask-1.0.2
    itsdangerous-0.24
```

2. 验证是否安装成功

    在 `python` 交互窗口中，输入 `from flask import Flask`

当导入`flask`包没有任何报错时，表示`flask`已经安装成功了。

2、安装`flask-sqlalchemy`包

### 简介：
1> `SQLAlchemy`是`Python`编程语言下的一款开源工具。
> 提供了`SQL`工具包及对象关系映射`ORM`工具，
> 
> `SQLAlchmey`采用了类似于`Java`里`Hibernate`的数据映射模型，`2006`发行后成为`Python`社区中最广泛使用的`ORM`工具之一，不亚于`Django`的`ORM`框架。

2> `flask-sqlalchemy`包是一个为 `Flask` 应用增加 `SQLAlchemy` 支持的扩展。
它需要 `SQLAlchemy 0.6` 或者更高的版本。
> 它致力于简化在 `Flask` 中 `SQLAlchemy` 的使用，提供了有用的默认值和额外的助手来更简单地完成常见任务。

### 步骤

1> 安装`flask-sqlalchemy`
`pip install flask-sqlalchemy`

2> 验证`flask-sqlalchemy`是否安装成功

在`python`交互式编辑器中
` from flask_sqlalchemy import SQLAlchemy`

如果导入包时没有任何报错，表示安装成功。

到此，flask的开发环境就搞定了

