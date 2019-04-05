# python-ssh

FROM python:latest

MAINTAINER lemon<gjlove666@hotmail.com>

USER root

RUN echo root:ubuntu | chpasswd -m

RUN echo deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib > /etc/apt/sources.list
RUN echo deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib >> /etc/apt/sources.list
RUN echo deb http://mirrors.aliyun.com/debian-security stretch/updates main >> /etc/apt/sources.list
RUN echo deb-src http://mirrors.aliyun.com/debian-security stretch/updates main >> /etc/apt/sources.list
RUN echo deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib >> /etc/apt/sources.list
RUN echo deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib >> /etc/apt/sources.list
RUN echo deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib >> /etc/apt/sources.list
RUN echo deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install openssh-server

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN service ssh restart

# 开机启动
RUN echo service ssh start > /etc/init.d/rc.loacl

# 在container 中挂载的目录 ，创建容器时，可以进行指定本地dir
VOLUME [ "/work" ]
EXPOSE 22


# 用户进入目录
WORKDIR /root

# build指令
# docker build -t adminhub/python-ssh:latest -f python-ssh.dockerfile  ./

# 创建指令
# docker create -it --name python-ss -p 2222:22 -v /Users/mr.lemon/docker-workdir/:/work:rw adminhub/python-ssh:latest /bin/bash