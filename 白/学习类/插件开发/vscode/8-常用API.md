# 常用API

## 编辑器相关

### 修改当前激活编辑器内容

> 替换当前编辑器全部内容：

```js
vscode.window.activeTextEditor.edit(editBuilder => {
	// 从开始到结束，全量替换
	const end = new vscode.Position(vscode.window.activeTextEditor.document.lineCount + 1, 0);
	const text = '新替换的内容';
	editBuilder.replace(new vscode.Range(new vscode.Position(0, 0), end), text);
});
```

>打开文件并选中某段文字

```js
const path = '/Users/somefile.txt';
const options = {
	// 选中第3行第9列到第3行第17列
	selection: new vscode.Range(new vscode.Position(2, 8), new vscode.Position(2, 16));
	// 是否预览，默认true，预览的意思是下次再打开文件是否会替换当前文件
	preview: false,
	// 显示在第二个编辑器
	viewColumn: vscode.ViewColumn.Two
};
vscode.window.showTextDocument(vscode.Uri.file(path), options);
```

preview为true相当于在文件管理器单击文件，此时标题是斜体（如下图），为false时则相当于双击。

-----------

## 通知和状态栏

### 提示

`vscode.window.showInformationMessage('我是info信息！');`
`vscode.window.showErrorMessage('我是错误信息！');`

自定义按钮带回调的提示：

```js
vscode.window.showInformationMessage('是否要打开小茗同学的博客？', '是', '否', '不再提示').then(result => {
	if (result === '是') {
		exec(`open 'https://haoji.me'`);
	} else if (result === '不再提示') {
		// 其它操作
	}
});
```

### 修改状态栏

`vscode.window.setStatusBarMessage('你好，前端艺术家！');`


`setStatusBarMessage`只是`vscode.window.createStatusBarItem`的一种快捷调用方式，如需更多自定义设置可以使用这个方法。

## 参考
<https://code.visualstudio.com/docs/extensionAPI/vscode-api>