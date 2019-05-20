# ecport 

docker export :将文件系统作为一个tar归档文件导出到STDOUT。

## 语法

`docker export [OPTIONS] CONTAINER`

OPTIONS说明：

`-o` :将输入内容写到文件。

## 实例

将id为`a404c6c174a2`的容器按日期保存为tar文件。

docker export -o mysql-`date +%Y%m%d`.tar a404c6c174a2
