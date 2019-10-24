# 视图 TreeView

第三类 `API` 则是跟视图有关。

这一套 `API` 的最初需求是来自于 `Visual Studio` 用户，在 `Visual Studio` 中，可以在视图中看到**项目**、**测试**、**云管理**等

但是 VS Code 当时并没有 `API` 可以实现这种定制。
于是 `TreeView API` 应运而生，通过实现这套 `API`，任何插件都可以实现类似于资源管理器的树形结构。

`TreeView` API 虽然是用于创建视图中树形结构的，但是它跟 `VS Code` 的其他 API 非常类似，都是给 `VS Code` 提供数据，然后 `VS Code` 来进行渲染。

## 创建 TreeView 的 API 也非常简单：

```js
export namespace window {
 export function registerTreeDataProvider<T>(viewId: string, treeDataProvider: TreeDataProvider<T>): Disposable;
}
```

`registerTreeDataProvider` 一共有两个参数
1. 第一个是这个 `TreeView` 的名字
2. 第二个则是这个 `TreeView` 的数据来源 `Data Provider`。

### Data Provider 长什么样呢？

```js
export interface TreeDataProvider<T> {
  onDidChangeTreeData?: Event<T | undefined | null>;
  getTreeItem(element: T): TreeItem | Thenable<TreeItem>;
  getChildren(element?: T): ProviderResult<T[]>;
  getParent?(element: T): ProviderResult<T>;
 }
```

这个 `Data Provider` 上，只有两个属性是必须的。

1. 第一个是 `getTreeItem`，通过这个函数，`VS Code` 就知道该怎么渲染某个树节点了。
2. 第二个就是 `getChildren`，这个也很好理解，就是返回一个树节点的所有子节点的数据。

###  `TreeItem`，也就是每个树节点的数据结构：

```js
export class TreeItem {
  label?: string;
  id?: string;
  iconPath?: string | Uri | { light: string | Uri; dark: string | Uri } | ThemeIcon;
  resourceUri?: Uri;
  tooltip?: string | undefined;

  /**
   * The command that should be executed when the tree item is selected.
   */
  command?: Command;

  /**
   * TreeItemCollapsibleState of the tree item.
   */
  collapsibleState?: TreeItemCollapsibleState;
  contextValue?: string;
  constructor(label: string, collapsibleState?: TreeItemCollapsibleState);
  constructor(resourceUri: Uri, collapsibleState?: TreeItemCollapsibleState);
 }
```

TreeItem 有两种创建方式：
1. 第一种，就是提供 `label`，也就是一个字符串，`VS Code` 会把这个字符串渲染在树形结构中；
2. 第二种就是提供 `resourceUri`，也就是一个资源地址，`VS Code` 则会像资源管理器里渲染文件和文件夹一样渲染这个节点的。

### 至于其他属性：

1. `iconPath` 属性，是用于控制树节点前的图标的。
    如果说自己通过 `TreeView API` 来实现一个资源管理器的话，就可以使用 `iconPath` 来为不同的文件类型指定不同的图标。
2. `tooltip` 属性，当把鼠标移动到某个节点上等待片刻，`VS Code` 就会显示出这个节点对应的 tooltip 文字。
3. `collapsibleState` 是用于控制这个树节点是应该展开还是折叠。
    当然，如果这个节点没有子节点的话，这个属性就用不着了。
4. `command` 属性，如果有这个属性的话，当点击这个树节点时，这个属性所指定的命令就会被执行了。

## 整合

了解了以上几个属性，就能够实现一个简易的 `TreeView` 了。

```js
vscode.window.registerTreeDataProvider('myextension', {
    getChildren: (element) => {
        if (element) {
            return null;
        }

        return ['first', 'second', 'third'];
    },
    getTreeItem: (element) => {
        return {
            label: element,
            tooltip: 'my ' + element + ' item'
        }
    }
})
```

上面的这段代码，注册了一个名为 `myextension` 的 `TreeView`，这个 TreeView 只有一层节点，它们分别是 `‘first’、 ‘second’、 ‘third’`。

当将这段代码放入 `extension.js` 中时，运行插件，会发现，`VS Code` 的视图里找不到这个名为 `myextension` 的 `TreeView`。

```js
const vscode = require('vscode');

function activate(context) {
    vscode.window.registerTreeDataProvider('myextension', {
        getChildren: (element) => {
            if (element) {
                return null;
            }

            return ['first', 'second', 'third'];
        },
        getTreeItem: (element) => {
            return {
                label: element,
                tooltip: 'my ' + element + ' item'
            }
        }
    })
}
exports.activate = activate;

function deactivate() {
}
exports.deactivate = deactivate;
```

之前在 `extension.js` 里创建 `extension.sayHello` 命令，同时，还在 `package.json` 的 `contributes` 部分申明了这个命令。

要想将这个 `TreeView` 成功地注册到 `VS Code` 中，还得在 `package.json` 的 `contributes` 部分添加 `TreeView` 的申明。

修改后的 `package.json` 的 `contributes` 部分如下：

```json
{
    "contributes": {
        "views": {
   "explorer": [
    {
     "id": "myextension",
     "name": "My Extension"
                }
            ]
        }
    }
}
```


这段 `contributes` 是说，把 `myextension` 这个 `TreeView` 注册到资源管理器中。

### 运行这个插件：

参见图示

除了将 `TreeView` 注册到资源管理器 `Explorer` 下以外

也可以将它注册到版本管理视图中，对应的 `contributes` 如下：

```json
"contributes": {
    "views": {
        "scm": [
            {
                "id": "myextension",
                "name": "My Extension"
            }
        ]
    }
}
```

代码运行起来后，就能够在版本管理视图中看到这个 TreeView 了。

参见图示

简言之，`VS Code` 的 `TreeView API` 使用了 `Data Provider` 的模式，插件提供数据，而 VS Code 负责渲染。

至于数据长什么样、树形结构里的层级关系如何，这个就属于 `Business Logic` 了，需要大家发挥想象力。

比如说 GitHub Pull Request 插件，用树形结构来展示所有的 `Pull Requests` 和每个 PR 里的代码改动
NPM Explorer 则将所有的 NPM 脚本展示在树形结构中。
