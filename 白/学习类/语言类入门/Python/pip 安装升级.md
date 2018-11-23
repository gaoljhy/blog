pip 安装
==========

`sudo apt-get install python3-pip`

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
 `pip install -v pycrypto==2.3`
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

    pip3 升级
    `pip3 install --upgrade ip`

安装`pip3`
----------

安装必要依赖
1. 首先安装setuptools

```bash
wget --no-check-certificate  https://pypi.python.org/packages/source/s/setuptools/setuptools-19.6.tar.gz#md5=c607dd118eae682c44ed146367a17e26

tar -zxvf setuptools-19.6.tar.gz

cd setuptools-19.6.tar.gz

python3 setup.py build

python3 setup.py install
```

```bash
wget --no-check-certificate  https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz#md5=3a73c4188f8dbad6a1e6f6d44d117eeb

tar -zxvf pip-8.0.2.tar.gz

mv pip-8.0.2 /usr/local/

cd /usr/local/pip-8.0.2

python3 setup.py build

python3 setup.py install
```