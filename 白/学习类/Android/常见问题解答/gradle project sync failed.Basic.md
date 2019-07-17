`Android studio`下报错
=================

`gradle project sync failed.Basic functionality(e.g.editing,debugging) will not work properly.`

主要原因 Android SDK工具未安装成功


解决方案：

点击 自动安装 ，等待安装成功


手动安装
---------------

1. 进入项目目录下
2. 找到 `gradle\wrapper\gradle-wrapper.properties` 文件

打开，内容如下：

```bash
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https://services.gradle.org/distributions/gradle-2.14.1-all.zip
```
最后一句 `https://services.gradle.org/distributions/gradle-2.14.1-all.zip`

`studio`会下载上面的`Gradle`，墙和链接的原因导致下载不下来
可以手动下载这个版本的`Gradle`，无需解压直接拷贝到

`用户根目录下\.gradle\wrapper\dists\gradle-2.10-all\a4w5fzrkeut1ox71xslb49gst（一串md5）`下即可，重启`studio`，问题解决


