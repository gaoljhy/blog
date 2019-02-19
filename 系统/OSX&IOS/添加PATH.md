# 如何设置 PATH

命令：`echo "export PATH=xxxxxx:$PATH" >> ~/.bash_profile`

解释：把`export PATH=xxxxxx:$PATH`输出打印到`~/.bash_profile`中去。

## Unix 知识补充：`~/.bash_profile`介绍

mac 和 linux 终端一般用 bash 来进行解析。当 bash 在读完了整体环境变量的`/etc/profile`并借此调用其他配置文件后，接下来则是会读取用户自定义的个人配置文件。bash 读取的文件总共有三种：

`~/.bash_profile` 　　`~/.bash_login` 　　`~/.profile`

其实 bash 再启动是只读上面文件的一个，而读取的顺序则是依照上面的顺序。也就是说读到 bash_profile 就不读后面的了，如果 bash_profile 不存在，后面的才能有机会。
