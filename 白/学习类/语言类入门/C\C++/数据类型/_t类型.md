# _t 类型

1. `sizeof`返回的必定是无符号整形,在标准`c`中通过 `typedef` 将返回值类型定义为`size_t`.
    若用`printf`输出`size_t`类型时,C99中定义格式符`%zd`;
    若编译器不支持可以尝试`%u`或`%lu`.
    1. `sizeof`，获取操作数占用的内存空间字节数,返回类型`size_t`
    2. `strlen`，获取字符数组实际使用的字节数,不包含数组结尾符`\0`，返回类型`size_t`

2. 它是一种 **整型** 类型，里面保存的是一个整数，就像`int, long`那样
    这种整数用来记录一个大小(`size`)
    `size_t` 的全称应该是`size type`，就是说 **一种用来记录大小的数据类型**
    1. 通常用`sizeof(XXX)`操作，这个操作所得到的结果就是`size_t`类型。
    2. 因为`size_t`类型的数据其实是保存了一个整数，所以它也可以做加减乘除，也可以转化为`int`并赋值给`int`类型的变量。

3. 类似的还有`wchar_t、 ptrdiff_t`
    1. `wchar_t`就是`wide char type`，一种用来记录一个宽字符的数据类型
    2. `ptrdiff_t`就是`pointer difference type`，一种用来记录两个指针之间的距离的数据类型

    代码举例：

    ```c
    int i;                   // 定义一个int类型的变量i
    size_t size = sizeof(i);

    // 用sizeof操作得到变量i的大小，这是一个size_t类型的值
    // 可以用来对一个size_t类型的变量做初始化

    i = (int)size;           // size_t类型的值可以转化为int类型的值
    char c = 'a';       // c保存了字符a，占一个字节
    wchar_t wc = L'a';  
    // wc 保存了宽字符a，占两个字节。
    // 注意'a'表示字符a，L'a'表示宽字符a

    int arr[] = {1, 2, 3, 4, 5}; // 定义一个数组
    int* p1 = &arr[0];           // 取得数组中元素的地址，赋值给指针
    int* p2 = &arr[3];
    ptrdiff_t diff = p2 - p1;
    //指针的减法可以计算两个指针之间相隔的元素个数，所得结果是一个ptrdiff_t类型

    i = (int)diff;          // ptrdiff_t类型的值可以转化为int类型的值
    ```

4. `size_t`是全局定义的类型
    `size_type`是`STL`类中定义的类型属性，用以保存任意`string`和`vector`类对象的长度

5. `string::size_type` 制类型一般就是`unsigned int`
    1. 但是不同机器环境长度可能不同 `win32` 和 `win64` 上长度差别
    2. `size_type`一般也是`unsigned int`

6. 使用的时候可以参考：

    ```c
    string::size_type a =123;
    vectorsize_type b=234;
    size_t b=456;
    ```

7. `size_t` 类型定义在`cstddef`头文件中，该文件是C标准库的头文件`stddef.h`的C++版。
    > 它是一个与机器相关的`unsigned`类型，其大小足以保证存储内存中对象的大小。

    使用 `size_type` 时，一定要注意包含头文件 `string`(`vector.h`)，否则会提示未申明。
    或者用 `string::size_type` 方式，来使用`string` 类中声明的参数。

    ```c
    sizeof(string::size_type) 
    sizeof(vector::size_type) 
    sizeof(vector::size_type) 
    sizeof(size_t)
    ```

    上述长度均相等，长度为`win32:4，win64:8`

8. 二者联系：
    1. 在用下标访问元素时，`vector`使用`vector::size_type`作为下标类型
    2. 而数组下标的正确类型则是`size_t`

9. 在编译的过程中`size_t`类型的`a`值会被编译他的补码。
    所以在使用`size_t`类型数据的过程中尤其要注意，特别是在逻辑表达式中使用到该类型，稍不注意可能带来很严重的后果。

    注：
    1. 正数的补码：与原码相同；
    2. 负数的补码：符号位为1，其余位为该数绝对值的原码按位取反，然后整个数加1。

10. 不同平台的`size_t`会用不同的类型实现
    使用`size_t`而非`int`或`unsigned`可以写出扩展行更好的代码，即是为了提供一种**可移植**的代码形式。
