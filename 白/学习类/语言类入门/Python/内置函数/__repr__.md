## 描述
`repr()` 函数将 对象 转化为 供 解释器 读取的形式。
本质上就是 该对象的输出表现形式，在交互式中直接调用显示的为该函数中返回的

方便 (`debug`)读取数据
> 在 pyhton2 时 ，使用 ``也可以作为 __repr__()

## 语法
以下是 `repr()` 方法的语法:

`repr(object)`

## 参数

`object`   对象。

## 返回值

### 返回一个对象的 `string` 格式。

实例
以下展示了使用 `repr()` 方法的实例：

```python
>>>s = 'RUN'
>>> repr(s)
"'RUN'"
>>> dict = {'google': 'google.com'};
>>> repr(dict)
"{'gao': 'gao.com'}"
>>>
```