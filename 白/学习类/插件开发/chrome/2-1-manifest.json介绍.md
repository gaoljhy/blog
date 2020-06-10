# manifest.json

这是一个`Chrome`插件最重要也是必不可少的文件，用来配置所有和插件相关的配置，必须放在根目录。

其中，`manifest_version、name、version` 3个是必不可少的，`description`和`icons`是推荐的。

下面给出的是一些常见的配置项，均有中文注释，完整的配置文档请戳[这里](https://developer.chrome.com/extensions/manifest)

## 参考模板

[模板manifest.json](./模板manifest.json)

## 参数讲解

###  content-scripts

所谓`content-scripts`，其实就是Chrome插件中向页面注入脚本的一种形式（虽然名为script，其实还可以包括css的）

借助`content-scripts`可以实现通过配置的方式轻松向指定页面注入JS和CSS（如果需要动态注入，可以参考下文），最常见的比如：**广告屏蔽、页面CSS定制**，等等。

示例配置：

```json
{
	// 需要直接注入页面的JS
	"content_scripts": 
	[
		{
			//"matches": ["http://*/*", "https://*/*"],
			// "<all_urls>" 表示匹配所有地址
			"matches": ["<all_urls>"],
			// 多个JS按顺序注入
			"js": ["js/jquery-1.8.3.js", "js/content-script.js"],
			// JS的注入可以随便一点，但是CSS的注意就要千万小心了，因为一不小心就可能影响全局样式
			"css": ["css/custom.css"],
			// 代码注入的时间，可选值： "document_start", "document_end", or "document_idle"，最后一个表示页面空闲时，默认document_idle
			"run_at": "document_start"
		}
	],
}
```

特别注意，如果没有主动指定`run_at为document_start`（默认为`document_idle`），下面这种代码是不会生效的：

```js
document.addEventListener('DOMContentLoaded', function()
{
	console.log('我被执行了！');
});
```

content-scripts和原始页面共享DOM，但是不共享`JS`，如要访问页面`JS`（例如某个JS变量），只能通过`injected js`来实现。`content-scripts`不能访问绝大部分`chrome.xxx.api`，除了下面这4种：

```js
chrome.extension(getURL , inIncognitoContext , lastError , onRequest , sendRequest)
chrome.i18n
chrome.runtime(connect , getManifest , getURL , id , onConnect , onMessage , sendMessage)
chrome.storage
```

其实看到这里不要悲观，这些API绝大部分时候都够用了，非要调用其它API的话，你还可以通过**通信**来实现让`background`来帮你调用（关于通信，后文有详细介绍）。

### background

后台（姑且这么翻译吧），是一个常驻的页面，它的生命周期是插件中所有类型页面中最长的，它随着浏览器的打开而打开，随着浏览器的关闭而关闭，所以通常把需要一直运行的、启动就运行的、全局的代码放在`background`里面。

`background`的权限非常高，几乎可以调用所有的`Chrome`扩展API（除了`devtools`），而且它可以无限制跨域，也就是可以跨域访问任何网站而无需要求对方设置`CORS`。

> 经过测试，其实不止是`background`，所有的直接通过`chrome-extension://id/xx.html`这种方式打开的网页都可以无限制跨域。

配置中，`background`可以通过`page`指定一张网页，也可以通过`scripts`直接指定一个`JS`，Chrome会自动为这个JS生成一个默认的网页：

```json
{
	// 会一直常驻的后台JS或后台页面
	"background":
	{
		// 2种指定方式，如果指定JS，那么会自动生成一个背景页
		"page": "background.html"
		//"scripts": ["js/background.js"]
	},
}
```

需要特别说明的是，虽然你可以通过`chrome-extension://xxx/background.html`直接打开后台页

但是你打开的后台页和真正一直在后台运行的那个页面不是同一个，换句话说，你可以打开无数个`background.html`，但是真正在后台常驻的只有一个，而且这个你永远看不到它的界面，只能调试它的代码。

------

### event-pages

这里顺带介绍一下`event-pages`，它是一个什么东西呢？
鉴于`background`生命周期太长，长时间挂载后台可能会影响性能，所以`Google`又弄一个`event-pages`，在配置文件上，它与`background`的唯一区别就是多了一个`persistent`参数：

```json
{
	"background":
	{
		"scripts": ["event-page.js"],
		"persistent": false
	},
}
```

它的生命周期是：在被需要时加载，在空闲时被关闭，什么叫被需要时呢？比如**第一次安装、插件更新、有content-script向它发送消息**，等等。

> 除了配置文件的变化，代码上也有一些细微变化，个人这个简单了解一下就行了，一般情况下background也不会很消耗性能的。

