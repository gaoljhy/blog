## 题意理解及判定过程

1. `ACM`中指定有`test`种情况，代表的是，只有这`test`个数据，做完这些就完了

2. 每一道题，都存在中止情况，
> 一般都会以文件形式输入，`<` ,所以，此时中止符为`EOF`

而检测是否正确就是实时匹配，文件是否一致

## 常见注意点

1. 在外部定义变量，可定义较大数组，vector

2. 使用同一变量时，一定要在下一次 **循环情况** 中记得初始化

3. 标准化 `test case`格式
    ```
    int test,cas = 1;
    cin >> test ; 
    while(test--){
        ....
        cout << "Case " << cas++ << ":" << endl ;
        
        ....
        ....
        //输出结果
        if(test > 0){
            cout << endl;
            //最后的格式化输出
        }
    }
    ```

4. `vector` 的标准 `get`输入
    ```
    int N = 0;
    cin >> N ;
    vec.resize(N,<value>);
    for(int i = 0 ; i < vec.size() ;i++ ){
        cin >> vec[i];
    }
    ```

---
## 常用函数(都将基于`g++`，与其他编译器很大出入)

### 1. `string`库

| 函数                                   | 作用                                      | 注意⚠️                                                                                   |
| :------------------------: | :---------------------------: | :--------------------------: |
| `str.lenght()` 或 `str.size()`         | 测字符串长度 ，返回长度为字符长度         | 以`1`起始记数 |
| `str.push_back('c')`|在尾部添加一个字符| 没有**返回值(`void`)**
|`str.pop_back()` | 在尾部删除一个字符 | 没有**返回值(`void`)**                                                       |
### 2. `algorithm`库 

| 函数                                   | 作用                                      | 注意⚠️                                                                                   |
| :------------------------: | :---------------------------: | :--------------------------: |
| `max(a,b)` 或 `min(a,b)`               | 返回数中最大或最小值                      | 可在`int,long,double`等数值型数据中使用<br/>且正负数也考虑在内<br/>相等时，随便输出一个 |

### 3. `vector`库

| 函数                                   | 作用                                      | 注意⚠️                                                                                   |
| :------------------------: | :---------------------------: | :--------------------------: |
|`vec.size()`|Return size |以`1`起始记数
|`vec.push_back(vecEle))`|Add element at the end |  `resize`之后的那部分并不是空的<br/>添加到末尾，之前要看是否与`resize`冲突
|`vec.pop_back()`|Delete last element | 删除一个从末尾，size -1
|`vec.resize(unsigned int,<value>)`|Change size |如果往大扩展，后面空白的以`value`补，其`value`默认为`0`<br/>往小扩展，从末尾往前删除，留下前面的
|`vec.clear()`|删除 `vec`每一个元素，使 `size` 为 `0` | 重复使用时，每次循环调用同一个`vector`都需要此函数 
|`vec.insert()`|Insert elements| 
|`vec.erase()`|Erase elements|
|`vec.swap()`|Swap content |
|`vec.emplace()` |Construct and insert element|
|`vec.emplace_back()  `|Construct and insert element at the end |
|`vec.max_size`|Return maximum size |
|`vec.capacity()`|Return size of allocated storage capacity |
|`vec.empty()`|Test whether vector is empty|
|`vec.reserve()`|Request a change in capacity |
|`vec.shrink_to_fit()`|Shrink to fit|







-----
## 失误记录
1. 运算优先级没有记清楚<br/>
    以防万一，能加`()`的 都加
    ```
    liu = qian + (A[j] - '0' + B[j] - '0') % 10;<br/>
    liu = (qian + (A[j] - '0' + B[j] - '0') )% 10;
    ```
    ```
    qian = (A[j] - '0' + B[j] - '0') / 10;<br/>
    qian = qian + (A[j] - '0' + B[j] - '0') / 10;<br/>
    qian = (qian + (A[j] - '0' + B[j] - '0')) / 10;
    ```
2. 数值比较中，初始化的数据<br>
    标准做法是: `before = 给出的数据中的第一个数`
    ```
    比较大小，有 N 个数，每个数介于 -1000 到 1000 之间 ，取出其中最大的
    上一次比较的数据before 与 这一次比较的数据now 进行比较

    初始化 before 时 ，千万不能以 0  来定义，如果 N 个数，都是负数，那结果，一定是错误的

    ```

3. 递归转循环 ,最简单，从头算起 ,用数组运算代替函数
    ```
    f(1) = 1, f(2) = 1, f(n) = (A * f(n - 1) + B * f(n - 2)) mod 7.
    
    num[1] = 1 ;num[2] =1;
    for(int i =3 ; i < n ; i++){
        num[i] = (A * num[i-1] + B * num[i-2] ) % 7 ;
    }
    ```

4. 内存超限
    
    `vector` 的 `clear` 多次使用 ，所有使用过的内存都会算在其中 ，因为是从堆里面开辟出来 <br>
    此时为了节省内存 ，可使用**大数组** ，或固定长度 的 `vector` ,以保证 不开辟新的空间
    
----
## 附件

[**ASCILL**表](https://github.com/gaoljhy/blog/blob/master/img-%E9%80%9A%E7%94%A8%E5%90%88%E9%9B%86/Ascill.jpg?raw=true)

