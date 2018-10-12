## 线程研究

### 线程概述
一个程序的一个执行过程是一个进程，一个进程的一条执行路径就是一个线程<br/>
线程是执行调度的单位，依托于进程存在。 <br/>
一个进程至少有一个线程 <br/>
> 但java 存在 垃圾回收机制`gc`，所以最少俩个线程


### 线程与进程之间的关系
线程可以共享进程的内存，同时拥有一个属于自己的内存空间，这段内存空间也叫做线程栈

线程栈是建立在线程时由系统分配的，主要用来保存线程内部所使用的数据<br/>
>如: 线程执行函数中所定义的变量。

并发： 同时请求，轮流执行

并行：多个cpu 同时执行不同任务 
<hr/>

## 操作

### 线程的创建

定一个线程有俩种方法

1. 继承 `java.lang.Thread` 类
2. 继承 `java.lang.Runable` 类

```
/**
 *   使用 java.lang.Thread 类
 *   使用 Runnable 接口
 *   创建一个线程
 *   @author Lemon 2018.6.24
 */
public class Temp {
    public static void main(String[] args) {
        ThreadTest test = new ThreadTest();
        test.start();

        //使用这种方式 不影响类 的继承 ，只实现一个接口便可以,
        // 扩展性大大提高
        RunableTest test2 = new RunableTest();
        Thread foo = new Thread(test2);
        foo.start();
    }
    
}


class ThreadTest extends Thread {
    /**
     * override run() 方法 
     * 程序需使用 start() 方法调用这一流程时    JVM自动调用该方法
     */
    @Override
    public void run(){
        System.out.println(super.getName());
        
    }
}

class RunableTest implements Runnable{
    /**
     * override run() 方法
     * 该类需要将一个对象传入线程类 使其实例化
     * 使用start() 方法调用这一流程      JVM自动调用该方法
     */
    @Override
    public void run() {

       System.out.print(Thread.currentThread().getName()); 
    }

}
```

