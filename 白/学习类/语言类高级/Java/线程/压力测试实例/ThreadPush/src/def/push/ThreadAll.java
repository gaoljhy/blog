package def.push;

import java.util.concurrent.Callable;

class ThreadAll implements Callable<String> {
	public HttpDo do1 ;
	ThreadAll(HttpDo do1){
		this.do1 = do1;
	}
	// 重写 call
	@Override
	public String call() throws Exception {
		return this.do1.doRun();
		
	}
}
