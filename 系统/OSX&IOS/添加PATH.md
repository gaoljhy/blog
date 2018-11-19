如何设置PATH
========

命令：`echo "export PATH=xxxxxx:$PATH" >> ~/.bash_profile`

解释：把`export PATH=xxxxxx:$PATH`输出打印到`~/.bash_profile`中去。

Unix知识补充：`~/.bash_profile`介绍
--------------

　　mac和linux终端一般用bash来进行解析。当bash在读完了整体环境变量的`/etc/profile`并借此调用其他配置文件后，接下来则是会读取用户自定义的个人配置文件。bash读取的文件总共有三种：

　　`~/.bash_profile` 　　`~/.bash_login`  　　`~/.profile`

　　其实bash再启动是只读上面文件的一个，而读取的顺序则是依照上面的顺序。也就是说读到bash_profile就不读后面的了，如果bash_profile不存在，后面的才能有机会。
