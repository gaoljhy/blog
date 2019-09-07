# 使用 URL 的 GET 方法实例

下面是一个简单的 URL，将使用 `GET` 方法向 `HelloForm` 程序传递两个值。

`http://localhost:8080/TomcatTest/HelloForm?name=Mr.G&url=www.gao.com`

下面是处理 Web 浏览器输入的 HelloForm.java Servlet 程序。将使用 getParameter() 方法，可以很容易地访问传递的信息：

```java
package com.gao.test;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloForm
 */
@WebServlet("/HelloForm")
public class HelloForm extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloForm() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        String title = "使用 GET 方法读取表单数据";
        // 处理中文
        String name =new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
        String docType = "<!DOCTYPE html> \n";
        out.println(docType +
            "<html>\n" +
            "<head><title>" + title + "</title></head>\n" +
            "<body bgcolor=\"#f0f0f0\">\n" +
            "<h1 align=\"center\">" + title + "</h1>\n" +
            "<ul>\n" +
            "  <li><b>站点名</b>："
            + name + "\n" +
            "  <li><b>网址</b>："
            + request.getParameter("url") + "\n" +
            "</ul>\n" +
            "</body></html>");
    }
    
    // 处理 POST 方法请求的方法
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
```

然后在 web.xml 文件中创建以下条目：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app>
  <servlet>
    <servlet-name>HelloForm</servlet-name>
    <servlet-class>com.gao.test.HelloForm</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>HelloForm</servlet-name>
    <url-pattern>/TomcatTest/HelloForm</url-pattern>
  </servlet-mapping>
</web-app>
现在在浏览器的地址栏中输入 http://localhost:8080/TomcatTest/HelloForm?name=Mr.G&url=www.gao.com ，并在触发上述命令之前确保已经启动 Tomcat 服务器。如果一切顺利，您会得到下面的结果：



使用表单的 GET 方法实例
下面是一个简单的实例，使用 HTML 表单和提交按钮传递两个值。将使用相同的 Servlet HelloForm 来处理输入。

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Mr.G(gao.com)</title>
</head>
<body>
<form action="HelloForm" method="GET">
网址名：<input type="text" name="name">
<br />
网址：<input type="text" name="url" />
<input type="submit" value="提交" />
</form>
</body>
</html>
```

保存这个 HTML 到 hello.html 文件中，目录结构如下所示:

尝试输入网址名和网址，然后点击"提交"按钮，Gif 演示如下：
