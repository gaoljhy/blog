# so 文件

`so`文件是`unix`(一个系统的名字)的动态连接库，是二进制文件，作用相当于`windows`下的`.dll`文件。

## 补充：

1. 在Android中调用动态库文件(*.so)都是通过jni的方式。
2. Android中加载so文件的提供的API：
3. `void System.load(String pathName);`
    > 说明：`pathName`：`文件名+文件路径`；

## 原因

1. 也就是说Java层的代码太容易被逆向或者破解了

2. 如果一些底层的算法，比如说账号登陆的算法，不想被外界看到就需要这种底层的SO文件，在SO层内部对密码进行加密，

3. 然后对内外都留有接口，方便SO层跟Java层之间互相通信，或者是互相调用。

## 查看so的API代码

导入一个`SO`文件到`IDA`进行查看

在 IDA中查看这俩选项

(1) `Exports`窗口是导出表（方便Java层能调用SO层的函数）
(2) `Imports`窗口是导入表（方便SO层调用Java层的函数）
