# NPM 使用介绍

NPM是随同`NodeJS`一起安装的包管理工具，能解决`NodeJS`代码部署上的很多问题

常见的使用场景有以下几种：

1. 允许用户从NPM服务器下载别人编写的第三方包到本地使用。
2. 允许用户从NPM服务器下载并安装别人编写的命令行程序到本地使用。
3. 允许用户将自己编写的包或命令行程序上传到NPM服务器供别人使用。

> 由于新版的`nodejs`已经集成了`npm`，所以之前`npm`也一并安装好了。
同样可以通过输入 "`npm -v`" 来测试是否成功安装。

## 如果你安装的是旧版本的 npm，可以很容易得通过 npm 命令来升级，命令如下：

`$ sudo npm install npm -g`

如果是 `Window` 系统使用以下命令即可：

`npm install npm -g`

## 使用淘宝镜像的命令：

`npm install -g cnpm --registry=https://registry.npm.taobao.org`


大家都知道国内直接使用 npm 的官方镜像是非常慢的，这里推荐使用淘宝 NPM 镜像。

淘宝 NPM 镜像是一个完整 `npmjs.org` 镜像，可以用此代替官方版本(只读)，同步频率目前为 10分钟 一次以保证尽量与官方服务同步。

可以使用淘宝定制的 `cnpm` (gzip 压缩支持) 命令行工具代替默认的 `npm`:

`$ npm install -g cnpm --registry=https://registry.npm.taobao.org`

这样就可以使用 `cnpm` 命令来安装模块了：

`$ cnpm install [name]`
> 更多信息可以查阅：http://npm.taobao.org/。

## 使用 npm 命令安装模块

npm 安装 `Node.js` 模块语法格式如下：

`$ npm install <Module Name>`

> 以下实例，使用 npm 命令安装常用的 Node.js web框架模块 express:

`$ npm install express`

安装好之后，`express` 包就放在了工程目录下的 `node_modules` 目录中，因此在代码中只需要通过 `require('express')` 的方式就好，无需指定第三方包路径。

`var express = require('express');`

## 全局安装与本地安装

`npm` 的包安装分为本地安装（`local`）、全局安装（`global`）两种，从敲的命令行来看，差别只是有没有`-g`而已，比如

`npm install express          # 本地安装`
`npm install express -g   # 全局安装`

如果出现以下错误：

`npm err! Error: connect ECONNREFUSED 127.0.0.1:8087 `

解决办法为：

`$ npm config set proxy null`

### 本地安装

1. 将安装包放在 `./node_modules` 下（运行 `npm` 命令时所在的目录）
    如果没有 `node_modules` 目录，会在当前执行 npm 命令的目录下生成 `node_modules` 目录。
2. 可以通过 `require()` 来引入本地安装的包。

### 全局安装

1. 将安装包放在 `/usr/local` 下或者你 node 的安装目录。
2. 可以直接在命令行里使用。

如果希望具备两者功能，则需要在两个地方安装它或使用 `npm link`。

> 接下来使用全局方式安装 express

`$ npm install express -g`

安装过程输出如下内容，第一行输出了模块的版本号及安装位置。

```txt
express@4.13.3 node_modules/express
├── escape-html@1.0.2
├── range-parser@1.0.2
├── merge-descriptors@1.0.0
├── array-flatten@1.1.1
├── cookie@0.1.3
├── utils-merge@1.0.0
├── parseurl@1.3.0
├── cookie-signature@1.0.6
├── methods@1.1.1
├── fresh@0.3.0
├── vary@1.0.1
├── path-to-regexp@0.1.7
├── content-type@1.0.1
├── etag@1.7.0
├── serve-static@1.10.0
├── content-disposition@0.5.0
├── depd@1.0.1
├── qs@4.0.0
├── finalhandler@0.4.0 (unpipe@1.0.0)
├── on-finished@2.3.0 (ee-first@1.1.1)
├── proxy-addr@1.0.8 (forwarded@0.1.0, ipaddr.js@1.0.1)
├── debug@2.2.0 (ms@0.7.1)
├── type-is@1.6.8 (media-typer@0.3.0, mime-types@2.1.6)
├── accepts@1.2.12 (negotiator@0.5.3, mime-types@2.1.6)
└── send@0.13.0 (destroy@1.0.3, statuses@1.2.1, ms@0.7.1, mime@1.3.4, http-errors@1.3.1)
```

## 查看安装信息

可以使用以下命令来查看所有全局安装的模块：

`$ npm list -g`

```txt
├─┬ cnpm@4.3.2
│ ├── auto-correct@1.0.0
│ ├── bagpipe@0.3.5
│ ├── colors@1.1.2
│ ├─┬ commander@2.9.0
│ │ └── graceful-readlink@1.0.1
│ ├─┬ cross-spawn@0.2.9
│ │ └── lru-cache@2.7.3
……
```

如果要查看某个模块的版本号，可以使用命令如下：

`$ npm list <module name>`

如
`$ npm list grunt`

```
projectName@projectVersion /path/to/project/folder
└── grunt@0.4.1
```