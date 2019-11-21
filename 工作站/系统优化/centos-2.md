## 修改SSH登录配置

`vi /etc/ssh/sshd_config`

```conf
Port 2222
Protocol 2
PermitRootLogin no 
PermitEmptyPasswords no
# 关闭SSH反向查询，以加快SSH的访问速度
UseDNS no
```
> 保持机器中至少包含一个具有sudo权限的用户，上面的配置禁止`root`远程登录

systcmctl restart sshd

> 可下一次执行,或者在iptable 上添加完规则再执行

## 清理登陆的时候显示的系统及内核版本
　
1. 查看登陆信息

cat /etc/redhat-release
cat /etc/issue

2. 修改登陆显示 信息

echo “MY Centos Linux Pretty - Lemon” >/etc/redhat-release 
echo >/etc/issue

-------------

## 删除不必要的系统用户和群组

### 删除不必要的用户

```sh
userdel adm
userdel lp
userdel sync
userdel shutdown
userdel halt
userdel news
userdel uucp
userdel operator
userdel games
userdel gopher
userdel ftp
```

### 删除不必要的群组

```sh
groupdel adm
groupdel lp
groupdel news
groupdel uucp
groupdel games
groupdel dip
groupdel pppusers
```

## 网卡配置

在配置 CentOS 7 网卡 IP 地址后

> 添加 三项

```sh
# 系统启动时就启动网卡设备
ONBOOT=yes
# 允许用从DHCP处获取的DNS覆盖本地的DNS
PEERDNS=yes
# 不允许普通用户修改网卡
USERCTL=no
```
 
## 设置一些全局变量

设置自动退出终端，防止非法关闭ssh客户端造成登录进程过多，可以设置大一些，单位为秒

`echo "TMOUT=300">> /etc/profile`


立即生效

`source /etc/profile`

## 设置 history 历史记录

```sh
echo '
export HISTFILE=$HOME/.bash_history
export HISTSIZE=4000
export HISTFILESIZE=4000
export HISTTIMEFORMAT="%F %T `whoami` "
export PROMPT_COMMAND="history -a; history -c; history -r;"
shopt -s histappend
typeset -r PROMPT_COMMAND
typeset -r HISTTIMEFORMAT ' > /etc/profile.d/history.sh
source /etc/profile
```