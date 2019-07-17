package def.push;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.FutureTask;

/**
 * data:18.8.7 2:40 auto : lemon features : 指定 线程数 tnum ，请求 url , 传递方式 method
 * ，返回响应状态码 statusCode method == get , 直接开循环多次访问，若返回 404 ，输出一次 ，errorTwice ++
 * method == post , 需要指定 Headers{} , Cookie,User-Agent,Refere ，postParamter
 */

public class Demon {
	public static Info info = new Info();

	public static void main(String[] args) {
		// 获取用户输入
		System.out.println("pressure test\n" + 
				"by GRj");
		Gui gu = new Gui();
		info.setUrl(gu.getUrl());
		info.setTnum(gu.getTnum());
		info.setMethod(gu.getMethod());
		if (info.getMethod().equals( "post")) {
			info.setCookie(gu.getCookie());
			info.setUserAgent(gu.getUserAgent());
			info.setRefere(gu.getRefere());
			info.setPostparamter(gu.getPostParamater());
		}
		// 创建 http 请求
		HttpDo do1 = new HttpDo(info);

		//do1.doRun();
		// 创建线程池
		ExecutorService executor = Executors.newCachedThreadPool();

		// 创建线程对象
		ThreadAll all = new ThreadAll(do1);

		int allnum = 0, tnum = info.getTnum();
		// 得到返回值
		try {
			for (int i = 0; i < tnum; i++) {
				FutureTask<String> te = new FutureTask<String>(all);
				executor.submit(te);
				// System.out.println(te.get());
				if (te.get().equals( info.getStatusCode())) {
					allnum += 1;
				}
			}
			executor.shutdown();

		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}

		System.out.println("最终结果: \n共运行: " + tnum + "个请求\n" + "得到承载数为: " + allnum);
	}

}
