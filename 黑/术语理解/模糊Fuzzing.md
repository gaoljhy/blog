## 模糊测试 （fuzz testing, fuzzing）是一种软件测试技术。

其核心思想是自动或半自动的生成随机数据输入到一个程序中，并监视程序异常，如崩溃，断言(assertion)失败，以发现可能的程序错误，比如内存泄漏。

## 模糊测试常常用于检测软件或计算机系统的安全漏洞。

## 模糊测试工具主要分为两类，变异测试（mutation-based）以及生成测试（generation-based）。

模糊测试可以被用作白盒，灰盒或黑盒测试。

文件格式与网络协议是最常见的测试目标，但任何程序输入都可以作为测试对象。

常见的输入有环境变量，鼠标和键盘事件以及API调用序列。

甚至一些通常不被考虑成输入的对象也可以被测试，比如数据库中的数据或共享内存。


## 产生大量随机情况，进而判断错误原理 ，得出漏洞