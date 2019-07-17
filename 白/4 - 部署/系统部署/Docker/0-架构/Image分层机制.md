# 分层机制

> 参见图

- 最底层为 bootfs ，用于系统引导文件
    包括：
        1. bootloader 系统boot载入
        2. kernel 内核
   > 容器完全启动以后会被卸载掉 以节约内存资源

- 其次是 `rootfs`
    docker 容器的根文件系统
    也分为：
        1. Base Image
        2. 编辑器 image
        3. 软件 image
        4. 可写 container
    > 1，2，3 用来共享，为只读。
    > 4 用来编写，为可读写