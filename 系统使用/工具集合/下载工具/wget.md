## wget

`wget`是一个从网络上自动下载文件的自由工具，支持通过`HTTP`、`HTTPS`、`FTP`三个最常见的TCP/IP协议下载

并可以使用`HTTP`代理。

>`wget`名称的由来是“World Wide Web”与“get”的结合。

 

1. `wget`下载单个文件

    `wget http://domain/file`

下载的时候会显示：文件的大小、保存的名称、进度条、下载速度、时间

2. 指定保存的名称

    `wget -O newName http://domain/file`

> 默认情况 wget会用斜杠`/`后面的字符来命名保存的名称

 

3. 断点续传

    `wget -c http://domain/file`

适用于下载大文件或者网络不好的情况，需要服务器支持断点续传


> 不停重连，直到连接成功
`root@kali:~# wget -c https://curl.haxx.se/download/curl-7.54.1.zip`

> `-t`参数表示重连次数，表示只重连10次，-t为0时不限制
`root@kali:~# wget -c -t 10 https://curl.haxx.se/download/curl-7.54.1.zip`

> `-T`参数表示超时等待时间，以秒为单位，表示60秒连不上超时
`root@kali:~# wget -c -T 60 https://curl.haxx.se/download/curl-7.54.1.zip`

 

4. 指定下载速度

    `wget --limit-rate=1024k http://domain/file`

表示限制速度为1MB/s

 

5. 批量下载

`wget -i download.txt`

多个下载链接可以分行写在文本中，实现批量下载

 

6. 选择性下载

    `wget -m --accept=jpg http://domain/dir`

> `--accept` 参数表示可以接受的文件类型

` wget -m --reject=jpg http://domain/dir `

> `--reject` 参数表示拒绝接受的文件类型

或者

`wget -r -A.jpg http://domain/dir`
> 表示下载所有jpg文件

 

7. 后台下载

`wget -b http://domain/file`

后台下载时，会在当前目录中产生`wget-log`文件(输出日志)

----------




8. 利用代理服务器下载

如果下载需要经过代理服务器，wget可以通过代理服务器进行下载。

方法一、在环境变量中设置代理

`export http_proxy=0.0.0.0:8080`

方法二、使用配置文件

可以直接修改/etc/wgetrc，也可以当前目录下创建.wgetrc文件，配置代理服务器
```
https-proxy = 0.0.0.0:8080     //https代理服务器
http-proxy = 0.0.0.0:8080     //http代理服务器
ftp-proxy = 0.0.0.0:8080    //ftp代理服务器
use_proxy = on　　//开启代理
```
这里 use_proxy = on 开启了代理，如果不想使用代理，每次都修改此文件太麻烦，我们可以在命令中使用-Y参数来临时设置：

`-Y, --proxy=on/off`
> 打开或关闭代理


方法三、使用`-e`参数

> 适用于临时代理

`-e`参数表示运行一个“.wgetrc”风格的命令

`wget -e "http-proxy=0.0.0.0:8080" http://domain/file`

注意：如果代理服务器需要密码则使用
```
--proxy-user=代理用户 
--proxy-passwd=代理密码
 ```


---------




9. 测试下载地址是否有效

`wget --spider DOWNLOAD-URL`

>正确的下载地址会显示
**已连接** 

> 错误的会显示
**已失效**


10. `FTP`下载
> `ftp`的`url`需要在文件前加`*`,否则会下载`html`文件

>匿名FTP

`wget ftp-url`

>需登陆认证的FTP

`wget --ftp-user=USERNAME --ftp-password=PASSWORD DOWNLOAD-URL`
 

1.  针对提示没有认证不允许下载

    `wget --no-check-certificate DOWNLOAD-URL`

>不要验证服务器的证书。
 

12. 下载一个完整的网站

适用于完整下载一个网站用于本地浏览

`wget --mirror -p --convert-links -P LOCAL-DIR WEBSITE-URL`

`--mirror`:打开镜像选项

`-p`:下载所有用于显示给定网址所必须的文件

`--convert-links`：下载以后，转换链接用于本地显示

`-P LOCAL_DIR`：保存所有的文件或目录到指定的目录下

 