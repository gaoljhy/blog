# 命令

## package.json

```json
commands:[
    {
        "command": "extension.sayhello",
        "title":"Hello World"
    }
]
```

##  实现js

```js

context.subscriptins.push(vscode.commands.registerCommand('extension.sayHello',()=>{
    vscode.window.showInfoemationMessage('执行了命令 extension.sayHello');
}))

```

## 实现格式

```js
conext.subscription.push( // 订阅推送
vscode.command.executeCommand(
    // 绑定到唯一独立的 id-命令 ,及得到需要的参数或者回调参数
    '命令','params1','params2',...,function(result) => { 
    // 绑定该函数
    console.log("命令结果"，result);
    // 执行内容
}
)
);
```

vscode.command.registerCommand 是注册命令API，执行后是注册所有`Dispoable` 对象 ,所有注册类的API执行后的结果都需要返回到 `context.subscriptions` 中

------------

## 编辑器命令

+ 除了上面的注册普通命令之外，还有一个`vscode.commands.registerTextEditorCommand`命令

1. 文本编辑器命令与普通命令不同
2. 它们仅在有被编辑器被激活时调用才生效

> 此外，这个命令可以访问到当前活动编辑器`textEditor`

### 实现 js

```js
 
context.subscription.push(
    vscode.command.regisiterTextEditorCommand(
        'extension.testEditorCommand',(textEditor,edit)=>
        {
            console.log('您正在执行编辑器命令');
            console.log('textEditor',edit);
        }));
```

------------

## vscode api执行命令

vscode api 命令的习惯设计，类似于 `promise` 的 `Tenable` 对象
> 如果发现api里面返回的是这个对象，说明这个方法不是直接返回结果的

### 实现 js

```js
vscode.command.executeCommand('命令','params1','params2',...).then(result => {
    console.log('命令结果'，result);
});
```

-----------

## 获得所有命令

```js
vscode.command.getCommands().then(
 allcommands => {
     console.log("所有命令",allcommands);
 }
)
```

或者 打开快捷键映射表就能看到所有的命令列表，右键可以复制命令

-------------------

## 复杂命令

vscode内部有一些复杂命令

复杂命令就是指一些需要特殊参数并且通常有**返回值**、执行一些诸如**跳转到定义**、**执行代码高亮**等特殊操作
> 这类命令有几十个

作为插件开发者，很多时候可能正需要这类命令，复杂命令列表参阅：<https://code.visualstudio.com/docs/extensionAPI/vscode-api-commands>

### 示例

> 以下是演示如何在VS代码中打开新文件夹的示例：

```js
let uri = Uri.file('/some/path/to/folder');
commands.executeCommand('vscode.openFolder', uri).then(sucess => {
	console.log(success);
});
```