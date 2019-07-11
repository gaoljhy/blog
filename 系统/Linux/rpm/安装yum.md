# 安装yum

yum 是linux环境安装软件包的一种方式。
很多时候安装一个软件安装一个软件需要安装1个或者多个其他软件
 yum仓库用来存放所有的现有的.rpm包，当使用yum安装一个rpm包时，
 需要依赖关系，会自动在仓库中查找依赖软件并安装。仓库可以是本地的，也可以是HTTP、FTP、nfs形式使用的集中地、统一的网络仓库

如果你的linux环境不能访问外网，那你装yum没有意义，因为他需要访问http的仓库里面的。
 当然如果你有本地仓库，就把/etc/yum.repos.d改一下地址就可以

安装：
所有操作均在ROOT用户下，系统版本是
[root@test2 ~]# uname -an
Linux test2 3.10.0-327.el7.x86_64 #1 SMP Thu Nov 19 22:10:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
[root@test2 ~]# cat /etc/redhat-release 
CentOS Linux release 7.2.1511 (Core) 

一、删除原有YUM

`# rpm -aq|grep yum|xargs rpm -e --nodeps`

二、下载yum,注意自己的LINUX系统版本，是什么版本就进相关版本目录去下载。但小版本的目录就不用进了。如版本是6.5，就只需进6 目录，版本是 7.2，只需进7目录。

打开浏览器，登录  <http://mirrors.163.com/centos/7/os/x86_64/Packages/> ，找四个文件，如下：（*号代表小版本号，不同版本不同）

1、yum-*.rpm
2、yum-metadata-parser-*.rpm
3、yum-plugin-fastestmirror-*.rpm
4、python-iniparse-*.rpm

使用wget 下载，前提是你的环境可以上外网。我是下载后自己ftp上传上去的
python-urlgrabber-3.10-8.el7.noarch.rpm
yum-plugin-fastestmirror-1.1.31-42.el7.noarch.rpm
yum-3.4.3-154.el7.centos.noarch.rpm
yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
python-iniparse-0.4-9.el7.noarch.rpm

三、下载完之后，安装YUM

因文件有相互依赖性，注意顺序，故先安装python-iniparse-*.rpm 文件

```sh
# rpm -ivh python-iniparse-0.4-9.el7.noarch.rpm
# rpm -ivh yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
# rpm -ivh yum-3.4.3-154.el7.centos.noarch.rpm   yum-plugin-fastestmirror-1.1.31-42.el7.noarch.rpm
```

注：rpm -ivh 要安装的rpm  --nodeps --force  (加上 --nodeps --force 为強制安裝，不管依赖性文件)
安装完之后，可以使用rm  命令删除当前目录下的RPM文件（装完就没有用处了）。

四、修改来源文件
1、进入到系统yum源的目录下：
   `#cd  /etc/yum.repos.d`

2、下载yum源：
进入：http://mirrors.163.com/.help/centos.html
里面有下载对应版本repo文件, 放入/etc/yum.repos.d/(操作前请做好相应备份)
#wget http://mirrors.163.com/.help/CentOS7-Base-163.repo


3、修改repo源：   将文件中的$releasever替換成7 （7是指LINUX版本號）
修改$basearch 改成操作系统版本：x86_64(也可以不替换)
#vi CentOS6-Base-163.repo


更改后的效果：


[base]
name=CentOS-7 - Base - 163.com
#mirrorlist=http://mirrorlist.centos.org/?release=7&arch=$basearch&repo=os
baseurl=http://mirrors.163.com/centos/7/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7


#released updates
[updates]
name=CentOS-7 - Updates - 163.com
#mirrorlist=http://mirrorlist.centos.org/?release=7&arch=$basearch&repo=updates
baseurl=http://mirrors.163.com/centos/7/updates/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7


#additional packages that may be useful
[extras]
name=CentOS-7 - Extras - 163.com
#mirrorlist=http://mirrorlist.centos.org/?release=7&arch=$basearch&repo=extras
baseurl=http://mirrors.163.com/centos/7/extras/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7


#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-7 - Plus - 163.com
baseurl=http://mirrors.163.com/centos/7/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7

baseurl地址是外网，本地主机要能连接外网，否则白扯。一般公司都有内部镜像

gpgkey没有的话，将gpgcheck设置0



4、改名成默认repo
#mv CentOS7-Base-163.repo CentOS7-Base.repo (这步可做可不做)


5、导入key（具体啥用不知道）
rpm --import  RPM-GPG-KEY-CentOS-7


五、运行makecache 生成缓存
#yum makecache  


六、运行yum clean all（等同于  yum cleanheaders ;  yum cleanpackages）;
#yum clean all


七、更新YUM文件
#yum  update 


八、是否安装成功
yum install perl-DBI 
提示安装，就说明可以了。


问题：No module named yum错误的解决办法
今天用yum安装软件的时候出现如下错误:
There was a problem importing one of the Python modules required to run yum. The error leading to this problem was:
No module named yum
Please install a package which provides this module, or verify that the module is installed correctly.
It’s possible that the above module doesn’t match the current version of Python, which is:
 If you cannot solve this problem yourself, please go to the yum faq at:


yum和Python是依赖关系，yum是python的模块，所以采用以下解决方案：
[root@test2 yum]# whereis python
python: /usr/bin/python2.7 /usr/bin/python /usr/lib/python2.7 /usr/lib64/python2.7 /etc/python /usr/include/python2.7 /usr/share/man/man1/python.1.gz
注意是python2.7


所以修改yum的配置，修改文件： vim /usr/bin/yum
修改头#!/usr/bin/python  => #!/usr/bin/python2.7

此方法存在弊端，因为后面会报错：

 yum 出现错误ImportError: No module named urlgrabber.grabber

 是因为
/usr/libexec/urlgrabber-ext-down

把头部的python改成和/usr/bin/yum中一样的。

所以最好软连接方式：

ln -s python2.7 python 

解决