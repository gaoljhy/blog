# rm强删恢复

如果真的删除了不该删除的文件，比如数据库、日志或执行文件

## 模拟场景

+ 删除

误删除服务器目录`/root/selenium/Spider`下的`MySql.Data.dll`文件：

```sh
> rm -f /root/selenium/Spider/MySql.Data.dll
> ll /root/selenium/Spider/MySql.Data.dll
ls: cannot access /root/selenium/Spider/MySql.Data.dll: No such file or directory
```

+ 恢复

1. 使用`lsof`命令查看当前是否有进程打开`/root/selenium/Spider/MySql.Data.dll`文件：

    `> lsof | grep /root/selenium/Spider/MySql.Data.dll`

    从上面可以看出，当前文件状态为已删除（deleted）。

2. 查看是否存在恢复数据：

    `/proc/13067/fd`：进程操作的文件描述符目录。
    `86`：文件描述符。

    `> cat /proc/13067/fd/86`

3. 使用`I/O`重定向恢复文件

    ```sh
    > cat /proc/23778/fd/86 > /root/selenium/Spider/MySql.Data.dll
    > ls -l /root/selenium/Spider/MySql.Data.dll
    -rw-r--r-- 1 root root 702464 Feb 10 12:03 /root/selenium/Spider/MySql.Data.dll
    ```

重新运行程序：
    说明恢复的文件没有问题。

## 原理

在Linux系统中，每个运行中的程序都有一个宿主进程彼此隔离
    以`/proc/进程号`来体现（Linux本质上就是一个文件系统）

比如：
    1. `ls -l /proc/13067` 查看进程PID为13067的进程信息；
    2. 当程序运行时，操作系统会专门开辟一块内存区域，提供给当前进程使用
    3. 对于依赖的文件，操作系统会发放一个文件描述符，以便读写文件
    4. 当执行 `rm -f` 删除文件时，其实只是删除了文件的目录索引节点，对于文件系统不可见
    5. 但是对于打开它的进程依然可见，即仍然可以使用先前发放的文件描述符读写文件

正是利用这样的原理，可以使用`I/O`重定向的方式来恢复文件。

如果不小心误删了文件，不要着急

1. 首先使用  `lsof` 查看打开该文件的进程
2. 然后再使用 `cat /proc/进程号/fd/文件描述符` 查看恢复数据
3. 最后使用I/O重定向的方式来恢复文件。
