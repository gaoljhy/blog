## `vector`库

`vector`是一个模版类
主要函数分为
1. 默认函数 

    构造(construct)函数，析构(destruct)函数<br/>
    `=` 操作符重载(深拷贝，全部复制过来)

2. `容量函数`

    长度类： `size()`，`max_size()`,`resize()`,，`empty()`<br/>
    
    >内存的开辟默认是以指数(1.2.4.8....)开辟，`size()`==`capacity()`代表满了，下一个内存开辟大小为`目前内存 *2` ，具有极大的浪费<br/>
    
    内存类：`capacity()` ，`reserve()` 预留内存 ，`shrink_to_fit()` 使此时内存=长度

3. 迭代器函数(指针)

    头`begin()`尾`end()`迭代器 ， 头尾reverse(反向)迭代器  ， 头尾常量迭代器 ，头尾constant——reverse(常量反向)迭代器 
    
    > 在vector中取位置时(像`insert`，`erase`都是要去绝对位置)，都要使用 `vec.begin()+num` 或 `vec.end()+num`

4. 元素取值函数

    `[]`操作符重载 ,`at()` ,`front()` , `back()` ,`data()`  数据指针

5. `基本操作函数`

    `push()` ,`pop()` ,`assign()` ,`insert()` ,`erase()` ,`swap()` , `clear()` 

6. 操作符

    `> , <  , <= , >= , !=` 
    >除`==`先比较`size` ,,其余都从头至尾依次比较元素


---
## 常用函数记录

| 函数                                   | 作用                                      | 注意⚠️                                                                                   |
| :------------------------: | :---------------------------: | :--------------------------: |
|`vec.size()`|Return size |以`1`起始记数
|`vec.resize(unsigned int,<value>)`|Change size |如果往大扩展，后面空白的以`value`补，其`value`默认为`0`<br/>往小扩展，从末尾往前删除，留下前面的
|`vec.clear()`|删除 `vec`每一个元素，使 `size` 为 `0` | 重复使用时，每次循环调用同一个`vector`都需要此函数 |
|||
|`vec.capacity()`|Return size of allocated storage capacity |返回内存实际开辟的大小
|`vec.reserve(int n)`|Request a change in capacity |提前预留内存大小，减少内存开辟的浪费,减少内存开销上很有用
|`vec.shrink_to_fit()`|Shrink to fit|调整当前`vec`到合适大小
|||
|`vec.push_back(vecEle))`|Add element at the end |  size+1
|`vec.pop_back()`|Delete last element | size-1
|`vec.insert()`|Insert elements| 后面单独列出
|`vec.erase(position ,[last_position])`|Erase elements|删除单个元素 例：`vec.erase(vec.begin()+num)` <br/>或 删除多个连续元素 例；`vec.erase(vec.end()-5,vec.end())`
|`vec1=vec2`|Assign content|深拷贝
|`vec.swap(vec2)`|Swap content |交换俩个同类型的`vector`
|`vec.max_size()`|Return maximum size |
|`vec.empty()`|Test whether vector is empty|本质测试`size==0`
|||

---
## 补
1. `vec.insert()` ，被插入的传递多数为 `值` 或 `地址`

    >插入一个   例：
    ```
    vec.insert(vec.begin()+5,vec_type vt);
    ```

    > 插入n个相同的  例：
    ```
    vec.insert(vec.end()-5 , n ,vec_type vt);
    ```
    >插入多个不同的 例；
    ```
    vec_type arry[]={vt1,vt2,vt3,...}

    vec.insert(vec.end()-1 ,arry ,arry + 5 )
    ```

    > 插入另一个vector
    ```
    vec.insert(vec.begin()+5 , vec2.begin()+3 ,vec2.end()-6)
    ```

