# helloworld

## 源文件编译测试

### 项目结构

1. 清单文件 `package.json`
2. `extension.js` 插件入口文件



+ `package.json`部分关键内容如下（已省略其它）

```json
{
	// 扩展的激活事件
	"activationEvents": [
		"onCommand:extension.sayHello"
	],
	// 入口文件
	"main": "./src/extension",
	// 贡献点，vscode插件大部分功能配置都在这里
	"contributes": {
		"commands": [
			{
				"command": "extension.sayHello",
				"title": "Hello World"
			}
		]
	}
}
```

+ `src/extension.js` 内容如下：

```js

const vscode = require('vscode');

/**
 * 插件被激活时触发，所有代码总入口
 * @param {*} context 插件上下文
 */
exports.activate = function(context) {
	console.log('恭喜，您的扩展“vscode-plugin-demo”已被激活！');
	// 注册命令
	context.subscriptions.push(vscode.commands.registerCommand('extension.sayHello', function () {
		vscode.window.showInformationMessage('Hello World!');
	}));
};

/**
 * 插件被释放时触发
 */
exports.deactivate = function() {
	console.log('您的扩展“vscode-plugin-demo”已被释放！')
};
```

------------

### 解读

+ `package.json`

    1. `main`定义了整个插件的主入口；

    2. 在`contributes.commands`里面注册了一个名为`extension.sayHello`的命令，并在`src/extension.js`中去实现了它（弹出一个`Hello World`的提示）；

+ `extension.js`

    1. 命令虽然定义了，但是`vscode`还不知道啥时候去执行它
    2. 需要在`activationEvents` 插件激活事件中添加上`onCommand:extension.sayHello`用来告诉vscode，当用户使用了前面定义的命令，然后执行了这个操作；

> 除了`onCommand`之外，还有`onView`、`onUri`、`onLanguage`等等

## 运行调试

默认情况下，工程已经配置好了调试相关参数（有兴趣的可以查看`.vscode/launch.json`文件的写法）

只需要到调试面板选中要调试的项目(仅仅是第一次需要，后续会自动记住上次调试的项目)，然后按下F5就会弹出一个**新的**`vscode`窗口：


这个新窗口已经加载了自己开发的的插件，窗口标题会注明扩展开发主机

然后按下`Ctrl+Shift+P`，输入`HelloWorld`执行先前设定的对应命令，当发现右下角弹出了`HelloWorld`的提示时,成功

## 添加右键菜单和快捷键

上面由于只是注册了**命令**，没有添加菜单或快捷键，调用不方便，所以现在添加一下。

打开`package.json`，按照下述方式添加：

```json
{
	"contributes": {
		"commands": [
			{
				"command": "extension.sayHello",
				"title": "Hello World"
			}
		],
		// 快捷键绑定
		"keybindings": [
			{
				"command": "extension.sayHello",
				"key": "ctrl+f10",
				"mac": "cmd+f10",
				"when": "editorTextFocus"
			}
		],
		// 设置菜单
		"menus": {
			"editor/context": [
				{
					"when": "editorFocus",
					"command": "extension.sayHello",
					"group": "navigation"
				}
			]
		}
	}
}
```

然后重新运行插件，在编辑器的右键可以看到添加的快捷键 `hello world`(所展示的都为标题)


> 这里暂时不对配置项做过渡解读，后面会有专门介绍`package.json`文件的写法。
