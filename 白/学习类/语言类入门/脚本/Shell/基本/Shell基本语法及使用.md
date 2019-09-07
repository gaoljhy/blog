## Shell介绍
`Shell`的作用是解释执行用户的命令，用户输入一条命令，`Shell`就解释执行一条，这种方式称为**交互式（Interactive）**

`Shell`还有一种执行命令的方式称为**批处理（Batch）**，用户事先写一个`Shell`脚本（Script），其中有很多条命令，让`Shell`一次把这些命令执行完，而不必一条一条地敲命令。
>`Shell`脚本和编程语言很相似，也有**变量**和**流程控制**语句，但`Shell`脚本是**解释执行**的，不需要**编译**，`Shell`程序从脚本中一行一行读取并执行这些命令，相当于一个用户把脚本中的命令一行一行敲到`Shell`提示符下执行。
不同系统上可由不同的`shell`组成


**在`/etc/shells`文件中给出系统已知的`Shell`，可`cat` 或 `vim` 查看：**

![ss](https://img-blog.csdn.net/20180328064715812?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

---
### 脚本文件
可以通过`touch`命令创建一个`temp.sh`的文件
创建好后脚本文件后就可以在文件内用b要求的格式编写脚本程序了。

在创建的脚本文件中输入以下下代码并保存退出
```
#！/bin/bash
echo "hello world!"
```
> 第一行为文件默认 运行指定，为`/bin/bash`程序

添加脚本文件的可执行运行权限`chmod 777 script.sh`, 后运行文件`./script.sh`得到结果：
```
hello world!
```

`Shell`脚本中用`#`表示注释，相当于C语言的`//`注释。但如果#位于第一行开头，并且是`#!（称为Shebang）`则例外，它表示该脚本使用后面指定的解释器`/bin/sh`解释执行。**每个脚本程序必须在开头包含这个语句。**


---
### `Shell bash`语法

#### 一. 变量
	[1] 环境变量
		环境变量可以从 父进程 传给 子进程 ，因此 Shell 进程的环境变量可以从当前    Shell 进程传给 fork 出来的 子进程。
		用 printenv 命令可以显示当前 Shell 进程的环境变量。
	[2] 本地变量
		只存在于当前 Shell 进程
		用 set 命令可以显示当前 Shell 进程中定义的所有变量（包括 本地变量 和 环境变量 ）和 函数。
	[3] 变量 定义 和 赋值
		变量赋值时 = 两边不能有 空格，否则会被 Shell 解释成命令和命令行参数。

![这里写图片描述](https://img-blog.csdn.net/20180328103025931?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

#### 变量取值：变量获取： `$` 放在变量前面 或者 `${变量}` 时表示获取变量的值。

> 例：
 ```
 a="hello world!"
 echo $a
 ```
>第一行定义了变量 a 并为其赋值为 `hello world!`<br/>
>第二行用 `$` 取 a 的值并用 `echo` 将a的值输出来。
<br/>

>和 C语言 不同的是，Shell 变量不需要明确定义类型，事实上Shell变量的值都是字符串<br/>

>比如定义`VAR=45`，其实 VAR 的是 `字符串45` 而 非整数。

**Shell 变量不需要 先定义 后使用，如果对一个没有定义的变量取值，则值为空字符串。**

### 二. 常用代换
>文件名代换：`* ？ []`

`*`	匹配 0 个或多个任意字符

`？`	匹配一个任意字符

`[字符]`	匹配 方括号中 任意一个字符的一次出现

这些用于匹配的字符称为通配符。
![dadas](https://img-blog.csdn.net/20180328105754371?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

>命令代换: `$()`

由 `&()` 括起来的也是一条命令

`Shell` 先执行该命令，然后将输出结果立刻代换到当前命令行中。
![asdas](https://img-blog.csdn.net/20180328110250912?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

>**算数代换**：`$(())`

`$(())`中的`Shell`变量取值将转换成 **整数** 

`$(())` 中只能用`+-*/`和`()`运算符，并且只能做整数运算。
![asda](https://img-blog.csdn.net/20180328103616469?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

---
## 符号

1. 转义字符

        和多数语言类似， \ 在 Shell 中被用作 转义字符
        
        用于去除紧跟其后的单个字符的特殊意义（回车除外），换句话说，紧跟其后的字符取字面值。

2. 单引号

        Shell 脚本中的 单引号 和 双引号 一样都是 字符串的界定符,而不是字符的界定符。
        
        单引号用于保持引号内所有字符的字面值，即使引号内的 \ 和 回车 也不例外，但是字符串中不能出现单引号。

        如果引号没有配对就输入回车，Shell会给出续行提示符，要求用户把引号配上对。

3. 双引号
        
        双引号用于保持引号内所有字符的字面值（**回车也不例外**）
        但以下情况除外：

        
         $ 加变量名     可以取变量的值
        
```
反引号仍表示命令替换
\$ 表示$的字面值
\` 表示`的字面值
\" 表示"的字面值
\\ 表示\的字面值
除以上情况之外，在其它字符前面的\无特殊含义，只表示字面值
```

---
### 三. 控制语句

##### ``` if , then , elif , else ,fi```

在Shell中用`if`、`then`、`elif`、`else`、`fi`这几条命令实现分支控制。<br/>
这种流程控制语句本质上也是由若干条`Shell`命令组成的。

使用时需要注意点：
>每一组`if , then`的结束都应附上一个`fi`与`if`对应<br/>
`[]`应当注意用空格隔开，`]`后紧跟`;`<br/>
注意⚠️ ：`[]`内的条件与`[` 、`]`都有一个空格相隔。

例：
```
if [ -f $a ];then  
        echo "hello world!"  
fi  
```
>`if [ -f $a ]`是第一条
`then echo "hello world!"`是第二条
`fi`是第三条

如果两条命令写在同一行则需要用`;`号隔开，一行只写一条命令就不需要写`;`号了
注：
>`then`后面有换行，但这条命令没写完，`Shell`会自动续行，把下一行接在`then`后面当作一条命令处理。
和`[`命令一样，要注意`命令`和`各参数`之间必须用空格隔开。
`if`命令的参数组成一条子命令，如果该子命令表示真，则执行`then`后面的子命令，如果非`0`表示假，则执行elif、else或者fi后面的子命令。
![asfadas](https://img-blog.csdn.net/20180328112243327?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
`if`后面的子命令通常是测试命令，但也可以是其它命令。
`Shell`脚本没有{}括号，所以用fi表示if语句块的结束。

#####`case` , `esac`
`case`命令可类比C语言的`switch/case`语句，`esac`表示`case语句块的结束`。

C语言的`case`只能匹配`整型`或`字符型常量表达式`，而`Shell`脚本的`case`可以匹配`字符串`和`Wildcard`
**只匹配一个分支，然后就跳出**
每个匹配分支可以有若干条命令，末尾必须以`;;`结束，执行时找到第一个匹配的分支并执行相应的命令，然后 直接跳到 `esac`之后，不需要像C语言一样用`break`跳出。
```
case “$var” in

        conditionl )

                statments1;;

        conditionl )

                statment2;;

        …

        * ) default statements;;

esac
```

注意：
```
conditionl(条件) 使用 空格 与 ）隔开
statement*(行为) 后使用两个 ;; 结尾

* ) 后陈诉 除 以之前的 statements 之外的情况
使用 esac 与 case 呼应结尾
```
![adssadasd](https://img-blog.csdn.net/20180328113307308?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

### `for`,`do`,`done`

该循环类似于某些编程语言的`foreach`循环。
`for/do/done`使用规则
```
for var in list

do 
    statement

done
```
其中，`var`是要列举的变量，`list`是变量`var`的一个集合，`do....done`中的语句表示在`list` 中还 **未被列举完** 时需要执行的语句。

注意：

`for`后面的变量不加`$`,但在`do...done`中要使用 `var`变量时需要加上`$`
若使用`()`将`list`括起来时，`list`中的内容将会被视为**一个元素**
当`for`后没有跟`in [list]`部分时，则循环控制变量将**取遍命令行的所有参数**

当在`shell`界面写脚本语句时，若`for`语句和`do`语句都写在同一行，则`for`语句后面需要用`;`

例：
![aSAs](https://img-blog.csdn.net/20180328114553364?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xlbmRx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
```
for a in $(ls /home/www/)  
do  
        if [ -f $a ]  
               iconv -f utf-8 -t gbk $a  
        fi  
done  
```
当`/home/www`下的文件或者目录未被列举完时，若检索到的当前变量`a`为文件，则把所有的`utf-8`编码的文件转换为`gbk`编码。



###`while`,`do`,`done`
与多数语言相同

```

COUNTER=1

while [ "$COUNTER" -lt 10 ]; do 

        echo "Here we go again" 

        COUNTER=$(($COUNTER+1))

done
```

**`Shell`还有`until`循环，类似C语言的`do...while`循环。**



---

## 函数
和C语言类似，Shell中也有函数的概念(用set命令可以查看到内置函数)

但是函数定义中没有返回值也没有参数列表。如：
```
#! /bin/sh
foo() { echo "Shell bash function is called"; }

echo "---start--"
foo
echo"---end--"
```

在shell下使function.sh脚本获取可执行权限并执行脚本：
```
chomd +x function.sh

./function
```

>注意函数体的左花括号`{`和后面的命令之间必须有空格或换行

>如果将最后一条命令和右花括号`}`写在同一行，命令末尾必须有`;`号。


在定义`foo()`函数时并不执行函数体中的命令，就像定义变量一样

只是给`foo`这个名字一个定义，到后面调用`foo`函数的时候才执行函数体中的命令。

>注意 : Shell中的函数调用不写括号

`Shell`脚本中的函数必须先定义后调用，一般把函数定义都写在脚本的前面，把函数调用和其它命令写在脚本的最后

### 函数参数

`Shell`函数没有参数列表并不表示不能传参数

事实上，函数就像是迷你脚本，调用函数时可以传任意个参数，在函数内同样是用`$0、$1、$2`等变量来提取参数，

函数中的位置参数相当于函数的局部变量，改变这些变量并不会影响函数外面的`$0、$1、$2`等变量。

函数中可以用`return`命令返回，如果`return`后面跟一个`数字`则表示函数的`Exit Status`。

**例：**
```
funWithParam(){
    echo "第一个参数为 $1 !"
    echo "第二个参数为 $2 !"
    echo "第十个参数为 $10 !"
    echo "第十个参数为 ${10} !"
    echo "第十一个参数为 ${11} !"
    echo "参数总数有 $# 个!"
    echo "作为一个字符串输出所有参数 $* !"
}

funWithParam 1 2 3 4 5 6 7 8 9 34 73

```