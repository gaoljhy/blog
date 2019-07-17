package def.push;

/**
 * HttpDo 执行http 传递
 */
public class HttpDo {
    private Info info;
    public HttpDo(){
    	
    }
    HttpDo(Info info) {
        this.info = info;
    }

    // 执行Http请求
    public String doGetString(String url) {
        String s = HttpRequest.sendGet(url);
        System.out.println(s);
        return s;
    }

    public String doPoString(String url, String cookie, String refere, String UserAgetnt, String postParamter) {
        // 发送 POST 请求
        String sr = HttpRequest.sendPost(url, cookie, refere, UserAgetnt, postParamter);
        System.out.println(sr);
        return sr;
    }

    public String doRun() {
        String result = "";
        //System.out.println( info.getMethod());
        if ( info.getMethod() .equals( "get")) {
            result = this.doGetString(info.getUrl());
        } else if (info.getMethod().equals( "post")) {
            result = doPoString(info.getUrl(), info.getHeader().get("Cookie"), info.getHeader().get("Refere"),
                    info.getHeader().get("User-Agent"), info.getPostparamter());
        }else {
        	System.out.println("输入错误!!");
        }
        return result;
    }
}
