# 语法

## environment

> docker create  -e, --env list                  
>> Set environment variables


添加环境变量。

可以使用数组或字典两种形式。
任何布尔值 `true，false，yes，no` 需要用引号括起来，以确保它们不被`YML`解析器转换为`True`或`False`
> 传递时不会被解析为bool变量,而被传递为字符串

只给定名称的变量会自动获取它在 `Compose` 主机上的值，可以用来防止泄露不必要的数据。

```yml
environment:
  RACK_ENV: development
  SHOW: 'true'
  SESSION_SECRET:

environment:
  - RACK_ENV=development
  - SHOW=true
  - SESSION_SECRET
```

> 注意：如果的服务指定了`build`选项，那么在构建过程中通过`environment`定义的环境变量将不会起作用。 
  > 将使用`build`的`args`子选项来定义构建时的环境变量。

------------------------

## pid

> docker create  --pid string                    
>> PID namespace to use

将`PID`模式设置为主机`PID`模式。
这就打开了容器与主机操作系统之间的共享`PID`地址空间。

使用此标志启动的容器将能够访问和操作裸机的命名空间中的其他容器，反之亦然。
> 即打开该选项的容器可以相互通过 `进程 ID` 来访问和操作。

```yml
pid: "host"
```

--------------------

## dns

>docker create --dns list                       
>> Set custom DNS servers

配置 `DNS` 服务器。可以是一个值，也可以是一个列表。

```yml
dns: 8.8.8.8
dns:
  - 8.8.8.8
  - 9.9.9.9
```
