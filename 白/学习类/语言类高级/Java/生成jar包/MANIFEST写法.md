
## 关于 MANIFEST.MF 写法.
例如打包的jar为 Test.jar 

```
Manifest-Version: 1.0 
Main-Class: windows.VideoWindow 
Class-Path: lib\org.eclipse.swt_3.3.0.v3346.jar lib\org.eclipse.swt.win32.win32.x86_3.3.0.v3346.jar 
```

上面为打包为jar中的包说明文件. 下面这个报错一直出现. 
`could not find main class. Program will exit `
这个错误提示其实不是没有发现main class. 而是`jar`如果有错误执行不了,就会出现这个错误.

 打包完成后, 要先运行 `cmd -> java -jar your.jar` 确认没有问题即可执行jar. 使用-jar参数后, 系统的Classpath 变量不再起作用. 
 
 虚拟机将去MANIFEST.MF中的Class-Path 下找相关的包. 

然后才能成功的从:` windows.VideoWindow `的`main`方法进入. 否则没有相关连接包,则会提示找不到`main class`. 而大家可能还迷糊的找不到北. 明明有main class吗. 


如果这个写的不对. 则就会一直报错. 
看看上面这个`Class-Path:` 后面的写法. 空格分开. 绝对不能有分号.切记. 

最后必须有换行. 这个也是要注意的. 否则依然提示没有mainclass. 

不要因为这个小事情耽误了时间. 其中 lib/ 表示这个jar必须在打包Test.jar所在目录的一个lib子目录中. 

运行jar需要命令: java -jar Test.jar 
双击也可以, 则使用 javaw 打开. 

关于java -classpath a.jar;b.jar; class test.Test 执行时. a.jar;b.jar; 后面都必须有分号. 否则报错. 不要指望不写classpath让系统自己找. 这不是在eclipse里面.必须写上你要使用的类. 否则总会提示您编译出错.

个人