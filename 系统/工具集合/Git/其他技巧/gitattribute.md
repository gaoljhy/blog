# `.gitattributes`设置项目语言

github会根据相关文件代码的数量来自动识别这个项目是HTML项目还是Javascript项目。

## 手动指定项目类型

gitattributes来帮助搞定。

在项目的根目录下添加如下`.gitattributes`文件便可

里面的：

`*.html linguist-language=JavaScript`

> 主要意思是把所有html文件后缀的代码识别成`js`文件。
