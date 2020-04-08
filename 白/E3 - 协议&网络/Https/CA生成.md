# 二. CA

自己当`CA`，就是用`openssl`命令生成自己的根证书，让用户安装信任它，那么所有用这个根证书签名的证书，就也可以被信任啦。

所以做为`CA`，首先要生成自己的根证书`ca.cert.pem`，而生成根证书需要`ca.key.pem`。

## 开始

创建`/root/ca`文件夹，所有CA的操作都会在这个文件夹执行。

```
    # mkdir /root/ca
    # cd /root/ca
    # mkdir certs crl newcerts private
    # chmod 700 private
    # touch index.txt
    # echo 1000 > serial
    # touch openssl.cnf
```

### 后续目录详解

    `/root/ca`：CA文件夹
    `/root/ca/certs`：新签署证书和根证书存放的位置
    `/root/ca/crl`：证书请求文件存放位置
    `/root/ca/newcerts`：新签署证书存放的位置，是/root/ca/certs的备份
    `/root/ca/private`：ca.key.pem存放位置，千万别丢失
    `/root/ca/index.txt`：证书签名的纪录
    `/root/ca/serial`：下一次证书签名的序列号，保存到index.txt

### openssl.cnf

拷贝[openssl.cnf](./openssl.cnf)内容到`/root/ca/openssl.cnf`

> 具体的解释可以看上面的链接(真的是很推荐)，这里我拣重要的说下

1. `dir = /root/ca`：这里需要改为上面的CA文件夹
2. `policy = policy_strict`：签CA证书使用strict策略
3. `countryName_default = CN`
4. `0.organizationName_default = wangbin CA`

    这两个是国家和组织名字，会显示到生成的证书上。简单的签个CA证书，我们只设置这两个值，其他都是空。

5. [ v3_ca ]：签CA证书需要这个配置
6. [ server_cert ]：接下来签服务端证书需要这个

## 生成root key

```sh
# cd /root/ca
# openssl genrsa -aes256 -out private/ca.key.pem 4096
```

输入两次密码`wangbin123456`,这个是很重要的密码，设置严格点。

```sh
# chmod 400 private/ca.key.pem
```

## 生成 root certificate

```sh
# cd /root/ca
# openssl req -config openssl.cnf \
      -key private/ca.key.pem \
      -new -x509 -days 7500 -sha256 -extensions v3_ca \
      -out certs/ca.cert.pem
```

根据提示输入key的密码：`wangbin123456`
然后一值回车下去，使用默认值

```
# chmod 444 certs/ca.cert.pem
```

> `-days 7300`：有效期20年

到这一步`ca.key.pem`(`root key`)和`ca.cert.pem`(`root certificate`)都已经生成好了，路径如下

```
/root/ca/private/ca.key.pem
/root/ca/certs/ca.cert.pem
```

至此生成根证书完成。

`ca.key.pem`密码是`wangbin123456`，非常重要，需要好好保存。

`ca.cert.pem`就是根证书，需要把它发给用户，让用户安装信任它，这样以后我们用这个证书签名的证书就都可以被信任了。


## 此时目录结构

```
.
├── certs
│   └── ca.cert.pem
├── crl
├── index.txt
├── newcerts
├── openssl.cnf
├── private
│   └── ca.key.pem
└── serial
```