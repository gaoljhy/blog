## 简介

在`python`的开发中，虚拟环境的搭建是必不可少的

隔离各个子项目，方便管理等等都是其优点

## 安装

```
pip3 install virtualenv 
```

> 检测是否安装成功
```
pip3 freeze
```

## 创建一个`env`

```
virtualenv python3-env  
```
> `virtualenv` 可带其他参数来指定创建一个特定的`env`


等待创建完成后，会在当前目录下创建一个文件夹`python3-env` ，可进入 查看环境

基本的执行文件都在 `bin` 中<br/>
基本`python`库文件都在 `lib` 中

## 激活环境

```
source /bin/activate
```

>激活成功后在命令行 前会显示环境名称 ： `python3-env`

## 关闭环境
```
deactivate
```

## 删除环境

直接 `rm -rf 文件夹` 就可以了


----

其余基本操作与实际环境基本相同 

注意的是 该虚拟环境中并没有真实环境中安装好的扩展包，<br/>
所以安装前需用 `pip freeze` 来查看当前安装了哪些的扩展包