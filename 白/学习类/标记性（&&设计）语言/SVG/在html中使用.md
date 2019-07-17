## SVG 文件可通过以下标签嵌入 HTML 文档：
`<embed>`、`<object>` 或者 `<iframe>`



使用 `<embed>` 标签
-------------

1. 优势：所有主要浏览器都支持，并允许使用脚本
2. 缺点：不推荐在HTML4和XHTML中使用（但在HTML5允许）

语法:
`<embed src="circle1.svg" type="image/svg+xml" />`


使用 `<object>` 标签
---------------------------

1. 优势：所有主要浏览器都支持，并支持HTML4，XHTML和HTML5标准
2. 缺点：不允许使用脚本。

语法:
`<object data="circle1.svg" type="image/svg+xml"></object>`


**推荐使用** 使用 `<iframe>` 标签
-----------------------------
1. 优势：所有主要浏览器都支持，并允许使用脚本
2. 缺点：不推荐在HTML4和XHTML中使用（但在HTML5允许）

语法:
`<iframe src="circle1.svg"></iframe>`



## 直接在HTML嵌入SVG代码


在Firefox、Internet Explorer9、谷歌Chrome和Safari中，可以直接在HTML嵌入SVG代码。

实例
<svg xmlns="http://www.w3.org/2000/svg" version="1.1">
   <circle cx="100" cy="50" r="40" stroke="black" stroke-width="2" fill="red" />
</svg>



还可以用`<a>`标签链接到一个SVG文件：
-----------------------

`<a href="circle1.svg">View SVG file</a>`