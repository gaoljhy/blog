# malloc

## realloc

+ 动态内存调整 - `reset allocation`

realloc原型是

`extern void *realloc(void *mem_address, unsigned int newsize);`

### 语法

`指针名 =（数据类型*）realloc（要改变内存大小的指针名，新的尺寸）`

新的尺寸可比原尺寸大也可小

1. 如果新的大小大于原内存大小，则新分配部分不会被初始化；
2. 如果新的大小小于原内存大小，可能会导致数据丢失

### 头文件

`#include <stdlib.h>`
有些编译器需要`#include <malloc.h>`
> 在`TC2.0`中可以使用`alloc.h`头文件

### 功能

先判断当前的指针是否有足够的连续空间

1. 如果有，扩大`mem_address`指向的地址，并且将`mem_address`返回
2. 如果空间不够，先按照`newsize`指定的大小分配空间
    1. 将原有数据从头到尾**拷贝**到新分配的内存区域
    2. 而后释放原来`mem_address`所指内存区域
        >注意：原来指针是自动释放，不需要使用free
    3. 同时返回**新分配**的内存区域的**首地址**。即重新分配存储器块的地址。

### 返回值

如果重新分配成功则返回指向被分配内存的指针，否则返回空指针`NULL`

+ 注意
    1. 当内存不再使用时，应使用`free()`函数将内存块释放。

----------------------

## 其余

`malloc、calloc、free、_alloca`
