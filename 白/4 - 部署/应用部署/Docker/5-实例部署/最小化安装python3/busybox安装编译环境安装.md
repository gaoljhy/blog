# BusyBOx

在编译busybox软件时报错`arm-none-linux-gnueabi-gcc: not found`”或者 `configure: error: no acceptable C compiler found in $PATH`。

> 说明在编译时没有找到交叉编译工具。

## 解决办法

1. 下载交叉编译工具文件`arm-linux-4.4.1.tar.gz`
2. 放在linux的一个目录下，这个目录将会成为交叉编译工具的安装目录，不能随便删除了。
   > 存放目录一般为 `/usr/local/arm`

3. 采用`shell`命令：`tar -xvf arm-linux-4.4.1.tar.gz 4.4.1`
   > 解压压缩包并重名为“4.4.1”。

4. 查看目录`4.4.1`中的内容，可知里边有一个`arm-none-linux-gnueabi`目录。
5. 进入之后里边有一个`bin`目录，里面可以找到`arm-none-linux-gnueabi`相关的交叉编译工具可执行文件。
   > 至此已经找到交叉编译工具的存放路径：`/usr/local/arm/4.4.1/arm-none-linux-gnueabi/bin`
   > 此执行文件已经编译完成，直接使用即可

6. 配置环境变量
   1. `vim /etc/profile` 打开环境变量配置文件。
   2. 在最后一行添加：`export PATH=$PATH:/usr/local/arm/4.4.1/arm-none-linux-gnueabi/bin`
   3. 保存后退出。

7. 执行刷新命令：`source /etc/profile`
   > 使刚才修改的环境变量生效。

8. 验证一下是否安装成功
   `arm-none-linux-gnueabi-`
   然后按`Tab`键，可以显示所有的`arm-none-linux-gnueabi`工具。
   这说明环境变量设置成功。

附加：

1. 在`shell`命令行输入：`arm-none-linux-gnueabi-gcc -v`，会显示交叉编译器的版本信息。
    如果还是提示未找到`arm-none-linux-gnueabi-gcc`，则可能是缺少32位的库造成的。
2. 安装 `ia32-libs`安装32位的库之后重新执行测试

3. 重新对busybox进行配置，然后执行make指令成功。

----

## 或者直接安装 gcc

下载这些包

```conf
mpfr-3.1.1-4.el7.x86_64.rpm
libmpc-1.0.1-3.el7.x86_64.rpm
kernel-headers-3.10.0-123.el7.x86_64.rpm
glibc-headers-2.17-55.el7.x86_64.rpm
glibc-devel-2.17-55.el7.x86_64.rpm
cpp-4.8.2-16.el7.x86_64.rpm
gcc-4.8.2-16.el7.x86_64.rpm
```

单个安装也可以

`rpm -i`

rpm -i glibc-devel-2.17-196.el7.x86_64.rpm
rpm -i glibc-headers-2.17-196.el7.x86_64.rpm
rpm -i glibc-headers-2.17-196.el7.x86_64.rpm
rpm -i kernel-headers-3.10.0-693.el7.x86_64.rpm
rpm -i libmpc-1.0.1-3.el7.x86_64.rpm
rpm -i mpfr-3.1.1-4.el7.x86_64.rpm
rpm -i cpp-4.8.5-16.el7.x86_64.rpm

多个安装

`rpm -i *.rpm`