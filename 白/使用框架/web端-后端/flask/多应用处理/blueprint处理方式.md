flask使用Blueprint进行多模块应用的编写
-----------------------------------


```python
from flask import Blueprint

dept = Blueprint('dept', __name__,)
```


```python
from flask import Blueprint

user = Blueprint('user', __name__,)
```

app.py
---------------
```python
app.register_blueprint(user, url_prefix='/user')
app.register_blueprint(dept, url_prefix='/dept')


if __name__ == '__main__':
    app.run()
```

> 统一注册一下就可以了


Blueprint其实本身只是对view上的接口进行了注册，然后整体挂载在app上，Blueprint本身的目的就是组织多模块的平行共存，避免直接在app上注册view，其实更多的只是方便开发和代码的维护，因为最终所有的views上的接口都仍然是直接挂载在app上，其实对应整个应用来说，没有什么明显的区别。

Flask 中的Blueprint不是一个可插拨的应用，因为它不是一个真正的应用，而是一套可以注册 在应用中的操作，并且可以注册多次。
同时在这里，不能使用多个flask对象来管理和注册，因为这样会导致每个flask对象都有一个自己的配置，不好管理。
使用Blueprint，应用会在Flask层中进行管理，共享配置，通过注册按需改变应用 对象。Blueprint的缺点是一旦应用被创建后，只有销毁整个应用对象才能注销lueprint。
综合以上，简单来说，Blueprint就是通过url找到view的一套机制，并没有太过于复杂的逻辑。
