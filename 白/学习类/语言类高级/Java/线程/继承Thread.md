## 通过继承 `Thread` 来创建线程

> 创建一个线程的第二种方法是创建一个新的类，该类继承 Thread 类，然后创建一个该类的实例。

继承类必须重写 `run()` 方法，该方法是新线程的入口点。<br>
它也必须调用 `start()` 方法才能执行。

该方法尽管被列为一种多线程实现方式，但是本质上也是实现了` Runnable `接口的一个实例。


-----------------------------

## 示例

```java
// 创建新类 继承 Thread
class ThreadDemo extends Thread {

   private Thread t;
   private String threadName;
   
   ThreadDemo( String name) {
      threadName = name;
      System.out.println("Creating " +  threadName );
   }
   
   // 重写 run()
   public void run() {
      System.out.println("Running " +  threadName );

      // 异常捕捉
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
   
   // 初始化创建线程
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
 
    // 开辟俩个线程
   public static void main(String args[]) {
      ThreadDemo T1 = new ThreadDemo( "Thread-1");
      T1.start();
      
      ThreadDemo T2 = new ThreadDemo( "Thread-2");
      T2.start();
   }   
}
```