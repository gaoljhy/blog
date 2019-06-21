# 部署

> 已编译的 Servlet 部署在生产中

## Servlet 部署

1. 默认情况下，Servlet 应用程序位于路径 `<Tomcat-installation-directory>/webapps/ROOT` 下

2. 且类文件放在 `<Tomcat-installation-directory>/webapps/ROOT/WEB-INF/classes` 中。

3. 如果有一个完全合格的类名称 `com.myorg.MyServlet`，那么这个 `Servlet` 类必须位于 `WEB-INF/classes/com/myorg/MyServlet.class` 中。

-------------

1. 把 `HelloWorld.class` 复制到 `<Tomcat-installation-directory>/webapps/ROOT/WEB-INF/classes` 中
2. 并在位于`<Tomcat-installation-directory>/webapps/ROOT/WEB-INF/` 的 web.xml 文件中创建以下条目：

```xml
<web-app>
    <servlet>
        <servlet-name>HelloWorld</servlet-name>
        <!-- severlet 进行命名标记  -->
        <servlet-class>HelloWorld</servlet-class>
        <!-- severlet 对应类  -->
    </servlet>

    <servlet-mapping>
        <servlet-name>HelloWorld</servlet-name>
        <!-- severlet 识别命名标记  -->
        <url-pattern>/index</url-pattern>
        <!-- severlet 对应url  -->
    </servlet-mapping>
</web-app>
```

上面的条目要被创建在 `web.xml` 文件中的 `<web-app>...</web-app>` 标签内。
> 在该文件中可能已经有各种可用的条目，但不要在意。

## 启动tomcat后

在浏览器的地址栏中输入 `http://localhost:8080/index`
