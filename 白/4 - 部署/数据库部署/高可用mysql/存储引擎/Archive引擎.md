# Archive

## 文件系统储存

+ 以 `zlib` 对表数据进行压缩,磁盘`I/O`更少

+ 文件大小很小

> Archive 存储数据大小是 `innodb` 和 `myisam`   同等数据的 `1/15`

`ARZ` 后缀文件

## 特点

只支持 `insert` 和 `select` 操作

只支持 在自增列添加索引 `auto_increment`

## 使用场景

+ 数据仓库类,备份类
  
  日志和数据采集类应用

  > 无修改,内容较大