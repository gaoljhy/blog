# 编辑器API

## 编写编辑器命令

可以通过插件 `API` 来编写编辑器内的命令。

1. 创建一个命令，以及给这个命令命名并且注册
    这个代码示例中 `extension.js` 的内容现在如下：

    ```js
    const vscode = require('vscode');

    function activate(context) {
        console.log('Congratulations, your extension "myextension" is now active!');
        let disposable = vscode.commands.registerCommand('extension.sayHello', function () {
            vscode.window.showInformationMessage('Hello World!');
        });

        context.subscriptions.push(disposable);
    }

    exports.activate = activate;

    function deactivate() {
    }
    exports.deactivate = deactivate;
    ```

2. 访问编辑器

    既然是编辑器相关的命令，那么肯定需要能够访问到编辑器，以及其中的内容。
    1. 首先我们要获取的就是：当前工作区内，用户正在使用的编辑器。
        `let editor = vscode.window.activeTextEditor;`

    > editor 这个变量并非一定总是有效的值，比如用户现在并没有打开任何文件，编辑器是空的，那么此时 editor 的值就是 `undefined`。
    > 在正式使用 `editor` 之前，要判断一下，`editor` 是否为 undefined，是的话就结束命令的运行。

    ```js
        if (!editor) {
            return;
        }
    ```

## VSCode 插件开发编辑器命令

这其中几个值得一提的有如下：

1. `document`，也就是当前编辑器中的文档内容；
2. `edit`，用于修改编辑器中的内容；
3. `revealRange`，用于将某段代码滚动到当前窗口中；
4. `selection`，当前编辑器内的主光标；
5. `selections`，当前编辑器中的所有光标，第一个光标就是主光标，后面的则是用户创建出来的多光标；
6. `setDecorations`，设置编辑器装饰器

## VSCode 插件开发编辑器命令

> 介绍过 “转置字母”（Transpose Letters）这个命令，这个命令可以将光标左、右两侧的字母位置调换。

> > 不过如果将多个字符选中，然后运行这个命令，该命令并不能将它们反转。

### 实现字符串反转

1. 读取的信息就是当前的文档信息和主光标的信息。

    ```js
    let document = editor.document;
    let selection = editor.selection;
    ```

2. 读取光标选中的内容

    `let text = document.getText(selection);`

    > `getText`，以获取某段代码。

3. 接下来就是将这段文本进行反转了，可以写一个非常简单的版本，将字符串分割成字母数组，然后反转，最后重新组合成字符串。

    `let result = text.split('').reverse().join('');`

4. 最后一步操作就是将原来编辑器内的文本进行替换了。

    此时要用到 `edit` 这个 `API` 了。
    值得注意的是，这个 `API` 的第一参数，是一个 `callback`，`callback` 的参数是 `editBuilder`，也就是真正用于修改代码的对象。
    editBuilder 有以下几个 API：

    1. delete
    2. insert
    3. replace
    4. setEndOfLine

    > 这里要使用的是 replace 了。

`editBuilder.replace(selection, result);`

> 将原先的 selection 里的内容，替换成新的 result 即可。

-----------

## 注意事项

绝大多数的编辑器命令的工作方式，基本上跟上面的示例如出一辙。

一共分为三部分：

1. 首先，读取文档中的内容。
    需要使用的 API 是 `selection、selections、getText` 等。
2. 其次，对这些内容进行二次加工，这部分就是 `business logic` 了。

3. 最后，修改编辑器内的内容。
    可以使用 edit 来修改文本，也可以直接修改 `editor.selection` 和 `editor.selections` 来改变光标的位置。

不过，如果要书写一个没有bug且性能出色的编辑器命令，可就没那么简单了。
比如上面的示例里面，没有对多光标进行支持，反转字符串也是很暴力的，而这一部分，才是插件真正体现差距的地方。

