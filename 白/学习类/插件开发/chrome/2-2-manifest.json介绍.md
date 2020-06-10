## 参数讲解

### popup

popup是点击`browser_action`或者`page_action`图标时打开的一个小窗口网页，焦点离开网页就立即关闭，一般用来做一些临时性的交互。

popup可以包含任意你想要的`HTML`内容，并且会自适应大小。可以通过`default_popup`字段来指定`popup`页面，也可以调用`setPopup()`方法。

```json
{
	"browser_action":
	{
		"default_icon": "img/icon.png",
		// 图标悬停时的标题，可选
		"default_title": "这是一个示例Chrome插件",
		"default_popup": "popup.html"
	}
}
```

需要特别注意的是，由于单击图标打开`popup`，焦点离开又立即关闭，所以`popup`页面的生命周期一般很短，需要长时间运行的代码千万不要写在`popup`里面。

在权限上，它和`background`非常类似，它们之间最大的不同是生命周期的不同，`popup`中可以直接通过`chrome.extension.getBackgroundPage()`获取`background`的`window`对象。

### injected-script

这里的`injected-script`，指的是通过`DOM`操作的方式向页面注入的一种`JS`。

为什么要把这种`JS`单独拿出来讨论呢？又或者说为什么需要通过这种方式注入JS呢？

这是因为`content-script`有一个很大的 `缺陷` ，也就是无法访问页面中的`JS`，虽然它可以操作`DOM`，但是`DOM`却不能调用它，也就是无法在`DOM`中通过绑定事件的方式调用`content-script`中的代码（包括直接写`onclick`和`addEventListener`2种方式都不行）

但是， `在页面上添加一个按钮并调用插件的扩展API` 是一个很常见的需求，那该怎么办呢？其实这就是本小节要讲的。

在`content-script`中通过DOM方式向页面注入`inject-script`代码示例：

```js
// 向页面注入JS
function injectCustomJs(jsPath)
{
	jsPath = jsPath || 'js/inject.js';
	var temp = document.createElement('script');
	temp.setAttribute('type', 'text/javascript');
	// 获得的地址类似：chrome-extension://ihcokhadfjfchaeagdoclpnjdiokfakg/js/inject.js
	temp.src = chrome.extension.getURL(jsPath);
	temp.onload = function()
	{
		// 放在页面不好看，执行完后移除掉
		this.parentNode.removeChild(this);
	};
	document.head.appendChild(temp);
}
```

> 需要在`web`中直接访问插件中的资源的话必须显示声明才行，配置文件中增加如下：

```json
{
	// 普通页面能够直接访问的插件资源列表，如果不设置是无法直接访问的
	"web_accessible_resources": ["js/inject.js"],
}
```

> 至于`inject-script`如何调用`content-script`中的代码，后面我会在专门的一个消息通信章节详细介绍。

###  homepage_url

开发者或者插件主页设置，一般会在如下2个地方显示：