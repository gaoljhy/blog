package def.push;
import java.util.*;
/**
 * 数据类
 */
public class Info {
    // 默认指定 2线程
    private  Integer tnum = 2;
    private  String url = "";
    // 默认 get 方式
    private  String method = "get";
    private  String statusCode = "HTTP/1.1 200 OK";
     Map<String, String> Header = new HashMap<String, String>();
    private  String cookie = "";
    private  String useragent = "";
    private  String refere = "";
    private  String postparamter = "";

    /**
     * @param tnum the tnum to set
     */
    public void setTnum(Integer tnum) {
        this.tnum = tnum;
    }

    /**
     * @param url the url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * @param method the method to set
     */
    public void setMethod(String method) {
        this.method = method;
    }

    /**
     * @param postparamter the postparamter to set
     */
    public void setPostparamter(String postparamter) {
        this.postparamter = postparamter;
    }

    public void initHeaders() {
        this.Header.put("Cookie", this.cookie);
        this.Header.put("User-Agent", this.useragent);
        this.Header.put("Refer", this.refere);
    }

    /**
     * @param cookie the cookie to set
     */
    public void setCookie(String cookie) {
        this.cookie = cookie;
    }

    /**
     * @param useragent the useragent to set
     */
    public void setUserAgent(String useragent) {
        this.useragent = useragent;
    }

    /**
     * @param refere the refere to set
     */
    public void setRefere(String refere) {
        this.refere = refere;
    }

    /**
     * @return the header
     */
    public Map<String, String> getHeader() {
        return Header;
    }

    /**
     * @return the url
     */
    public String getUrl() {
        return url;
    }

    /**
     * @return the method
     */
    public String getMethod() {
        return this.method;
    }

    /**
     * @return the postparamter
     */
    public String getPostparamter() {
        return postparamter;
    }

    /**
     * @return the tnum
     */
    public Integer getTnum() {
        return tnum;
    }

    /**
     * @return the statusCode
     */
    public  String getStatusCode() {
        return statusCode;
    }
}
