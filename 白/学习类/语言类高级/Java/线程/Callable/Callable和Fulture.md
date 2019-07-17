## 通过 `Callable` 和 `Future` 创建线程

1. 创建 `Callable` 接口的实现类，并实现 `call()` 方法，该 `call()` 方法将作为线程执行体，并且有返回值。

2. 创建 `Callable` 实现类的实例，使用 `FutureTask` 类来包装 `Callable` 对象，该 `FutureTask` 对象封装了该 `Callable` 对象的 `call()` 方法的返回值。

3. 使用 `FutureTask` 对象作为 `Thread` 对象的 `target` 创建并启动新线程。

4. 调用 `FutureTask` 对象的 `get()` 方法来获得子线程执行结束后的返回值。



---------------------
## 示例

```java
public class CallableThreadTest implements Callable<Integer> {
    
    public static void main(String[] args)  
    {  
        // 实例化一个实现 Callable 接口的类 
        CallableThreadTest ctt = new CallableThreadTest();  
        // 创建 FutureTask
        FutureTask<Integer> ft = new FutureTask<>(ctt);  

        // 创建 5 个线程
        for(int i = 0;i < 100;i++)  
        {  
            System.out.println(Thread.currentThread().getName()+" 的循环变量i的值"+i);  
            if(i==20)  
            {  
                new Thread(ft,"有返回值的线程").start();  
            }  
        }  
        
        try  
        {  
            System.out.println("子线程的返回值："+ft.get());  
        } catch (InterruptedException e)  
        {  
            e.printStackTrace();  
        } catch (ExecutionException e)  
        {  
            e.printStackTrace();  
        }  
  
    }

    //重写 call
    @Override  
    public Integer call() throws Exception  
    {  
        int i = 0;  
        for(;i<100;i++)  
        {  
            System.out.println(Thread.currentThread().getName()+" "+i);  
        }  
        return i;  
    }  
}
```

## 这种创建无疑是最简单的
只需在 `call()` 中写入线程执行内容 ，就可以将返回得到。