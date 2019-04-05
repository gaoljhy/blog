# debian开机启动管理

> linux下，services的启动、停止等通常是通过/etc/init.d的目录下的脚本来控制的。

在启动或改变运行级别是在`/etc/rcX.d`中来搜索脚本。
> 其中`X`是运行级别。

## update-rc.d

用法

```sh
   update-rc.d [-n] [-f] <basename> remove
   update-rc.d [-n] <basename> defaults [NN | SS KK]
   update-rc.d [-n] <basename> start|stop NN runlvl [runlvl] [...] .
   update-rc.d [-n] <basename> disable|enable [S|2|3|4|5]
    -n: not really
    -f: force
```

- 强制删除服务

 `update-rc.d -f apache2 remove`

- 添加服务

 `update-rc.d apache2 defaults`

- 指定该服务的启动顺序：

 `update-rc.d apache2 defaults 90`

- 更详细的控制start与kill顺序：

 `update-rc.d apache2 defaults 20 80`

>其中前面的`20`是start时的运行顺序级别，`80`为kill时的级别

- 也可以写成：

 `update-rc.d apache2 start 20 2 3 4 5 . stop 80 0 1 6 .`

> 其中`0～6`为运行级别。

- update-rc.d命令不仅适用Linux服务，编写的脚本同样可以用这个命令设为开机自动运行

> 在debian6中使用update-rc.d会报错，如下：

　　`update-rc.d: using dependency based boot sequencing`

-----

可以使用 `insserv` 命令来代替 `update-rc.d`

## insserv (不自带)

```sh
insserv [<options>] [init_script|init_directory]
Available options:
  -h, --help       This help.
  -r, --remove     Remove the listed scripts from all runlevels.
  -f, --force      Ignore if a required service is missed.
  -v, --verbose    Provide information on what is being done.
  -p <path>, --path <path>  Path to replace /etc/init.d.
  -o <path>, --override <path> Path to replace /etc/insserv/overrides.
  -c <config>, --config <config>  Path to config file.
  -n, --dryrun     Do not change the system, only talk about it.
  -d, --default    Use default runlevels a defined in the scripts
```

- 强制移除
 `insserv -r -f apache2`

- 默认运行级别
 `insserv -d apache.sh`