## `iomanip`库 与 `ios`作用域

| 函数                                   | 作用                                      | 注意⚠️                                                                                   |
| :------------------------: | :---------------------------: | :--------------------------: |
|`setbase(n)`|	设置整数为n进制(n=8,10,16)
|`setfill(n)`|	设置字符填充，c可以是字符常或字符变量
|`setprecision(n)`|	 设置显示有效数字为n位 |有效位数默认是`6`位，即`setprecision(6)`，小数点前面和小数点后面加起来的位数为`6`个有效数字<br/>遵循·**四舍六入五成双**的原则，而不是四舍五入的原则
|`setw(n)`|	 设置字段宽度为n位|`setw(n)`设置宽度，若是数值实际宽度大于被设置的，则`setw`函数此时失效。<br/> 且默认是用空格从左至右补全
|||
|`flag`| 等同于`setiosflags(ios::flag)`| 
|`fixed`|  设置后面操作基于小数位 | 与提前设置`setiosflags(ios::fixed)`一样|
|`scientific`| 设置后面操作基于科学计数|与提前设置`setiosflags(ios::scientific)`一样|
|`setiosflags(ios::fixed)`|	 设置浮点数以固定的小数位数显示
|`setiosflags(ios::scientific)`|  	 设置浮点数以科学计数法表示
|`setiosflags(ios::left)`|	 输出左对齐
|`setiosflags(ios::right)`|	 输出右对齐
|`setiosflags(ios::skipws)`|	 忽略前导空格
|`setiosflags(ios::uppercase)`|	 在以科学计数法输出`E`与十六进制输出`X`以大写输出，否则小写。
|`setiosflags(ios::showpos)`|	 输出正数时显示`+`号
|`setiosflags(ios::showpoint)`|	 强制显示小数点
|`resetiosflags(状态)`| 	终止已经设置的某一输出格式状态，在括号中应指定内容



>科学计数法输出`E`与十六进制的字母输出默认是以小写的，要换成大写需添加`uppercase`


