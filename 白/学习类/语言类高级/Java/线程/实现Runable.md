## 通过实现 `Runnable` 接口来创建线程 
### 本质上 `Runalbe` 也是 `Thread` 的一个接口 ，所以大部分方法是一样的

> 创建一个线程，最简单的方法是创建一个实现 `Runnable` 接口的类。

#### 为了实现 `Runnable`，一个类只需要执行一个方法调用 `run()`，声明如下：

> `public void run()`

你可以重写该方法，重要的是理解的 `run()` 可以调用其他方法，使用其他类，并声明变量，就像主线程一样。

在创建一个实现 `Runnable` 接口的类之后，你可以在类中实例化一个线程对象。




------------------------------
## 示例

```java
// 实现 Runable
class RunnableDemo implements Runnable {
   
   private Thread t;
   private String threadName;
   
   // 构造
   RunnableDemo( String name) {
      threadName = name;
      System.out.println("Creating " +  threadName );
   }
   
   // 每个线程的 执行函数 run
   public void run() {
      System.out.println("Running " +  threadName );
      // 加入异常机制
      try {
         for(int i = 4; i > 0; i--) {
            System.out.println("Thread: " + threadName + ", " + i);
            // 让线程睡眠一会
            Thread.sleep(50);
         }
      }catch (InterruptedException e) {
         System.out.println("Thread " +  threadName + " interrupted.");
      }

      System.out.println("Thread " +  threadName + " exiting.");
   }
   
   // 执行 初始化 创建 函数 start
   public void start () {
      System.out.println("Starting " +  threadName );
      if (t == null) {
         t = new Thread (this, threadName);
         t.start ();
      }
   }
}

// 执行主类
public class TestThread {
 
   public static void main(String args[]) {
      RunnableDemo R1 = new RunnableDemo( "Thread-1");
      R1.start();
      
      RunnableDemo R2 = new RunnableDemo( "Thread-2");
      R2.start();
   }   
}

```