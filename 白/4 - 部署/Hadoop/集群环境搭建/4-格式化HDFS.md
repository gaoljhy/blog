# 五、格式化HDFS

在HDFS的NameNode启动之前需要先初始化其用于存储数据的目录，
如果`hdfs-site.xml`中`dfs.namenode.name.dir`属性指定的目录不存在，格式化命令会自动创建之；
如果事先存在，请确保其权限设置正确，此时格式操作会清除其内部的所有数据并重新建立一个新的文件系统。
需要以`hdfs`用户的身份执行如下命令。

`hdfs namenode -format`

其输出会有大量的信息输出
如果显示出类似`INFO common.Storage: Storage directory /data/hadoop/hdfs/nn has been successfully formatted.`的结果表示格式化操作已经完成。
