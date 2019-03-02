# SS的配置项说明

```bash
"server" : "",
"server_port" : ,
"password" : "",
"method" : "",
"remarks" : ""
```

各项的意思很明显，分别是：

```bash
"server" : "",     // 服务器地址
"server_port" : ,  // 服务端口
"password" : "",   // 密码
"method" : "",     // 加密方式
"remarks" : ""     // 备注
```

## SS的配置协议说明

官方配置说明：`Shadowsocks` - Quick Guide

根据官方的配置说明，可以看到SS协议采用的协议格式为：

`ss://method[-auth]:password@hostname:port`

并且采用`BASE64`的加密方式对`SS`协议的内容进行加密操作

然后再与`ss://`进行拼接即可。

## 例如

将
`ss://bf-cfb-auth:test@192.168.100.1:8888`

这个内容转换成标准的SS协议内容就成了：

`ss://YmYtY2ZiLWF1dGg6dGVzdEAxOTIuMTY4LjEwMC4xOjg4ODg`
