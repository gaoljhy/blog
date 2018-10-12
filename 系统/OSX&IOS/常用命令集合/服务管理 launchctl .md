## 启动列表
---
> 操作时前面带上 `sudo` ， 代表管理员全局操作
> 
> 如果不加 `sudo` ，只能操作当前用户的服务
> 
> 可能会出现无法操作 root 用户的一些服务的问题

例：
1. 配置一个 `plist` 文件 之后：

    加载一个服务到启动列表
    ```
    sudo launchctl load -w temp.plist 
    ```
    卸载一个服务
    ```
    sudo launchctl unload  temp.plist 
    ```
2. 查看所有服务：
    ```
    sudo launchctl list
    ```
3. 查看服务状态
    ```
    sudo launchctl list | grep <<Service Name>>
    ```
    输出具有以下含义：

        第一个数字是进程的 PID，如果它正在运行，如果它不运行，它显示一个 -
    
        第二个数字是进程的退出代码，如果它已经完成。如果是负数，则是杀死信号的数量。
    
        第三列是进程名称。
4. 服务操作

    停止
    ```
    sudo launchctl stop <<Service Name>>
    ```
    开始
    ```
    sudo launchctl start <<Service Name>>
    ```
    kill服务
    ```
    sudo launchctl kill <<Service Name>> 
    ```
    移除服务
    ```
    sudo launchctl rmeove <<Service Name>> 
    ```

5. 帮助
    ```
    launchctl help
    ```

 

