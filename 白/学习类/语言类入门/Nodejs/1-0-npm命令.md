# npm使用

## 卸载模块

可以使用以下命令来卸载 Node.js 模块。

`$ npm uninstall express`

卸载后，可以到 `/node_modules/` 目录下查看包是否还存在，或者使用以下命令查看：

`$ npm ls`

## 更新模块

可以使用以下命令更新模块：

`$ npm update express`

## 搜索模块

使用以下来搜索模块：

`$ npm search express`

----------

> 查看[官方文档](npmjs.org/doc/)

1. NPM提供了很多命令，例如install和publish，使用npm help可查看所有命令。

2. NPM提供了很多命令，例如install和publish，使用npm help可查看所有命令。

3. 使用`npm help <command>`可查看某条命令的详细帮助，例如npm help install。

4. 在`package.json`所在目录下使用npm install . -g可先在本地安装当前命令行程序，可用于发布前的本地测试。

5. 使用`npm update <package>`可以把当前目录下node_modules子目录里边的对应模块更新至最新版本。

6. 使用`npm update <package> -g`可以把全局安装的对应命令行程序更新至最新版。

7. 使用`npm cache clear`可以清空NPM本地缓存，用于对付使用相同版本号发布新版本代码的人。

8. 使用`npm unpublish <package>@<version>`可以撤销发布自己发布过的某个版本代码。

