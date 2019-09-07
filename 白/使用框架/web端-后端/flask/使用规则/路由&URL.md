## 路由
现代 `Web` 应用的 `URL` 十分优雅，易于人们辨识记忆，这一点对于那些面向使用低速网络连接移动设备访问的应用特别有用。


` route()` 装饰器把一个函数绑定到对应的 URL 上。

这里是一些基本的例子:
```python
@app.route('/')
def index():
    return 'Index Page'

@app.route('/hello')
def hello():
    return 'Hello World'
```
但是，不仅如此！

## 重点

> 你可以构造含有动态部分的 `URL`

> 也可以在一个函数上附着多个`route`规则。



---------------

##   路由值的规则
要给 `URL` 添加变量部分，你可以把这些特殊的字段标记为 `<variable_name> `， 这个部分将会作为命名参数传递到你的函数。

规则可以用 `<converter:variable_name>` 指定一个可选的 **转换器**。

## 例子:

```python
@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'User %s' % username

@app.route('/post/<int:post_id>')
def show_post(post_id):
    # show the post with the given id, the id is an integer
    return 'Post %d' % post_id

@app.route('/path/<path:subpath>')
def show_subpath(subpath):
    # show the subpath after /path/
    return 'Subpath %s' % subpath
```

Converter(转换器) 类型:

`string`	(`default`) accepts any text without a 斜杠
`int`   	accepts positive integers
`float`	    accepts positive floating point values
`path`  	like string but also accepts 斜杠
`uuid`	    accepts UUID(唯一识别码) strings

------------------

## 唯一 `URL` / 重定向行为

`Flask` 的 `URL` 规则基于 `Werkzeug` 的路由模块。

这个模块背后的思想是基于 `Apache` 以及更早的 `HTTP` 服务器主张的先例，保证优雅且唯一的 ` URL`。

### 以这两个规则为例:
```python
@app.route('/projects/')
def projects():
    return 'The project page'

@app.route('/about')
def about():
    return 'The about page'
```
虽然它们看起来很相似，但它们结尾斜线的使用在 `URL` 定义 中不同。 

> 访问一个结尾不带斜线的 `URL` 会被 `Flask` 重定向到带斜线的规范 `URL` 去。

** 推荐第二种使用方法**

第二种情况的 `URL` 结尾不带斜线，类似 `UNIX-like` 系统下的文件的路径名。
但访问时，结尾带斜线的 `URL` 会产生一个 `404 Not Found` 错误。

这个行为使得 ，子层关联的 `URL` 接任工作，与 `Apache` 和其它的服务器的行为并无二异。

> 此外，也保证了 `URL` 的唯一，有助于避免搜索引擎索引同一个页面两次。



---------------
## 构造 `URL`
如果 `Flask` 能匹配 `URL`，那么 `Flask` 也可以生成

> 可以用 `url_for()` 来给指定的函数构造 `URL`。

它接受函数名作为第一个参数，也接受对应 `URL` 规则的 变量 和 转换器 部分的命名参数。
> 未知变量部分会添加到 `URL` 末尾作为查询参数。

例子：
```python
>>> from flask import Flask, url_for
>>> app = Flask(__name__)
>>> @app.route('/')
... def index(): pass
...
>>> @app.route('/login')
... def login(): pass
...
>>> @app.route('/user/<username>')
... def profile(username): pass
...
>>> with app.test_request_context():
...  print url_for('index')
...  print url_for('login')
...  print url_for('login', next='/')
...  print url_for('profile', username='John Doe')
...

/
/login
/login?next=/
/user/John%20Doe
```
（这里也用到了 `test_request_context()` 方法，下面会解释。即使正在通过 `Python` 的 `shell` 进行交互，它依然会告诉 `Flask` 要表现为正在处理一个请求。请看下面的解释。 环境局部变量 ）

为什么你要构建 `URL` 而非在模板中硬编码？
这里有三个绝妙的理由：

1. 反向构建通常比硬编码的描述性更好。

2. 更重要的是，它允许你一次性修改 `URL`， 而不是到处边找边改。
3. `URL` 构建会转义特殊字符和 `Unicode` 数据，免去你很多麻烦。

如果你的应用不位于 `URL` 的根路径（比如，在 `/myapplication` 下，而不是 `/` ）， `url_for()` 会妥善处理这个问题。






