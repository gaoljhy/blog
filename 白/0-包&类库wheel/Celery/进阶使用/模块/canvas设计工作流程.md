# Canvas：设计工作流程

有时候可能希望将任务调用的签名传递给另外一个进程或其他函数的参数，`Celery` 提供了共交签名

> 签名通过一种方式进行封装任务调用的参数以及执行选项，便于传递给他的函数，甚至通过序列化通过网络传送。

## 示例

​- 可以将 `add` 使用的参数作为任务创建的签名，倒计时为 10 秒，如下所示（2,2）：

    ```py
    >>> add.signature((2, 2), countdown=10)
    tasks.add(2, 2)
    ```

- 也可以通过一个快捷的方式进行操作：

  ```py
  >>> add.s(2, 2)
  tasks.add(2, 2)
  ```

- 再次调用 API ...

1.  签名实例支持调用 `API`：这就意味着可以使用 `delay` 和 `apply_async` 方法。
2.  但区别就在于签名实例已经指定了参数签名，该 `add` 任务有两个参数，需要指定两个参数的签名才能够成一个完整的签名实例：

    ```py
    >>> s1 = add.s(2, 2)
    >>> res = s1.delay()
    >>> res.get()
    4
    ```

3.  也可以创建不完整的签名来进行创建，称之为 partials 的内容

    ```py
    # incomplete partial: add(?, 2)
    >>> s2 = add.s(2)
    ```

4.  s2 为一个不完整的签名，需要另外一个参数，可以通过调用签名解决：

    ```py
    # resolves the partial: add(8, 2)
    >>> res = s2.delay(8)
    >>> res.get()
    10
    ```

5.  在这里，设置了设置了参数值为 8，它位于参数值为 2 的签名，形成了完整的 `add(8,2)` 签名。
    也可以设置新的参值，新设置的参数会覆盖原有的参数值：

        ```py
        >>> s3 = add.s(2, 2, debug=True)
        >>> s3.delay(debug=False)   # debug is now False.
        ```

如上所述，签名支持调用 API：

- `sig.apply_async(args=(), kwargs={}, **options)`

  使用可选的部分参数和部分关键字参数调用签名以及支持部分执行选项。

- `sig.delay(*args, **kwargs)`

  快捷版本的 `apply_async` ，任何参数都将作为签名中的参数，关键字参数将与任何现有键合并。

  这些看起来比较有用，但是可以用来做什么？为了解决这个问题，就需要介绍 canvas 原语.....

## 原语

这些原语本身就是签名对象，可以通过任何进行组合，形成复杂的工作流。

在下面的这些实例中，如果要运行，需要配置一个结果后端。

### 组：Groups

一个 group 并行调用任务列表，返回一个特殊的结果实例，可以将结果作为一个列表进行查看，并且通过索引进去获取返回值。

```py
>>> from celery import group
>>> from proj.tasks import add

>>> group(add.s(i, i) for i in xrange(10))().get()
[0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

```

- Partial group

```py
>>> g = group(add.s(i) for i in xrange(10))
>>> g(10).get()
[10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
```

### 链：Chains

可以将任务链接在一起，在一个人返回后进行调用另外一个任务：

```py
>>> from celery import chain
>>> from proj.tasks import add, mul

# (4 + 4) * 8
>>> chain(add.s(4, 4) | mul.s(8))().get()
64
```

- 或 partial chain

```py
>>> # (? + 4) * 8
>>> g = chain(add.s(4) | mul.s(8))
>>> g(4).get()
64
```

- 链也可以这样写：

```py
>>> (add.s(4, 4) | mul.s(8))().get()
64
```

### 和弦：Chords

和弦是一个带有回调的组：

```py
>>> from celery import chain
>>> from proj.tasks import add, mul

# (4 + 4) * 8
>>> chain(add.s(4, 4) | mul.s(8))().get()
64
```

- 或 partial chain

```py
>>> # (? + 4) * 8
>>> g = chain(add.s(4) | mul.s(8))
>>> g(4).get()
64
```

- 链接到其他任务的组将自动转换为和弦

```py
>>> (group(add.s(i, i) for i in xrange(10)) | xsum.s())().get()
90
```

- 这些原语都是签名的类型，可以根据需要进行组合，例如：

```py
>>> upload_document.s(file) | group(apply_filter.s() for filter in filters)
```

有关更多工作流信息，请参阅用户指南中 [Canvas 流程设计](https://www.celerycn.io/yong-hu-zhi-nan/canvas-she-ji-gong-zuo-liu-cheng-canvas-designing-workflows) 章节。
