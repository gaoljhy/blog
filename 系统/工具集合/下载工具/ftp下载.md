## 目标`ftp`服务器是一个非标准端口的`ftp`

1. 通过`shell`登录
`ftp`    //shell下输入ftp命令,进入到ftp提示符
`>open IP  PORT`   //IP ,PORT对应为服务器的IP和端口号

或者直接使用一条语句

`ftp  IP  PORT`


2. 多文件下载(**对目录无效**)

如:下载目录下的所有文件(子目录是无法下载下来的)
`>mget * `

这样操作,下载每个文件都会提问,每次都要输入一个y
要去掉提问,就要先输入
`>prompt off`


3. 解决:`ftp`命令行不支持目录下载


通过`wget`得到解决
`wget ftp://IP:PORT/* --ftp-user=xxx --ftp-password=xxx -r`

`-r`参数就是用来目录下载的

注:
星号`*`必须有,否则下载下来的就一个文件`index.html`

