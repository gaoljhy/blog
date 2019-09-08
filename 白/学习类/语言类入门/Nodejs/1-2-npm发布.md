## 创建模块

创建模块，`package.json` 文件是必不可少的。我们可以使用 NPM 生成 package.json 文件，生成的文件包含了基本的结果。

`$ npm init`

```sh
This utility will walk you through creating a package.json file.
It only covers the most common items, and tries to guess sensible defaults.

See `npm help json` for definitive documentation on these fields
and exactly what they do.

Use `npm install <pkg> --save` afterwards to install a package and
save it as a dependency in the package.json file.

Press ^C at any time to quit.
name: (node_modules) runoob                   # 模块名
version: (1.0.0) 
description: Node.js 测试模块(www.runoob.com)  # 描述
entry point: (index.js) 
test command: make test
git repository: https://github.com/runoob/runoob.git  # Github 地址
keywords: 
author: 
license: (ISC) 
About to write to ……/node_modules/package.json:      # 生成地址

{
  "name": "runoob",
  "version": "1.0.0",
  "description": "Node.js 测试模块(www.runoob.com)",
  ……
}


Is this ok? (yes) yes
```

> 以上的信息，需要根据自己的情况输入。在最后输入 "yes" 后会生成 `package.json` 文件。

接下可以使用以下命令在 `npm` 资源库中注册用户（使用邮箱注册）：

```sh
$ npm adduser
Username: mcmohd
Password:
Email: (this IS public) mcmohd@gmail.com
```

接下来就用以下命令来发布模块：

`$ npm publish`

如果你以上的步骤都操作正确，你就可以跟其他模块一样使用 npm 来安装。

## 版本号

使用`NPM`下载和发布代码时都会接触到版本号。

NPM使用语义版本号来管理代码，这里简单介绍一下。

语义版本号分为`X.Y.Z`三位，分别代表**主版本号**、**次版本号**和**补丁版本号**。

> 当代码变更时，版本号按以下原则更新。

1. 如果只是修复bug，需要更新Z位。
2. 如果是新增了功能，但是向下兼容，需要更新Y位。
3. 如果有大变动，向下不兼容，需要更新X位。

版本号有了这个保证后，在申明第三方包依赖时，除了可依赖于一个固定版本号外，还可依赖于某个范围的版本号。

例如 
`"argv": "0.0.x"`表示依赖于`0.0.x`系列的最新版`argv`。

> NPM支持的所有版本号范围指定方式可以查看官方文档。


