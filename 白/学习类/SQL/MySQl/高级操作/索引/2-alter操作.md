# alter

## 使用ALTER 命令添加和删除索引

有四种方式来添加数据表的索引：

+ `ALTER TABLE tbl_name ADD PRIMARY KEY (column_list)`
    该语句添加一个主键，这意味着索引值必须是唯一的，且不能为NULL。

+ `ALTER TABLE tbl_name ADD UNIQUE index_name (column_list)`
    这条语句创建索引的值必须是唯一的（除了NULL外，NULL可能会出现多次）。

+ `ALTER TABLE tbl_name ADD INDEX index_name (column_list)`
    添加普通索引，索引值可出现多次。

+ `ALTER TABLE tbl_name ADD FULLTEXT index_name (column_list)`
    该语句指定了索引为 FULLTEXT ，用于全文索引。

### 以下实例为在表中添加索引。

`ALTER TABLE testalter_tbl ADD INDEX (c);`
还可以在 ALTER 命令中使用 DROP 子句来删除索引。

`ALTER TABLE testalter_tbl DROP INDEX c;`

## 使用 `ALTER` 命令添加和删除主键索引

主键只能作用于一个列上，添加主键索引时，需要确保该主键默认不为空（`NOT NULL`）。

### 实例如下：

```mysql
mysql> ALTER TABLE testalter_tbl MODIFY i INT NOT NULL;
mysql> ALTER TABLE testalter_tbl ADD PRIMARY KEY (i);
```

使用 `ALTER` 命令删除主键：

`mysql> ALTER TABLE testalter_tbl DROP PRIMARY KEY;`

> 删除主键时只需指定`PRIMARY KEY`
> 但在删除索引时，必须知道索引名。

