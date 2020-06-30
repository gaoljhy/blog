# API基础

`Jinja2` 使用一个名为 `Environment` 的中心对象。
这个类的实例用于存储配置、全局对象，并用于从文件系统或其它位置加载模板。

> 即使通过 `:class:Template` 类的构造函数用字符串创建模板，也会为自动创建一个环境，尽管是共享的。

大多数应用在应用初始化时创建一个 `Environment` 对象，并用它加载模板。 在某些情况下，如果使用多份配置，使用并列的多个环境无论如何是有用的。

配置 `Jinja2` 为应用加载文档的最简单方式看起来大概是这样:

```python
from jinja2 import Environment, PackageLoader
env = Environment(loader=PackageLoader('yourapplication', 'templates'))
```

这会创建一个默认设定下的模板环境和一个在 `yourapplication` python 包中的 `templates` 文件夹中寻找模板的加载器。

多个加载器是可用的，如果你需要从 数据库或其它资源加载模板，也可以自己写一个。

只需要调用 `get_template()` 方法从这个环境中加载模板，并会返回已加载的 `Template:`

`template = env.get_template('mytemplate.html')`

用若干变量来渲染它，调用 `render()` 方法:

`print template.render(the='variables', go='here')`

> 使用一个模板加载器，而不是向 `Template` 或 `Environment.from_string()` 传递字符串，有许多好处。
> 除了使用上便利， 也使得模板继承成为可能。

## Unicode

- `Jinja2` 内部使用 `Unicode` ，这意味着你需要向渲染函数传递 `Unicode` 对象或只包含 `ASCII` 字符的字符串。
此外，换行符按照默认 `UNIX` 风格规定行序列结束（ `\n` ）。

在 `Python 2.6` 中，可以 在模块层指定 `unicode` 为默认值，而在 `Python 3` 中会是默认值。

要显式使用一个 `Unicode` 字符串，需要给字符串字面量加上 `u` 前缀： `u'Hänsel und Gretel sagen Hallo'` 



另一件重要的事情是 Jinja2 如何处理模板中的字符串字面量。原生实现会对所有 字符串字面量使用 Unicode ，但在过去这是有问题的，因为一些库显式地检查它 们的类型是否为 str 。例如 datetime.strftime 不接受 Unicode 参数。 为了不彻底破坏它， Jinja2 对只有 ASCII 的字符串返回 str，而对其它返回 unicode:

```python
>>> m = Template(u"{% set a, b = 'foo', 'föö' %}").module
>>> m.a
'foo'
>>> m.b
u'f\xf6\xf6'
```