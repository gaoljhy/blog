pip 升级
========

> pip 当前内建命令并不支持升级所有已安装的Python模块。

1. 列出当前安装的包：

    `pip list`

2. 列出可升级的包：

    `pip list --outdate`

3. 升级一个包：

    `pip install --upgrade requests`  // mac,linux,unix 在命令前加 sudo -H
    > 指定版本时 使用 `-v 版本号
`
4. 升级所有可升级的包：

    `pip freeze --local | grep -v '^-e' | cut -d = -f 1  | xargs -n1 pip install -U`

    `for i in "pip list -o --format legacy|awk '{print $1}'" ; do pip install --upgrade $i; done`

5. `pip`默认源由于墙，所以速度很慢，可使用第三源提高速度：

    `vim ~/.pip/pip.conf`

    ```text
    [global]
    trusted-host = mirrors.aliyun.com
    index-url = http://mirrors.aliyun.com/pypi/simple
    ```

6. 直接使用 国内镜像
    `pip install tensorflow -i http://pypi.douban.com/simple --trusted-host pypi.douban.com`
    国外镜像源不好用时 ，都可以加 `-i` 以后的

7. `pip` 自身升级
    `easy_install --upgrade pip`
    或
    `pip install --upgrade pip`
