# nmcli

## 1. 建立和删除一个wifi连接

创建`wifi`连接（SSID：`Samsung-printer`，密码：`12345678`，默认使用设备`wlan0`）的示例：

`nmcli device wifi connect Samsung-printer password 12345678`

每次命令执行后，会在`/etc/NetworkManager/system-connections/`目录下创建一个新文件来保存配置，重复执行则创建多个这样的文件。

删除wifi连接的示例：

`nmcli con del Samsung-printer`

在`/etc/NetworkManager/system-connections/`目录下的Samsung-printer文件将被删除。

## 2. 启动连接和关闭连接

### 启用wifi连接的示例：

```sh
    $ nmcli connection up Samsung-printer
    或者
    $ nmcli device con wlan0
```

### 关闭wifi连接的示例：

```sh
    $ nmcli connection down Samsung-printer
    或者
    $ nmcli device dis wlan0
```

## 3. 创建热点

命令格式及参数解释如下：

`wifi hotspot [ifname ifname] [con-name name] [ssid SSID] [ band { a | bg } ] [channel channel] [password password]`
	

创建一个Wi-Fi热点。该命令根据Wi-Fi设备功能创建热点连接配置文件，并在设备上激活它。如果设备/驱动程序支持，热点将通过WPA进行保护，否则将使用WEP。使用断开连接或断开设备连接来停止热点。

热点的参数会受到可选参数的影响：

`ifname` :使用的网络设备名称

`con-name` :热点的名称

`ssid` :热点的ssid

`band` :wifi的协议标准

`channel` :信道

`password` :热点的密码。
    > 如果不设置，nmcli会生成一个WPA或者WEP的密码。加入全局选项`--show-secrets`将会输出热点的密码，这在nmcli生成密码时十分有用。

### 示例：

`nmcli device wifi hotspot ifname wlan0 con-name KillBill ssid KillBillSSD password 123456dd`

命令执行后，将会创建一个名为`MyHotspot`的连接。使用上述的命令启动连接，将会开启热点。

> 没有dhcp

## 4. 设置自动连接

示例：

`nmcli con modify KillBill connection.autoconnect yes`

# 附加 开机自启

写入 `rc.local`