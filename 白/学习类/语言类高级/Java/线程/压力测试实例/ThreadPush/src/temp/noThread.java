package temp;


// /**
// * 线程实现
// */
// class DoThread implements Runnable {
// private Thread t ;
// private String threadName ;
// private HttpDo httpDo ;

// DoThread(String name ,HttpDo httpDo){
// this.threadName = name ;
// this.httpDo = httpDo;
// System.out.println("Thread "+ this.threadName + " begin.........");
// }

// // 重写 run
// public void run() {
// System.out.println("Thread " + this.threadName + " Running " );
// // 加入异常捕获

// try {
// System.out.println( this.httpDo.doRun() );
// } catch (InterruptedException e) {
// System.out.println("Thread " + this.threadName + " is Interrupted ");
// }
// // 结束
// System.out.println(this.threadName+" ending");
// }

// // 初始化构建函数 载入到就绪状态
// public void start() {
// // 防止线程占用
// if (t==null) {
// t = new Thread(this , this.threadName);
// t.start();
// }
// }
// }