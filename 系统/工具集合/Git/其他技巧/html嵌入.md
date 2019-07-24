# 通过HTML方式嵌入Github

如下面所示，`user`和`repo`改成想要展示的便可以

> 展示`start`链接点击

```html
<iframe src="//ghbtns.com/github-btn.html?user=alloyteam&repo=alloytouch&type=watch&count=true" allowtransparency="true" frameborder="0" scrolling="0" width="110" height="20"></iframe>
```

插入之后便可以看到对应的展示

> <https://img.shields.io> 可生成所需图标

## 示例

```html

<p align="center">"<i>NOthing or Everything</i>"</p>

<h4 align="center">A collection of Study redord, learing note, awesome lists, manuals, blogs, hacks, one-liners, cli/web tools and more.</h4>

<br>

<p align="center">
  <a href="https://github.com/gaoljhy/blog/tree/master">
    <img src="https://img.shields.io/badge/Branch-master-green.svg?longCache=true"
        alt="Branch">
  </a>
  <a href="https://github.com/gaoljhy/blog/pulls">
    <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg?longCache=true"
        alt="Pull Requests">
  </a>
  <a href="https://github.com/gaoljhy/blog/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg?longCache=true"
        alt="License">
  </a>
</p>

<div align="center">
  <sub>Created by
  <a href="http://grj321.com">gaoljhy</a> and
  <a href="https://github.com/gaoljhy/blog/contributors">
    contributors
  </a>
</div>

<br>
```
