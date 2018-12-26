CLASSPATH
=========

`CLASSPATH` 环境变量
    由于CLASSPATH设置不对引起的较多

    `CLASSPATH=.;%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar`

1. 首先要注意的是最前面的`.;`
    告诉JDK，搜索`CLASS`时先查找当前目录的`CLASS`文件,由于`LINUX`的安全机制引起的，

2. `CLASSPATH`后面指定了`tools.jar`该具体文件，是由java语言的   `import`机制和`jar`机制决定的
