# v2ray

v2ray 是一个模块化的代理工具，支持 VMess，Socks，HTTP，Shadowsocks 等等协议，并且附带很多高级功能，HTTP 伪装， TLS 等等。

安装 install
root 账户下执行

`bash <(curl -L -s https://install.direct/go.sh)`

该脚本会自动安装 unzip 和 daemon。脚本执行成功后，进行如下操作：

编辑文件 vim /etc/v2ray/config.json 来配置
运行 service v2ray start 来启动 v2ray
使用 service v2ray start|stop|status|reload|restart|force-reload 来控制 v2ray
配置 config
v2ray 使用 JSON 格式的配置文件，大致配置格式如下：

{
  "log": {},
  "dns": {},
  "routing": {},
  "policy": {},
  "inbound": {},
  "outbound": {},
  "inboundDetour": [],
  "outboundDetour": [],
  "transport": {}
}
更加详细的配置详解可以参考官方的文档

v2ray 支持以下协议，默认的协议为 VMess

Blackhole
Dokodemo-door
Freedom
HTTP
Shadowsocks
Socks
VMess
如果想要修改 clients 下面的 id，可以访问 https://www.uuidgenerator.net/ 网站生成 UUID，对于服务端配置来说，主要关心 inbound 中配置，包括端口，协议，和 id 以及 alterId。这些配置需要和客户端一致。

{
  "log" : {   //日志配置
    "access": "/var/log/v2ray/access.log", //访问日志
    "error": "/var/log/v2ray/error.log",   //错误日志
    "loglevel": "warning" //日志等级
  },
  "inbound": {   // 主传入连接
    "port": 10800,  // 端口
    "protocol": "vmess",  //协议
    "settings": {
      "clients": [
        {
          "id": "d931e571-c9d2-4527-9223-9ef1cdeaf4b2",  // 客户端需要和服务端一致
          "level": 1,
          "alterId": 64   // 客户端需要和服务端一致
        }
      ]
    }
  },
  "outbound": {
    "protocol": "freedom",
    "settings": {}
  },
  "outboundDetour": [
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "strategy": "rules",
    "settings": {
      "rules": [
        {
          "type": "field",
          "ip": [
            "0.0.0.0/8",
            "10.0.0.0/8",
            "100.64.0.0/10",
            "127.0.0.0/8",
            "169.254.0.0/16",
            "172.16.0.0/12",
            "192.0.0.0/24",
            "192.0.2.0/24",
            "192.168.0.0/16",
            "198.18.0.0/15",
            "198.51.100.0/24",
            "203.0.113.0/24",
            "::1/128",
            "fc00::/7",
            "fe80::/10"
          ],
          "outboundTag": "blocked"
        }
      ]
    }
  }
}
观察服务端配置基本上能看到两大块重点，一个重点就是 inbound 另一个重点就是 outbound，对应客户端也是同样的配置，对于服务端来说，他的流入就是客户端的流出，对于服务端来说，需要在 inbound 中配置，然后客户端需要在 outbound 中配置和服务端一致的配置，然后就能连入。

客户端配置
根据自己的系统选择下载客户端版本: https://github.com/v2ray/v2ray-core/releases

客户端配置中，需要特殊关心的就是 outbound 中内容，需要关心服务器地址，端口，ID，和 alterId。

{
  "inbound": {
    "port": 1080, // 监听端口
    "protocol": "socks", // 入口协议为 SOCKS 5
    "settings": {
      "auth": "noauth"  //socks的认证设置，noauth 代表不认证，由于 socks 通常在客户端使用，所以这里不认证
    }
  },
  "outbound": {
    "protocol": "vmess", // 出口协议
    "settings": {
      "vnext": [
        {
          "address": "serveraddr.com", // 服务器地址，请修改为你自己的服务器 ip 或域名
          "port": 16823,  // 服务器配置端口
          "users": [
            {
              "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户ID，必须与服务器端配置相同
              "alterId": 64 // 此处的值也应当与服务器相同
            }
          ]
        }
      ]
    }
  }
}
总的来说，各大客户端只需要关心几个配置，服务器地址，配置协议，端口，及认证方式。对于 VMess 协议，需要知道 id，alterId。

Linux
下载对应 Linux 的客户端，执行 ./v2ray --config=config.json 来启动客户端，如果看到日志正常表示已经连接成功。

Windows/MacOS
类似 Linux，启动客户端配置本地，其他选择还有

Windows 下 V2RayW， MacOS 下 V2RayX
