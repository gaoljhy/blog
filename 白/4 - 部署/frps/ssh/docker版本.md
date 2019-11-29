# 版本

## 安装 docker

```sh
# docker 安装
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh --mirror Aliyun

或者

wget -qO- https://get.docker.com/|sh
```

## run

`docker run --rm -v /:/work --privileged adminhub/sshinfrp_client`