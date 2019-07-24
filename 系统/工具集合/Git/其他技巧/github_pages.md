# 一秒钟把Github项目变成前端网站

`GitHub Pages`大家可能都知道

常用的做法

1. 建立一个`gh-pages`的分支
2. 通过`setting`里的设置的GitHub Pages模块可以自动创建该项目的网站。

这里经常遇到的痛点是，`master`遇到变更，经常需要去`sync`到`gh-pages`，特别是纯`web`前端项目，这样的痛点是非常地痛。

Github官方可能嗅觉到了该痛点
出了个master当作网站是选项，太有用了。

选择完`master branch`之后，`master`自动变成了网站。
`master`所有的提交会自动更新到网站。

## 精准分享关键代码

比如有一个文件里的某一行代码写得非常酷炫或者关键，想分享一下。

可以在`url后面加上#L行号`

比如，点击下面这个url：

`https://github.com/AlloyTeam/AlloyTouch/blob/master/alloy_touch.js#L240`

便会跳到`alloy_touch.js`的第240行。

### 如果是一段代码，即**多行代码分享**

`url后面加上#L开始行号-L结束行号`

比如，AlloyTouch的运动缓动和逆向缓动函数如下面代码段所示：

`https://github.com/AlloyTeam/AlloyTouch/blob/master/alloy_touch.js#L39-L45`

其实也不用记忆你直接在网址后面操作，github自动会帮你生成`url`。

比如点击`39行`，url变成了

`https://github.com/AlloyTeam/AlloyTouch/blob/master/alloy_touch.js#L39`

再按住shift点击45行，url变成了

`https://github.com/AlloyTeam/AlloyTouch/blob/master/alloy_touch.js#L39-L45`

然后你这个url就可以复制分享出去了，点击这个url的人自动会跳到39行，并且39-45行高亮。
