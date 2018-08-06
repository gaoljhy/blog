## 1.更新软件源：

`sudo leafpad /etc/apt/sources.list      `

> 添加中科大源：

#### 直接粘贴复制

```
# Kali 源：


#科大的云
deb http://mirrors.ustc.edu.cn/kali sana main non-free contrib
deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib 
deb-src http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
deb http://mirrors.ustc.edu.cn/kali-security sana/updates main contrib non-free
deb http://mirrors.ustc.edu.cn/kali-security kali-current/updates main contrib non-free 
deb-src http://mirrors.ustc.edu.cn/kali-security kali-current/updates main contrib non-free
#阿里云
deb http://mirrors.aliyun.com/kali sana main non-free contrib
deb-src http://mirrors.aliyun.com/kali sana main non-free contrib
deb http://mirrors.aliyun.com/kali-security sana/updates main contrib non-free
# 163 源
deb http://mirrors.163.com/debian wheezy main non-free contrib
deb-src http://mirrors.163.com/debian wheezy main non-free contrib
deb http://mirrors.163.com/debian wheezy-proposed-updates main non-free contrib
deb-src http://mirrors.163.com/debian wheezy-proposed-updates main non-free contrib
deb-src http://mirrors.163.com/debian-security wheezy/updates main non-free contrib
deb http://mirrors.163.com/debian-security wheezy/updates main non-free contrib
#新加坡kali源
deb http://mirror.nus.edu.sg/kali/kali/ kali main non-free contrib
deb-src http://mirror.nus.edu.sg/kali/kali/ kali main non-free contrib
deb http://security.kali.org/kali-security kali/updates main contrib non-free
deb http://mirror.nus.edu.sg/kali/kali-security kali/updates main contrib non-free
deb-src http://mirror.nus.edu.sg/kali/kali-security kali/updates main contrib non-free
```

> 更新操作：`apt-get update && apt-get dist-upgrade` <br>
>  删除废弃软件 `apt autoremove `


注意 更新`dist`有些以前的版本会不能用 ,但是最新工具会增多

--------


## 2. 虚拟机 `vmtools`

`apt-get install open-vm-tools-desktop fuse`　//安装虚拟机VMtools增强工具

如果安装后还是无法在物理机和虚拟机之间复制粘贴文件的话，可能是你安装了虚拟机自带`vmware-tools`，所以要先把你安装的vmware-tools卸载

打开终端输入命令：`vmware-uninstall-tools.pl`

回车即可删除 在安装就可以了


## 3.其他一些常用软件
```
apt-get install xarchliver  //解压缩软件图形界面

apt-get install ristretto   //Xfce 桌面环境下的图片查看器。

apt-get install xfce4-screenshooter  //屏幕截图软件

apt-get install gdebi   //deb软件包安装程序

apt-get install remmina //GTK+远程桌面客户端

apt-get install galculator  //计算器

apt-get install Mousepad    // Xfce 桌面环境下的一个快速的文本编辑器 。

```

 

## 4.安装输入法，搜狗

打开搜狗输入法Linux版的官网http://pinyin.sogou.com/linux/?r=pinyin，并下载你需要的版本，

下载完成后进入下载目录，在终端执行安装，输入命令

`dpkg -i sogoupinyin_2.0.0.0068_i386 ` //你的安装文件名

也可以用GDebi软件打开进行安装，安装过程会出现依赖关系问题，所以安装完成后在执行以下命令

`apt-get install -f `
修复一下依赖关系就可以了


 

## 5.火狐浏览器是英文的解决方法

打开火狐附加组件网址

`https://addons.mozilla.org/zh-cn/firefox/addon/chinese-simplified-zh-cn-la/versions/`

添加你火狐浏览器所对应的版本 添加----install安装

重启浏览器即可解决



## 6. 安装原版Firefox方法：

```
iceweasel 于更新到26.0了。

Firefox已经更新到26，我很喜欢它的新下载管理器，可惜iceweasel版本还是停留在18.01，so。。。

apt-get remove iceweasel

echo -e "\ndeb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main" | sudo tee -a /etc/apt/sources.list >/dev/null

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29

apt-get update

apt-get firefox-mozilla-build
```



1. kali-linux安装qq2012

```
root权限：

（1）dpkg --add-architecture i386

         apt-get update

         apt-get install ia32-libs  libnotify-bin ia32-libs-gtk      

         #如果是32位操作系统，这步可以跳过

（2） 下载这个库文件（alsa-lib）：

           http://pan.baidu.com/share/link?shareid=470635&uk=1209563959

           cd到下载目录

           bzip2 -d alsa-lib-1.0.26.tar.bz2 && tar -vxf alsa-lib-1.0.26.tar && cd alsa-lib-1.0.26/ && ./configure && make && make install && make clean

（3）下载安装wineqq2012：           

           wget http://www.longene.org/download/WineQQ2012-20121221-Longene.deb && dpkg -i WineQQ2012-20121221-Longene.deb

```

8. 安装一些工具：
   
```
   apt-get install gnome-tweak-tool                                         #安装gnome管理软件

   apt-get install synaptic                                                        #安装新立德

   apt-get install software-center                                            #安装ubuntu软件中心

   apt-get install file-roller                                                        #安装解压缩软件

   apt-get install clementine                                                    #clementine音乐播放器

   apt-get install smplayer                                                      #安装smplayer视频播放器

   apt-get install terminator                                                     #安装多窗口终端 ps: 安装后Open In Terminal 不能使用

   apt-get install htop rar aria2                                                #安装秒杀top的htop,原版rar下载工具aria2

   apt-get install gdebi                                                             #安装Deb包图形安装工具

   apt-get install gnome-tweak-tool                                         #安装Gnome3优化设置工具

   apt-get install nautilus-open-terminal                                  #安装右键打开"Open In Terminal”的快捷方式

   apt-get install netspeed                                                       #安装显示当前网络上传下载速度的GNOME applet

   sudo apt-get install yum                                                      #安装 yum 命令

   sudo yum install gcc                                                            #安装 gcc 命令

```

注：部分工具得重启才能用


9. 下载安装 wps offcie  
    ```
    http://community.wps.cn/download/   ;
    安装命令 ：dpkg -i *.deb 或 右键Deb包图形工具安装
    ```

10. Python类工具需要：

```
apt-get install python-dev python-greenlet python-gevent python-vte python-openssl python-crypto python-appindicator libnss3-tools
```

安装 pip，方便升级 gevent1.0：
```
apt-get install python-setuptools

easy_install pip

pip install setuptools --no-use-wheel --upgrade  //如提示 setuptools 版本错误时执行下面这句命令

pip install gevent --upgrade
```

安装 Python3 OpenSSL:

下载地址： 
```
http://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.13.tar.gz#md5=767bca18a71178ca353dff9e10941929
```

解压后执行` python3 setup.py install`

