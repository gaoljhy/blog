如果忘记了root账号密码，是可以通过进入单用户模式或其它方法修改密码的。
当然，具体方式跟`Boot Loader`、`操作系统`有关系，`GRUB`与`LILO`的实现方式有所不同。
`Boot Loader` 是在操作系统内核运行之前运行的一段小程序。通过这段小程序，我们可以初始化硬件设备、建立内存空间的映射图，从而将系统的软硬件环境带到一个合适的状态，以便为最终调用操作系统内核准备好正确的环境。



Ubunt
----------------------

1. 强制重启Linux系统，进入如下所示界面，你可以按上下键，选择一个选项后按”e”键。 
2. 进入下面GRUP界面 

3. 选中第一行，然后按“e”进行编辑
4. 然后把`ro  test splash vga=791`(`ro` 后面的那一行全部)更改为`rw single  init=/bin/bash`即可
    > 修改完以后重启又回变回原样 `ro  test splash vga=791`
5. 然后按`Ctrl+x`重新引导 


## 注：
`Ubuntu`一开始的的默认`root`密码是随机的，即每次开机都有一个新的root密码。
可以在终端输入命令 sudo passwd，然后输入当前用户的密码，然后进行修改

> 其他版本基本流程不变

Centos
----------------------------------
通用方法一
    1. 把 `ro`改为 `rw init=/sysroot/bin/sh`. 然后 `Ctrl+x`启动
    2. 依次输入以下命令进行`root`密码修改，修改完成之后强制重启即可。  
        1. `chroot /sysroot/`
        2. `passwd `
        3. `touch / .autorelabel`


方法二
    1. 在`UTF-8`后面输入`init=/bin/sh` 
    2. `ctrl+x`重新引导
    3. 输入`mount -o remount,rw / ` 挂载硬盘，具有读写权限
    4. 然后输入`passwd`设置新密码，如下图
    5. 输入 `touch  /.autorelabel`  更新系统信息(`根目录下文件`)

-----
`logout`
俩次 `exit `
`exit`