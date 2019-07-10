# 关闭rootless保护

`sudo nvram boot-args="kext-dev-mode=1 rootless=0";sudo reboot`

## 开启

`sudo nvram -d boot-args && sudo reboot`
