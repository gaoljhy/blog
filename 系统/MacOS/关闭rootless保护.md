# 关闭rootless保护

`sudo nvram boot-args="kext-dev-mode=1 rootless=0";sudo reboot`

## 开启

`sudo nvram -d boot-args && sudo reboot`

--------------------

开机按option 选择recovery mode,

然后在恢复模式的终端里运行

+ `csrutil disable`命令关闭`rootless`
+ 可以用`csrutil enable`命令恢复rootless

------------------------------
