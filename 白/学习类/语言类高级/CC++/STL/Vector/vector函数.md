# vector

## 创建对象：

```cpp
//创建一个空的vector对象
vector<int> v1;

//创建一个有10个空元素的容器
vector<int> v2(10) 

//创建一个有10个元素0的容器
vector<int> v3(10, 0); 

// 创建一个 二维度 Vector数组
vector<vector<int>> v4; 

//创建string类型元素的vector，并赋值，显示

string str[] = {"Alex", "John", "Robert"};
vector<string> v5(str+0, str+3);

//iterator 迭代器
vector<string>::iterator sIt = v5.begin();

while ( sIt != v4.end() ) cout<< *sIt++ << " ";

//使用V4给V5初始化
vector<string> v6(v5); 
```

----------------

## assign() 分配

```cpp
int ary[] = {1, 2, 3, 4, 5};
vector<int> v;

// 此时v和ary中的内容一样
v.assign(ary, ary+5); 

copy(v.begin(), v.end(), ostream_iterator<int>(cout, " ") );

//此时v中内容{100, 100, 100}
v.assign(3, 100); 
```

---------------

## at()   

```cpp
vector<int> v(3,0);
//此时v中3个0
v[0] = 100;

v.at(1) = 200; 
// 等价于v[1] = 200;

for ( int i=0; i<3; i++ )
    cout << v.at(i) << " "; 

OUTPUT:    // 100 200 0
```

## back() , push_back()

```cpp

//借助上面例子
cout << v.back() <<endl; 
//输出结果为0,   v.back()返回容器中最后一个元素的引用

v.push_back(123); 
//将123加到容器的最后位置，此时v.back()返回值为123
```

```cpp
pop_back()：将容器的最后一个元素拿出

front()：返回容器中第一个元素的引用

begin() :  v.begin() //  返回指向容器起始位置的迭代器

rbegin()：返回一个逆序迭代器，指向容器的最后一个元素

end()：   v.end() //返回一个指向当前vector末尾元素的下一位置的迭代器

rend()：返回一个逆序迭代器，指向容器第一个元素前面的位置



capacity()：容器能存储数据个数  容器容量

size()：       容器实际元素的个数

resize()：    指定有效元素的个数

reserve()： 指定容器能存储数据的个数



clear() ： 清空容器

empty() : 判断容器是否为空，返回一个bool值

erase():  删除某个或某些节点 需要传递具体位置 可用 vector.begin()+num 来指定

insert(position, value)：在容器中某个位置插入一个值

max_size()：表示容器允许的最大元素数

v1.swap(v2)：交换两个容器的内容
```