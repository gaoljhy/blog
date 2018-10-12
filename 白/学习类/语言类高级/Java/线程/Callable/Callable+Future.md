## Future 是一个接口 ，无法直接创建对象 ，需要借助 ExcutorService 实例化转化

```java
public class Test {
    
    public static void main(String[] args) {
        
        // 创建线程池
        ExecutorService executor = Executors.newCachedThreadPool();
        

        // 一个实例代表一个线程
        //实例化 Callable
        Task task = new Task();
        //创建 Future
        Future<Integer> result = executor.submit(task);

         
        System.out.println("主线程在执行任务");
         
        try {
            //多个线程使用
            // for(int i = 0 ; i < 10 ; i ++) {
        	// 	System.out.println( executor.submit(task).get());
        	// }
            //运行 结果
            System.out.println("task运行结果"+result.get());
            // 关闭线程池
            executor.shutdown();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
         
        System.out.println("所有任务执行完毕");
    }
}

class Task implements Callable<Integer>{

    // 重写 call
    @Override
    public Integer call() throws Exception {
        
        System.out.println("子线程在进行计算");
        // 子线程执行内容在此
        
        // 返回值
        return 0；
    }
}
```