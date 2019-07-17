## `sleep` 休眠函数
   1. 功 能: 执行挂起一段时间
　　2. 定 义: `unsigned sleep(unsigned seconds);`
> 在`VC`中使用带上头文件
　　`#include <windows.h>`

> 在`gcc`编译器中，使用的头文件因gcc版本的不同而不同
    linux系统需要添加的头文件　　`#include <unistd.h>`

## 注意

　　1. 在`VC`中`Sleep`中的第一个英文字符为大写的`S`
　　2. 在标准`C`中是`sleep`, 不要大写
    > 简单的说VC用Sleep, 别的一律使用sleep.
　　
Sleep函数的一般形式:
>　　Sleep(unisgned long);
　　其中，Sleep()里面的单位，是以`毫秒`为单位，所以如果想让函数滞留1秒的话，应该是`Sleep(1000)`;

在`gcc`下,`sleep()`里面的单位是秒，而不是毫秒。

> linux下，用`g++`编译，得添加`unistd.h`头文件，gcc则加不加都可以，因为标准C中有`sleep`文件了。

###  但可以使用这个方式来实现毫秒级掩延时
> sleep(1); //停留1秒 
> usleep(1000); //停留1毫秒 ,1000*1000为一秒