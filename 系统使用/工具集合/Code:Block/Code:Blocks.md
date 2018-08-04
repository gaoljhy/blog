> 因比赛需要,开始使用`Code:Blocks`,以下是使用记录

## 安装较为简单，将不再提及

为了统一，都将使用`GNU GCC`作为默认`Compiler`

---
## `VIEW`

打开程序，所展示的`view`
1. `manager`,左侧项目，路径，管理框
2. `toolbars` 操作图标框，基本的执行操作都在这里
3. `logs` 编辑下，输出，调试框
4. `status bar` 最底下边栏，状态框 ,文件位置文档类型等



----
## 执行`Hello world`

1. 在主界面选择`create a new projrct`<br/>
    或在`File`下选择`new` -> `Projrct`,创建一个项目
    > 当然也可选择`Open an existing project`<br/>
    > 或在`File`下选择`open`打开一个已存在的文件<br/>
    > 打开`*.cbp`文件为`code：blocks`项目文件,自动导入项目<br/>
2. 选择语言，位置，输出文件等，以后自动出形成`Hello World`模版
3. 编译，链接，运行
4. 弹出终端，执行程序

----
## `Debug`调试

一般第一次运行都会出现`ERROR`<br/>
> ```you need to specify a debugger program in the debugger's settings```

该错误表示没有安装调试需要的工具`GDB`或`MSVC`。

默认安装`GDB`

> 本人`Windows` 平台都用`VS` ，所以这里不做安装讲解<br/>
> 但可以推荐的是，使用`MinGW`

其他推荐在官网下载，[链接](ftp://sourceware.org/pub/gdb/releases/),本地编译安装<br/>
或者使用平台安装工具
> 安装完成以后，在终端输入`gdb`测试是否成功安装

### 配置`debug setting`

找到`settings` -> `debugger` 

找到`Executable path`,选择，安装的`gdb`路径,`ok`确定

---
## 快捷键

一些常用的就不再记录

|快捷键|作用|
|----|----|
|`Ctrl + Shift + C`|注释选中代码
|`Ctrl + Shift + X`|取消注释|
|`Ctrl + D`|选中当前行|
|`Ctrl + Space / Ctrl + J`|自动完成/填充代码|
|`shift + Space`|代码提示|
|`F9`|链接并运行|
|`F8`|开始调试|
|`F5`|添加/删除断点|
|`F4`|运行到下一个端点|
