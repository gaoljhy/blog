# json

```java
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class JsonTest {
    public static void main(String[] args) {
        String joStr = "{name:\"张三\",age:\"20\"}";
        //将json字符串转化为JSONObject
        JSONObject jsonObject = JSONObject.fromObject(joStr);
        //通过getString("")分别取出里面的信息
        String name = jsonObject.getString("name");
        String age = jsonObject.getString("age");
        //输出   张三  20
        System.out.println(name+"  "+age);

        String jaStr = "[{user:{name:\"张三\",age:\"20\"}},{score:{yuwen:\"80\",shuxue:\"90\"}}]";
        //将jsonArray字符串转化为JSONArray
        JSONArray jsonArray = JSONArray.fromObject(jaStr);
        //取出数组第一个元素
        JSONObject jUser = jsonArray.getJSONObject(0).getJSONObject("user");
        //取出第一个元素的信息，并且转化为JSONObject
        String name2 = jUser.getString("name");
        String age2 = jUser.getString("age");
        //输出  张三  20
        System.out.println(name2+"  "+age2);
        //取出数组第二个元素，并且转化为JSONObject
        JSONObject jScore = jsonArray.getJSONObject(1).getJSONObject("score");
        //取出第二个元素的信息
        String yuwen = jScore.getString("yuwen");
        String shuxue = jScore.getString("shuxue");
        //输出   80  90
        System.out.println(yuwen+"   "+shuxue);
    }

}
```
