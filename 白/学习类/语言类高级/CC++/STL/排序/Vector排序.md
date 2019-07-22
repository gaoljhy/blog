# Vector 排序

```cpp
// VectorSort.cpp : Defines the entry point for the console application.
//
 
#include <iostream>
#include <vector>
#include <algorithm>
 
//先自定义一个结构体
struct Test {
    int member1;
    int member2;
};
 
//自定义排序函数
bool SortByM1( const Test &v1, const Test &v2)
//注意：本函数的参数的类型一定要与vector中元素的类型一致
{
    return v1.member < v2.member;
    // 升序排列 
    // 如果返回为 1 ,v1,v2位置不交换
    // 如果返回为 0 ,v1 ,v2位置交换 v1大
}


int _tmain(int argc, _TCHAR* argv[])
{
    std::vector<Test> vecTest;
    std::sort(vecTest.begin(),vecTest.end(),SortByM1);
    std::cout<<"对向量中的第2个到第5个元素按member1进行降序排列:"<<std::endl;
    std::sort(vecTest.begin()+1,vecTest.begin()+5,SortByM1);
    //vecTest.begin()+5为第6个位置
 
    return 0;
}
```