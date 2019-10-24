# 脚手架的使用

> 如果喜欢干净的项目的话，可以使用官方脚手架来生成。

## 安装脚手架：

`npm install -g yo generator-code`

然后cd到你的工作目录，运行`yo code`：

根据向导一步步选择即可,运行完后就生成了一个干净的可以直接`F5`运行的`vscode`插件工程了。

## 该Hello World扩展做3件事情：

1. 注册激活事件：，以便在用户运行命令时激活扩展
    `onCommand onCommand:extension.helloWorldHello World`

2. 使用`Contribution Point`在`Command Palette` 中**使命令可用**，并将其与命令ID绑定
    `contributes.commands Hello Worldextension.helloWorld`

3. 使用`VS Code API`将函数绑定到已注册的命令ID
    `commands.registerCommand extension.helloWorld`

### 插件开发中理解这三个概念对于在VS代码中编写扩展至关重要：

1. 激活事件(Activation Events)：vscode已定义的插件变为活动状态的事件。

2. 绑定点(Contribution Points)：在`package.json` `Extension Manifest`中为扩展`VS Code`而进行的静态声明。

2. `VS Code API`：可以在扩展代码中调用的`vscode`提供的一组`JavaScript API`。

通常，扩展程序将使用`Contribution Points`和`VS Code API`的组合来扩展`VS Code`的功能。

> 在[官方API文档](https://code.visualstudio.com/api/extension-capabilities/overview) 找到适合扩展的`Contribution Points`和`VS code API`

## 脚手架生成的文档结构

```txt
.
├── .vscode
│   ├── launch.json     // Config for launching and debugging the extension
│   └── tasks.json      // Config for build task that compiles TypeScript
├── .gitignore          // Ignore build output and node_modules
├── README.md           // Readable description of your extension's functionality
├── src
│   └── extension.ts    // Extension source code
├── package.json        // Extension manifest
├── tsconfig.json       // TypeScript configuration
```

+ `launch.json` used to configure VS Code Debugging
+ `tasks.json`  for defining VS Code Tasks
+ `tsconfig.json` 参阅 [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html)

## package.json文件官方解读

Each VS Code extension must have a `package.json` as its Extension Manifest.

The `package.json` contains a mix of `Node.js` fields such as `scripts` and `dependencies` and `VS Code specific fields` such as `publisher`, `activationEvents` and `contributes`.

You can find description of all VS Code specific fields in Extension Manifest Reference. 

+ `name` and `publisher`: VS Code uses `<publisher>.<name>` as a `unique ID` for the extension. 
    For example, the `Hello World` sample has the ID `vscode-samples.helloworld-sample`.
    VS Code uses the ID to uniquely identify your extension

+ `main`: The extension entry point.

+ `activationEvents and contributes`: Activation Events and Contribution Points.

+ `engines.vscode`: This specifies the minimum version of VS Code API that the extension depends on.

> + The postinstall script: This would install the 1.34.0 version of VS Code API as specified in `engines.vscode`. Once the `vscode.d.ts` file is downloaded to `node_modules/vscode/vscode.d.ts`, you will get IntelliSense, jump to definition and error checking for all usage of VS Code API.

```json
{
  "name": "helloworld-sample",
  "displayName": "helloworld-sample",
  "description": "HelloWorld example for VS Code",
  "version": "0.0.1",
  "publisher": "vscode-samples",
  //公共名
  "repository": "https://github.com/Microsoft/vscode-extension-samples/helloworld-sample",
  // 仓库
  "engines": {
    "vscode": "^1.34.0"
  },
  // 使用的vscode api版本
  "categories": ["Other"],
  "activationEvents": ["onCommand:extension.helloWorld"],
  // 激活事件
  "main": "./out/extension.js",
  // 入口文件
  "contributes": {
    "commands": [
      {
        "command": "extension.helloWorld",
        "title": "Hello World"
      }
    ]
  },
  // 描述
  "scripts": {
    "vscode:prepublish": "npm run compile",
    "compile": "tsc -p ./",
    "watch": "tsc -watch -p ./",
    "postinstall": "node ./node_modules/vscode/bin/install"
  },
  // 脚本
  "devDependencies": {
    "@types/node": "^8.10.25",
    "@types/vscode": "^1.34.0",
    "tslint": "^5.16.0",
    "typescript": "^3.4.5"
  }
  //依赖
}
```

## js文件官方解读

The extension entry file exports two functions, `activate` and `deactivate`.

    1. activate is executed when your registered Activation Event happens. 
    2. deactivate gives you a chance to clean up before your extension becomes deactivated.

The vscode module contains a script located at node `./node_modules/vscode/bin/install`.
The script pulls the `VS Code API` definition file depending on the engines.
vscode field in `package.json`. After running the script, you would get IntelliSense, jump to definition and other TypeScript language features in your code.

```js
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {
  // Use the console to output diagnostic information (console.log) and errors (console.error)
  // This line of code will only be executed once when your extension is activated
  console.log('Congratulations, your extension "helloworld-sample" is now active!');

  // The command has been defined in the package.json file
  // Now provide the implementation of the command with registerCommand
  // The commandId parameter must match the command field in package.json
  let disposable = vscode.commands.registerCommand('extension.helloWorld', () => {
    // The code you place here will be executed every time your command is executed

    // Display a message box to the user
    vscode.window.showInformationMessage('Hello World!');
  });

  context.subscriptions.push(disposable);
}

// this method is called when your extension is deactivated
export function deactivate() {}
```