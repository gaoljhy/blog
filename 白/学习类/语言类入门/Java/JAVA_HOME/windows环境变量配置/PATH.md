PATH
======

`PATH` 环境变量原来`Windows`里面就存在
     只需修改一下，使他指向`JDK`的`bin`目录，这样在控制台下面编译、执行程序时就不需要再键入一大串路径了

设置方法是保留原来的`PATH`的内容，并在其中加上`%JAVA_HOME%\bin`

注 :
     `DOS`批处理 `%%` 作用是 引用设定好的环境变量`JAVA_HOME`
     写成`x:\JDK_1.4.2`也可以

     可以打开一个控制台窗口，输入`echo %JAVA_HOME%`来查看设置结果

`windows`环境变量配置
     `PATH=%JAVA_HOME%\bin;%PATH%`

 同样，`%PATH%`是引用以前你设置的PATH环境变量
