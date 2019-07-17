Intent
========

1. 创建 `Intent `
2. 匹配传递 的**对象类**
3. 指定传递数据
4. 设定 Intent 跳转 并传递数据

```java
    //        匹配后面调用的 另一个 Activity 类(需要新建此类)
    Intent intent = new Intent(this, DisplayManagerActivity.class);

    //         传递给另一个 Activity 中的 信息(以 key:value 形式传递)
    intent.putExtra(this.EXTRA_MESSAGE, message);

    // 点击个Activity 后 执行到该函数 进行 Activity 跳转
    startActivity(intent);
```

接受方
--------

1. 创建 **接受对象** Intent
2. 从传递过来的 Intent 获取数据

```java
    // 获取 Intent 传递对象
    Intent intent = getIntent();

    // 获取  MainActivity 传递字典中 的对应 key 的 value
    String message = intent.getStringExtra(MainActivity.EXTRA_MESSAGE);
```