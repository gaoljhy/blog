## `string`库

在 `string` 库中,结合了俩个类模版 ，`basic_string` 和 `char_traits`

>`string , u16_string ,u32_string ,wstring类 ` 这些类实例，都是基于`basic-string`模版实现的

其中`string` 在`c++11` 中添加的 **独立(非类成员)函数** 多数为数值型与`string`类型互相转换，可以使用`sstream` 代替 ，剩余便是迭代器

这里只做简单了解使用,这些函数的传递参数都为 **固定格式** ,且 **不属于类函数**，直接调用

1. 字符串转数值函数

    `stoi() , stol() , stoul() , stoll() , stoull() , stod() , stold() , stof()`
    
    其中传递参数以`stoi()`为例

    `int stoi (const string&  str, size_t* idx = 0, int base = 10);`
    
    > 第一个参数 ： 字符串(引用)<br>

    > 第二个字符串  ：指向`size_t`类型的对象的指针<br/> 其值由函数设置为 **被转换的数值** 后的 `str` 中下一个字符的 绝对位置。

    >第三个参数 ：转换的进制 ,默认十进制


2. 数值转字符串

    `to_string()` ，默认重载了 各个类型到 `string`类型的转换 ，所以常见数值类型都可转 `string`

---

# `basic_string` 模版成员函数

按常规的类设计有如下几类

1. 默认函数(无特殊变化)
    
    construct ，destruct 构造，析构函数 ，重载操作符 `=` (深拷贝)

2. 容量函数(无特殊变化)

   **长度类**： `size()`，`max_size()`,`resize()`,`empty()`,`clear()`<br/>
    > 其中`size()`和`length()`为同一函数

    内存的开辟默认是以指数(1.2.4.8....)开辟，`size()`==`capacity()`代表满了，下一个内存开辟大小为`目前内存 *2` ，具有极大的浪费<br/>
    内存的开辟，遵循一贯的原则，满了之后(`size = capacity`)，**内存*2**

    **内存类**：`capacity()` ，`reserve()` 预留内存 ，`shrink_to_fit()` 使此时内存=长度
 

3. 迭代器(无特殊变化)

    头`begin()`尾`end()`迭代器 ， 头尾`reverse`(反向)迭代器  ， 头尾常量迭代器 ，头尾`constant——reverse`(常量反向)迭代器 
    
    > 在string中取位置时(像`insert`，`erase`都是要绝对位置)，都要使用 `str.begin()+num` 或 `str.end()+num`

4. 元素取值函数(无特殊变化)

    `[]`操作符重载 ,`at()` ,`front()` , `back()` 
    
    > 其中 `front()` 和 `back()` 在 **长度时刻变化**，但仍要在固定位置取值上十分有用
    
5. `基本操作`

    `+= ， +` 操作符重载 ， `append` , `insert()` , `push_back()` , `pop_back()` , `erase()` , `replace()` , `swap()`

    基本操作以 **插入** ， **删除** ,**替换** 为核心

6. `字符串处理函数`

    `c_str() ,data()` 得到字符串数组

    `copy()` ， `substr()` 获取子串函数

    `find() , rfind() , find_first_of() , find_last_of() ,find_first_not_of() , find_last_last_not_of()` 查找，匹配类函数

    `compare()` 比较函数

7. 非成员类函数 + 操作符

    `> , <  , <= , >= , !=` 
    >除`==`先比较`size` ,,其余都从头至尾依次比较元素

    `>> <<` 流操作符

    `getline()`  读取流中一行操作，**忽略空格**




-----
## 常用操作记录

| 函数                                   | 作用                                      | 注意⚠️                                                                                   |
| :------------------------: | :---------------------------: | :--------------------------: |
| `str.lenght()` 或 `str.size()`         | 测字符串长度 ，返回长度为字符长度         | 以`1`起始记数 |
|`str.resize(unsigned int,[value])`|Change size |如果往大扩展，后面空白的以`value`补，其`value`默认为`0`<br/>往小扩展，从末尾往前删除，留下前面的
|`str.clear()`|删除 `str`每一个元素，使 `size` 为 `0` | 重复使用时，每次循环调用同一个`string`都需要此函数 |
|||
|`str.capacity()`|Return size of allocated storage capacity |返回内存实际开辟的大小
|`str.reserve(int n)`|Request a change in capacity |提前预留内存大小，减少内存开辟的浪费,减少内存开销上很有用
|`str.shrink_to_fit()`|Shrink to fit|调整当前`str`到合适大小
|||
|`str1=str2`|Assign content|深拷贝
|`str.erase()`|Erase elements|删除元素 |
|`str.insert()`|Insert elements| 后面单独列出
|`str.push_back('c')`|在尾部添加一个字符| 没有**返回值(`void`)**
|`str.pop_back()` | 在尾部删除一个字符 | 没有**返回值(`void`)**|
|`str.swap(str2)`|Swap content |交换俩个`string`
|`str.empty()`|Test whether strtor is empty|本质测试`size==0`
|||
|`str.begin()`|Return iterator to beginning |本质上是绝对位置指针 ，作为迭代器，防止溢出
|`str.end()`|Return iterator to end|本质上是绝对位置指针 ，作为迭代器，防止溢出
|||
|`str.substr(pos=0,length)`|Generate substring|从`pos(默认==0)`往后取`length`长度
|`str.replace()`|Replace portion of string |替换
|`find()`|Find first occurrence in string |从前查找第一个匹配的，未查到为`-1`
|`rfind()`|Find last occurrence in string |从后查找第一个匹配的,未查到为`-1`
|||
|`getline(cin , str)` |get line from stream to string|从`cin`，`fin`，`sstream`等等都可以

---
----

## 补，最常用的操作合集
1. `str.insert()` ，被插入的传递多数为 `值` 或 `地址`

    >插入一个字符或字符串   例：
    ```c
    str.insert(6,str2) ;

    str.insert(6,str2,4); //插入 str2 中下标为 0(默认) 的后 4 个到 str 下标为 6 后面

    str.insert(6,str2,3,4); //插入 str2 中下标为 3 的后 4 个到 str 下标为 6 后面

    str.insert(str.begin()+5,str2.begin() ,str2.end()-7); 
    ```

    > 插入n个相同的  例：
    ```c
    str.insert(pos, n , ‘c’); //pos 下标

    str.insert(str.end()-5 , n ,'c');
    ```
    

2. `str.erase()`,被抹去的 传递为 `地址`
    
    >抹去一个 例：
    ```c
    str.erase(str.begin()+num)
    ```
    
    >抹去多个连续元素 例；
    
    ```c++
    str.erase(str.end()-5,str.end()) // 删除这俩个绝对位置之间的

    str.erase(10 , 8)  //`从第10个元素 向后删8个 ，以`0`起始计数
    ```

3. `str.find()` 与 `str.rfind()`
    ```c
    int num = str.find(str2,pos) ; 
    //从 str 的 pos(默认=0) 位置开始到最后  ，找第一次出现 str2 的下标

    int num = str.find(str2,pos , len) ; 
    //从 str 的 pos 位置开始 len 长度 中 ，找第一次出现 str2 的下标

    ```

4. `str.replace()`

```c

  str.replace(9,5,str2);

  str.replace(19,6,str3,7,6);
```
```
  // Using iterators:                                               
  str.replace(str.begin(),str.end()-3,str3);    

  str.replace(str.begin()+11,str.end(),str4.begin(),str4.end());

```