# 制作启动盘

## 一 挂载U盘

1. 插入U盘，打开终端使用下面的命令查看U盘是否已经mount到系统

> 这时在Finder下也能看到U盘。

`diskutil list`

系统输出中看到U盘所对应的 `disk`

如下：

```bash
/dev/disk2 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *16.0 GB    disk2
   1:               Windows_NTFS SE-et                   16.0 GB    disk2s1
```

## 二 解挂 U盘

`unmount`这个U盘

使用如下命令：

`diskutil unmountDisk /dev/disk2`

此时有了一个已经插入但是`unmount`的U盘了

> 这时候在Finder下看不到这个U盘了
> 但是用`diskutil list`命令还可以看到。

## 三 写系统镜像到U盘

接下来将要制作的Linux iso文件写到U盘里

`sudo dd if=/Users/mr.le/Downloads/CentOS-7-x86_64-DVD-1511.iso of=/dev/disk2 bs=1m`

`bs` : 表示写入块大小，可以设置为`2M`，但不要太大。

## 完成

中间可能会有时间无输出
完成之后会输出日志
