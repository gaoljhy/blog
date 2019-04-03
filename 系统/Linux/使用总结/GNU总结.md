# 总结

## configure

配置的目的是决定将GCC编译器安装到什么地方`${destdir}`
支持什么语言以及指定其它一些选项等。

`${destdir}`不能与`${objdir}`或`${srcdir}`目录相同。

配置是通过执行`${srcdir}`下的`configure`来完成的。

其命令格式为

`${srcdir}/configure --prefix=${destdir} [其它选项]`

### 例

如果想将GCC 4.1.2安装到`/usr/local/gcc-4.1.2`目录下，则`${destdir}`就表示这个路径。

`cd /usr/local/gcc-4.0.1/`
> 这一步很重要，配置安装文件时，需要在目标目录下执行configure命令

 `/root/gcc-4.0.1/configure --prefix=/usr/local/gcc-4.1.2 --enable-threads=posix --disable-checking --enable--long-long --host=i386-redhat-linux--with-system-zlib --enable-languages=c,c++,java`

将GCC安装在`/usr/local/gcc-4.1.2`目录下，支持`C/C++`和`JAVA`语言
> 其它选项参见GCC提供的帮助说明