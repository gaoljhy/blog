
## 确定locales已经安装，用`apt-get install locales`命令；
## 之后可用`locale -a`查看当前系统支持的字符集。

1. 在命令行输入
   `dpkg-reconfigure locales`
   进入图形化界面之后，（空格是选择，Tab是切换，*是选中），选中`en_US.UTF-8`和`zh_CN.UTF-8`，确定后，将`zh_CN.UTF-8`选为默认。 

2. 安装中文字体
   `apt-get install xfonts-intl-chinese` 和` apt-get install ttf-wqy-microhei`
3. 重启 

这时发现网页不乱码，系统也不乱码。


----------

## 也可以省略之前几步，只运行`2，3`即可，本质上只缺字体文件