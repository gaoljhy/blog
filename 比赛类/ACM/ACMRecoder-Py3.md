# `python` 
> 因为比较慢，所以很少被人使用，但习惯之后，会发现代码效率急速提高
 
注意：Python3.X 源码文件默认使用`utf-8`编码，所以可以正常解析中文，无需指定 `UTF-8` 编码。


----

## 标准 **输入输出** 模版
>基本步骤
1. Python得到的输入是`泛型字符串`，所以需要转类型
2. `slipt()`把字符串按空白符拆开，返回数组`[str]`
3. `map`把`list`里面的值映射到指定类型，返回数组`[type]`
4. `EOF`用抓异常

--- 

1. 有多组输入数据，但没有具体的告诉你有多少组，只是让你对应每组输入，应该怎样输出。
    ```python
    #!/usr/bin/python3
    while True:
    try:
        a,b = map(int , input().split(" "));
        # 自动输出换行符
        print(a+b)
    except EOFError and ValueError:
        # 为了方便在 terminal 中调试 加了 ValueError
        break;
    
    ```
2. 输入一个整数，告诉接下来有多少组数据，然后在输入每组数据的具体值。
    ``` python
    tcas = int(input())
    
    arry = list (input().split())
    # arry 里存放的仍然为字符串
    ```    

3. 这次的输入实现输入一个整数，告诉有多少行<br/>
   对于每一行的输入，有划分为 第一个数 和 其他的数，第一个数代表那一组数据一共有多少输入。
    ```python
    tcas = int(input()

    for cas in range(tcas):
        line = int(input().split())
        tsit = line[0]
        arry = line[1:]
        sum = 0
        for sit in range(n:
            sum = sum + arry[sit]
        print(sum)
    ```
    
4. 最后一行输出不带换行

    ```python
    tcas = int(input())
    for i in range(tcas):
        a,b = map(int,input().split())
        if i < tcas-1 :
            print(a+b)
        else:
            print(a+b,end="")
    ```

