## ifconfig 操作

1. 查看所有或单个网络配置信息

    ```
    ifconfig -a
    ifconfig 网卡    查看单个网卡信息
    ```

2. 打开/关闭某一网卡

    ```
    ifconfig 网卡 up/down
    ```

3. 刷新网卡

    ```
    ifconfig flush
    ```

4. 修改某一网卡的`mac`, `ip`, `netmask` 等`ifconfig`中所展示的信息

> 有些不对应的可以使用`man` 查询对应`parameter`<br/>
    ```
    ifconfig 网卡 网卡项  值
    ```
例：
```
ifconfig eth0 down
ifconfig eth0 hw ether 00:0C:18:EF:FF:ED
ifconfig eth0 up 
```

> 当然有些值需要遵循固定的协议规定，否则不会改变
