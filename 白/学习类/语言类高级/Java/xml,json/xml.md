# XML

```java
import com.sun.istack.internal.NotNull;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;




public class XmlFile {

    public Map read(String path) {
        Map result = new HashMap();
//        TODO 解析xml文件
        // 创建SAXReader的对象reader
        SAXReader reader = new SAXReader();
        try {
            // 通过reader对象的read方法加载books.xml文件,获取docuemnt对象。
            @NotNull
            Document document = reader.read(new File(path));
            // 通过document对象获取根节点
            Element root = document.getRootElement();
            // 通过element对象的elementIterator方法获取迭代器
            Iterator it = root.elementIterator();
            // 遍历迭代器，获取根节点中的信息
            while (it.hasNext()) {

                Element child = (Element) it.next();
                //                节点名
                String name = child.getName();
                //                节点值
                String value = child.getStringValue();
                result.put(name,value);
            }
        } catch (DocumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;
    }
    public String getPath(){
        return this.read("config.xml").get("path").toString();
    }
}
```
