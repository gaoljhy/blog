# Hello World 示例代码

下面是 `Servlet` 输出 `Hello World` 的示例源代码：

```java
// 导入必需的 java 库
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

// 扩展 HttpServlet 类
public class HelloWorld extends HttpServlet {
 
  private String message;

  public void init() throws ServletException
  {
      // 执行必需的初始化
      message = "Hello World";
  }

  public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
            throws ServletException, IOException
  {
      // 设置响应内容类型
      response.setContentType("text/html");

      // 实际的逻辑是在这里
      PrintWriter out = response.getWriter();
      out.println("<h1>" + message + "</h1>");
  }
  
  public void destroy()
  {
      // 什么也不做
  }
}
```

## 编译 Servlet

1. 让把上面的代码写在 `HelloWorld.java` 文件中 - 文件名与类名一致
2. 把这个文件放在 `C:\ServletDevel`（在 Windows 上）或 `/usr/ServletDevel`（在 UNIX 上）中
3. 还需要把这些目录添加到 `CLASSPATH` 中。

+ 如果环境已经正确地设置，进入 `ServletDevel` 目录，并编译 `HelloWorld.java`

`javac HelloWorld.java`

+ 如果 `Servlet` 依赖于任何其他库，必须在 `CLASSPATH` 中包含那些 `JAR` 文件。

在这里，只包含了 `servlet-api.jar` JAR 文件，因为没有在 `Hello World` 程序中使用任何其他库。

> 该命令行使用 Sun Microsystems Java 软件开发工具包（JDK）内置的 javac 编译器
> 为使该命令正常工作，必须 PATH 环境变量中使用的 Java SDK 的位置。

如果一切顺利，上面编译会在同一目录下生成 `HelloWorld.class` 文件。
