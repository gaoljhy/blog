## Kali - WPscan 扫描攻击
可以使用 WPScan 来攻击它了。WPScan 是个黑盒的 WordPress 安全扫描器，允许用户发现 WordPress 上的漏洞。

WPScan 接受多种参数，包括：

-u <目标域名或 url>：参数u允许你指定目标的域名。

-f：参数f允许你强制检查WordPress是否安装。

-e[选项]：参数e允许你设置枚举。

让开始使用 WPScan。

确保你的 WordPress虚拟机和 Kali Linux 虚拟机都开着，并使用VirtualBox Host Only Adapter网络设置。

在 Kali Linux 虚拟机中，加载器 WPScan 帮助文件：

wpscan -h
1
页面会像下面这样：



让对WordPress虚拟机执行基本的 WPScan测试。这里，靶机的IP地址是192.168.56.102。

wpscan –u 192.168.56.102
1
现在，让通过执行下列命令枚举用户名列表：

wpscan –u 192.186.56.102 –e u vp
1
页面会像下面这样：



最后，通过使用–wordlist <文件路径>选项来提供单词列表：

wpscan –u 192.168.56.102 -e u --wordlist /root/wordlist.txt
1
页面会像下面这样：



这就结束了。已经成功获取了 WordPress 的密码。

文章标