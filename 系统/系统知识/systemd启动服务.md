# 启动服务

1. 准备好你的 sh 脚本文件

   内容略过，就假设路径是`/usr/local/my/my.sh`吧。别忘了`chmod +x`。

2. 创建一个 service 文件

   进入`/etc/systemd/system/`，创建一个`my.service`文件，内容如下：

   ```service
   [Unit]
   Description=just for test                    这里填简介
   After=BBB.service　XXX.service  AAA.service   这里填上你这个脚本所需要的前置service，都在/etc/systemd/system/下

   [Service]
   ExecStart=/usr/local/my/my.sh                  这里填sh文件路径，比如这里运行了这个my.sh，后面也可以跟参数，比如 -D -I

   [Install]
   WantedBy=multi-user.target
   ```

3. 完事

   使用以下命令使能这个服务开机启动：

   ## 重新加载配置文件

   `$ sudo systemctl daemon-reload service文件改动后要重新转载一下`
   `$ sudo systemctl enable my.service 这句是为了设置开机启动`

   如果你想不重启立刻使用这个 sh 脚本，就运行下面这句：

   # 重启相关服务

   `$ sudo systemctl start my.service 启动服务`
