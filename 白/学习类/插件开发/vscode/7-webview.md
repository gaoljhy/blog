# webview

<http://blog.haoji.me/vscode-plugin-webview.html#shi-me-shi-Webview>

整个VSCode编辑器就是一张大的网页，其实，可以在Visual Studio Code中创建完全自定义的、可以间接和`nodejs`通信的特殊网页（通过一个`acquireVsCodeApi`特殊方法），这个网页就叫`WebView`。

内置的`Markdown`的预览就是使用`WebView`实现的。
使用`Webview`可以构建复杂的、支持本地文件操作的用户界面。

VSCode插件的WebView类似于iframe的实现，但并不是真正的iframe（我猜底层应该还是基于iframe实现的，只不过上层包装了一层），通过开发者工具可以看到：

## WebView控制台

Webview的控制台比较特殊，需要特殊的命令才能打开，按下`Ctrl+Shift+P`然后执行打开Webview开发工具，英文版应该是`Open Webview Developer Tools`：



开发时把它当成一个普通的网页来看就好了。
