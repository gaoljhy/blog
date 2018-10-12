## FutureTask 可以直接实例化，并不是一个接口

```java
public class Temp {
    public static void main(String[] args) {
        //第一种方式
    	// 创建线程池
        ExecutorService executor = Executors.newCachedThreadPool();
        
        // 实例化 Callable        
        Task task = new Task();
        
        // 创建 FutherTask
        FutureTask<Integer> futureTask = new FutureTask<Integer>(task);
        
        executor.submit(futureTask);
         
        //第二种方式，注意这种方式和第一种方式效果是类似的，只不过一个使用的是ExecutorService，一个使用的是Thread
        /*Task task = new Task();
        FutureTask<Integer> futureTask = new FutureTask<Integer>(task);
        Thread thread = new Thread(futureTask);
        thread.start();*/
         
         
        System.out.println("主线程在执行任务");
         
        try {
            // // 多个线程执行方式
			// for (int i = 0; i < 10; i++) {
			// 	FutureTask<Integer> te =  new FutureTask<Integer> (task
            );
			// 	executor.submit( te);
			// 	System.out.println(te.get() );
			// }
            System.out.println("task运行结果"+futureTask.get());
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
    @Override
    public Integer call() throws Exception {
        System.out.println("子线程在进行计算");
        // 执行代码
        
        // 返回
        return 1;
    }
}
```