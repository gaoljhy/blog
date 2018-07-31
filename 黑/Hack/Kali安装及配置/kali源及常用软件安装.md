## 1.更新软件源：

`sudo leafpad /etc/apt/sources.list      `

> 添加中科大源：

#### 直接粘贴复制

```
deb http://mirrors.ustc.edu.cn/kali kali main non-free contrib

deb-src http://mirrors.ustc.edu.cn/kali kali main non-free contrib

deb http://mirrors.ustc.edu.cn/kali-security kali/updates main contrib non-free  

# Kali 源：

deb http://http.kali.org/kali kali main non-free contrib
deb-src http://http.kali.org/kali kali main non-free contrib
deb http://security.kali.org/kali-security kali/updates main contrib non-free
deb http://ftp.sjtu.edu.cn/debian wheezy main non-free contrib
deb-src http://ftp.sjtu.edu.cn/debian wheezy main non-free contrib
deb http://ftp.sjtu.edu.cn/debian wheezy-proposed-updates main non-free contrib
deb-src http://ftp.sjtu.edu.cn/debian wheezy-proposed-updates main non-free contrib
deb http://ftp.sjtu.edu.cn/debian-security wheezy/updates main non-free contrib
deb-src http://ftp.sjtu.edu.cn/debian-security wheezy/updates main non-free contrib
deb http://mirrors.163.com/debian wheezy main non-free contrib
deb-src http://mirrors.163.com/debian wheezy main non-free contrib
deb http://mirrors.163.com/debian wheezy-proposed-updates main non-free contrib
deb-src http://mirrors.163.com/debian wheezy-proposed-updates main non-free contrib
deb-src http://mirrors.163.com/debian-security wheezy/updates main non-free contrib
deb http://mirrors.163.com/debian-security wheezy/updates main non-free contrib
```

> 更新操作：`apt-get update && apt-get dist-upgrade` <br>
>  删除废弃软件 `apt-get autoremove `

----
2. kali-linux安装中文字体和五笔拼音输入法：（以下任意选择一种安装）：
```
     apt-get install fcitx-table-wbpy ttf-wqy-microhei ttf-wqy-zenhei                       #拼音五笔

     apt-get install ibus ibus-pinyin                                                                             #经典的ibus

     apt-get install fcitx fcitx-googlepinyin fcitx-pinyin fcitx-module-cloudpinyin     #fcitx拼音  
```

注销，重新登录之后才可以使用。

-------
3. 安装Flash插件：
```
apt-get install flashplugin-nonfree

update-flashplugin-nonfree --install
```

4. 安装原版Firefox方法：

```
iceweasel 于更新到26.0了。

Firefox已经更新到26，我很喜欢它的新下载管理器，可惜iceweasel版本还是停留在18.01，so。。。

apt-get remove iceweasel

echo -e "\ndeb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main" | sudo tee -a /etc/apt/sources.list >/dev/null

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29

apt-get update

apt-get firefox-mozilla-build
```

5. 安装最新 iceweasel，并汉化
```
deb http://mozilla.debian.net/ wheezy-backports iceweasel-release                                          #添加这个软件源

apt-get install pkg-mozilla-archive-keyring                                                                             #导入PGP KEY

gpg --check-sigs --fingerprint --keyring /etc/apt/trusted.gpg.d/pkg-mozilla-archive-keyring.gpg --keyring /usr/share/keyrings/debian-keyring.gpg pkg-mozilla-maintainers                                               #新建钥匙环

apt-get -y update && apt-get install -t wheezy-backports iceweasel && apt-get install iceweasel-l10n-zh-cn
```

6. kali-linux安装flash player：
```
        apt-get install flashplugin-nonfree

        update-flashplugin-nonfree --install
```


7. kali-linux安装qq2012

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

