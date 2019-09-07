# 使用表单的 POST 方法实例

对get的 Servlet 做小小的修改，以便它可以处理 GET 和 POST 方法。下面的 HelloForm.java Servlet 程序使用 GET 和 POST 方法处理由 Web 浏览器给出的输入。

注意：如果表单提交的数据中有中文数据则需要转码：

```java
String name =new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
package com.gao.test;
```

```java
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
        String title = "使用 POST 方法读取表单数据";
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

现在，编译部署上述的 Servlet，并使用带有 POST 方法的 hello.html 进行测试，如下所示：

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Mr.G(gao.com)</title>
</head>
<body>
<form action="HelloForm" method="POST">
网址名：<input type="text" name="name">
<br />
网址：<input type="text" name="url" />
<input type="submit" value="提交" />
</form>
</body>
</html>
```

下面是上面表单的实际输出，尝试输入网址名和网址，然后点击"提交"按钮，Gif 演示如下：

将复选框数据传递到 Servlet 程序
当需要选择一个以上的选项时，则使用复选框。

下面是一个 HTML 代码实例 checkbox.html，一个带有两个复选框的表单。

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Mr.G(gao.com)</title>
</head>
<body>
<form action="CheckBox" method="POST" target="_blank">
<input type="checkbox" name="gao" checked="checked" /> Mr.G
<input type="checkbox" name="google"  /> Google
<input type="checkbox" name="taobao" checked="checked" /> 淘宝
<input type="submit" value="选择站点" />
</form>
</body>
</html>
```

下面是 CheckBox.java Servlet 程序，处理 Web 浏览器给出的复选框输入。

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
 * Servlet implementation class CheckBox
 */
@WebServlet("/CheckBox")
public class CheckBox extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        String title = "读取复选框数据";
        String docType = "<!DOCTYPE html> \n";
            out.println(docType +
                "<html>\n" +
                "<head><title>" + title + "</title></head>\n" +
                "<body bgcolor=\"#f0f0f0\">\n" +
                "<h1 align=\"center\">" + title + "</h1>\n" +
                "<ul>\n" +
                "  <li><b>菜鸟按教程标识：</b>: "
                + request.getParameter("gao") + "\n" +
                "  <li><b>Google 标识：</b>: "
                + request.getParameter("google") + "\n" +
                "  <li><b>淘宝标识：</b>: "
                + request.getParameter("taobao") + "\n" +
                "</ul>\n" +
                "</body></html>");
    }
    
    // 处理 POST 方法请求的方法
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
设置对应的 web.xml：

<?xml version="1.0" encoding="UTF-8"?>
<web-app>
  <servlet>
    <servlet-name>CheckBox</servlet-name>
    <servlet-class>com.gao.test.CheckBox</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>CheckBox</servlet-name>
    <url-pattern>/TomcatTest/CheckBox</url-pattern>
  </servlet-mapping>
</web-app>
上面的实例将显示下面的结果：



读取所有的表单参数
以下是通用的实例，使用 HttpServletRequest 的 getParameterNames() 方法读取所有可用的表单参数。该方法返回一个枚举，其中包含未指定顺序的参数名。

一旦有一个枚举，可以以标准方式循环枚举，使用 hasMoreElements() 方法来确定何时停止，使用 nextElement() 方法来获取每个参数的名称。

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReadParams
 */
@WebServlet("/ReadParams")
public class ReadParams extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReadParams() {
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
        String title = "读取所有的表单数据";
        String docType =
            "<!doctype html public \"-//w3c//dtd html 4.0 " +
            "transitional//en\">\n";
            out.println(docType +
            "<html>\n" +
            "<head><meta charset=\"utf-8\"><title>" + title + "</title></head>\n" +
            "<body bgcolor=\"#f0f0f0\">\n" +
            "<h1 align=\"center\">" + title + "</h1>\n" +
            "<table width=\"100%\" border=\"1\" align=\"center\">\n" +
            "<tr bgcolor=\"#949494\">\n" +
            "<th>参数名称</th><th>参数值</th>\n"+
            "</tr>\n");

        Enumeration paramNames = request.getParameterNames();

        while(paramNames.hasMoreElements()) {
            String paramName = (String)paramNames.nextElement();
            out.print("<tr><td>" + paramName + "</td>\n");
            String[] paramValues =
            request.getParameterValues(paramName);
            // 读取单个值的数据
            if (paramValues.length == 1) {
                String paramValue = paramValues[0];
                if (paramValue.length() == 0)
                    out.println("<td><i>没有值</i></td>");
                else
                    out.println("<td>" + paramValue + "</td>");
            } else {
                // 读取多个值的数据
                out.println("<td><ul>");
                for(int i=0; i < paramValues.length; i++) {
                out.println("<li>" + paramValues[i]);
            }
                out.println("</ul></td>");
            }
            out.print("</tr>");
        }
        out.println("\n</table>\n</body></html>");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
```

现在，通过下面的表单尝试上面的 Servlet：

```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Mr.G(gao.com)</title>
</head>
<body>

<form action="ReadParams" method="POST" target="_blank">
<input type="checkbox" name="maths" checked="checked" /> 数学
<input type="checkbox" name="physics"  /> 物理
<input type="checkbox" name="chemistry" checked="checked" /> 化学
<input type="submit" value="选择学科" />
</form>

</body>
</html>
```

设置相应的 web.xml:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app>
  <servlet>
    <servlet-name>ReadParams</servlet-name>
    <servlet-class>com.gao.test.ReadParams</servlet-class>
  </servlet>
  <servlet-mapping>
    <servlet-name>ReadParams</servlet-name>
    <url-pattern>/TomcatTest/ReadParams</url-pattern>
  </servlet-mapping>
</web-app>
```

现在使用上面的表单调用 Servlet，将产生以下结果：



您可以尝试使用上面的 Servlet 来读取其他的表单数据，比如文本框、单选按钮或下拉框等。