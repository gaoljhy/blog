# Memory(HEAP)

> 与 **临时表** 不是一个概念
>> 数据易丢失,要求数据可以再生

## 文件系统

数据都保存在 内存中,易丢失

数据结构为 `.frm`

## 特点

1. 支持`HASH`索引 - 适合**等值**(确定的值)查找
2. 支持`BTree`索引 - 适合**范围**(使用`like`等)查找

3. 所有字段都为固定长度 `varchar(10)=cahr(10 ))`
    > 除特殊版本
4. 表级锁
    表的最大大小由 `max_heap_table_size`参数(默认`16M`) 指定
    > 且是创建表是由该参数指定
    >> 创建后修改不会更改大小,只影响创建时设定的大小

### 索引

+ BTree 索引 

`create index index_name using btree on table_name(coloume_name)`

+ 默认索引 `Hash` 索引

`create index index_name on table_name(coloume_name)`

+ 显示索引

`show index from table_name`
 
+ 显示表状态详情

`show table status like table_name`

-------------

## 适用场景

1. 用于查找 或者 作映射作用的表 
    > 如邮编,地区的对应表
2. 用于中间表
    > 如 数据分析中产生的中间表
3. 用于缓存数据的表
    > 如 周期性聚合的数据表

> 数据易丢失,要求数据可以再生

## 注意点

主从复制中

如
1. 主服务器使用memory引擎表,从服务器使用其他可持久化表映射,
2. 但结果是重启 主服务器时
3. 主服务器上`memory`表重建,从服务器上也会跟着重建,
4. 切记重启前导出表,重建后再导入