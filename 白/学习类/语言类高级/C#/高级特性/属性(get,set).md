# C# 属性（Property）

> 本质上是包括方法，变量等等的成员

属性（Property） 是类（class）、结构（structure）和接口（interface）的命名（named）成员。

1. 类或结构中的成员变量或方法称为 域（Field）。
2. 属性（Property）是域（Field）的扩展，且可使用相同的语法来访问。
3. 它们使用 访问器（accessors） 让私有域的值可被读写或操作。

> 属性（Property）不会确定存储位置。相反，它们具有可读写或计算它们值的 访问器（accessors）。

例:
有一个名为 Student 的类，带有 age、name 和 code 的私有域。
不能在类的范围以外直接访问这些域，但是可以拥有访问这些私有域的属性。

## 访问器（Accessors）

> 本质上就是一种更加简洁 的 `getter` 和 `setter`
> 但有区别的是，使用时，不需要指定`get`和`set`，更为方便

属性（Property）的访问器（accessor）包含有助于获取（读取或计算）或设置（写入）属性的可执行语句。

访问器（accessor）声明可包含一个 `get` 访问器、一个 `set` 访问器，或者同时包含二者。

`value` 为关键字 指代传递给该函数的唯一值

例如：

一个 Student 类

```C#
// 声明类型为 string 的 Code 属性
// C#6.0 以前
public string Code
{
    get
    {
        return code;
    }
    set
    {
        code = value;
    }
}

// 声明类型为 int 的 Age 属性
// C#6.0 以后 , 并设定默认值
public int Age{ get;set;} =  18

```

使用时

直接

`object.属性 操作符 变量`

例如：

`Student.code = "hello"`
`Student.Age += 2`

---

## 抽象属性

抽象类可拥有抽象属性，这些属性应在派生类中被实现。

C# 6.0 新特性

```C#
using System;
namespace Demo.cs
{
    class Program
    {
        public abstract class Person
        {
            public abstract string Name { get; set; }
            public abstract int Age { get; set; }
        }
        public class Student : Person
        {
            public string Code { get; set; } = "N.A";
            public override string Name { get; set; } = "N.A";
            public override int Age { get; set; } = 0;
            public override string ToString()
            {
                return $"Code:{Code},Name:{Name},Age:{Age}";
            }
        }

        static void Main(string[] args)
        {
            var s = new Student()
            {
                Code = "001",
                Name = "Zara",
                Age = 10
            };
            System.Console.WriteLine($"Student Info:={s}");

            s.Age++;
            System.Console.WriteLine($"Student Info:={s}");
        }
    }
}
```

> 初始化字符串推推荐使用 "N.A"
> 包含俩个字母一个`.`
