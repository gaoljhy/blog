# `_t` 类型

+ `sizeof`返回的必定是无符号整形,在标准c中通过 `typedef` 将返回值类型定义为`size_t`.
    若用`printf`输出size_t类型时,C99中定义格式符%zd;若编译器不支持可以尝试%u或%lu. sizeof，获取操作数占用的内存空间字节数,返回类型size_t； strlen，获取字符数组实际使用的字节数,不包含数组结尾符’\0’，返回类型size_t。

+ 它是一种“整型”类型，里面保存的是一个整数，就像int, long那样。这种整数用来记录一个大小(size)。size_t 的全称应该是size type，就是说“一种用来记录大小的数据类型”。通常用sizeof(XXX)操作，这个操作所得到的结果就是size_t类型。因为size_t类型的数据其实是保存了一个整数，所以它也可以做加减乘除，也可以转化为int并赋值给int类型的变量。

类似的还有wchar_t、 ptrdiff_t。 wchar_t就是wide char type，“一种用来记录一个宽字符的数据类型”。 ptrdiff_t就是pointer difference type，“一种用来记录两个指针之间的距离的数据类型”。 代码举例：

int i; // 定义一个int类型的变量i size_t size = sizeof(i); // 用sizeof操作得到变量i的大小，这是一个size_t类型的值 // 可以用来对一个size_t类型的变量做初始化 i = (int)size; // size_t类型的值可以转化为int类型的值

char c = 'a'; // c保存了字符a，占一个字节 wchar_t wc = L'a';
// wc保存了宽字符a，占两个字节。注意'a'表示字符a，L'a'表示宽字符a

int arr[] = {1, 2, 3, 4, 5}; // 定义一个数组 int* p1 = &arr[0]; // 取得数组中元素的地址，赋值给指针 int* p2 = &arr[3]; ptrdiff_t diff = p2 - p1; //指针的减法可以计算两个指针之间相隔的元素个数，所得结果是一个ptrdiff_t类型 i = (int)diff; // ptrdiff_t类型的值可以转化为int类型的值 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16

+ size_t是全局定义的类型；size_type是STL类中定义的类型属性，用以保存任意string和vector类对象的长度

+ string::size_type 制类型一般就是unsigned int, 但是不同机器环境长度可能不同 win32 和win64上长度差别;size_type一般也是unsigned int

+ 使用的时候可以参考： string::size_type a =123; vectorsize_type b=234; size_t b=456;

+ size_t 使用的时候头文件需要 ；size_type 使用的时候需要或者 

+ `sizeof(string::size_type) sizeof(vector::size_type) sizeof(vector::size_type) sizeof(size_t)` 上述长度均相等，长度为win32:4，win64:8

+ 二者联系：在用下标访问元素时，vector使用vector::size_type作为下标类型，而数组下标的正确类型则是size_t

+ 在编译的过程中size_t类型的a值会被编译他的补码。所以在使用size_t类型数据的过程中尤其要注意，特别是在逻辑表达式中使用到该类型，稍不注意可能带来很严重的后果。 注：正数的补码：与原码相同；负数的补码：符号位为1，其余位为该数绝对值的原码按位取反，然后整个数加1。

+ 不同平台的size_t会用不同的类型实现，使用size_t而非int或unsigned可以写出扩展行更好的代码，即是为了提供一种可移植的代码形式。

## 总结：

用来描述 数据类型的固定类型，不受平台移植影响，长度固定