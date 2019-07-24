# 通过提交的msg自动关闭issues

比如有人提交了个issues:

 `https://github.com/AlloyTeam/AlloyTouch/issues/6`

然后去主干上改代码，改完之后提交填msg的时候，填入：

`fix https://github.com/AlloyTeam/AlloyTouch/issues/6`

这个`issues`会自动被关闭。

当然不仅仅是fix这个关键字。下面这些关键字也可以：

```sh
close

closes

closed

fixes

fixed

resolve

resolves

resolved
````
