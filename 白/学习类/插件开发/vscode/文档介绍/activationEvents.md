# activationEvents

插件在VS Code中默认是没有被激活的，哪什么时候才被激活呢？
就是通过`activationEvents`来配置，目前支持一下8种配置：

```txt
onLanguage:${language}
onCommand:${command}
onDebug
workspaceContains:${toplevelfilename}
onFileSystem:${scheme}
onView:${viewId}
onUri
*
```

举个例子，如果配置了`onLanguage:javascript`
> 那么只要打开了`JS`类型的文件，插件就会被激活。

重点说一下`*`，如果配置了`*`，只要一启动`vscode`，插件就会被激活，为了出色的用户体验，官方不推荐这么做。

## 参考

<https://code.visualstudio.com/docs/extensionAPI/activation-events>