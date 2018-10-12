## 修改表中某一列数据
```
UPDATE table_name
SET column1=value1,column2=value2,...
WHERE some_column=some_value;
```
>`WHERE` 子句规定哪条记录或者哪些记录需要更新。<br/>
>如果省略了 WHERE 子句，所有的记录都将被更新！


----
## 修改表的属性

>SQL ALTER TABLE 语法

如需在表中添加列
```
ALTER TABLE table_name
ADD column_name datatype
```

如需删除表中的列
```
ALTER TABLE table_name
DROP COLUMN column_name
```

要改变表中列的数据类型

SQL Server / MS Access：
```
ALTER TABLE table_name
ALTER COLUMN column_name datatype
```

My SQL / Oracle：

```
ALTER TABLE table_name
MODIFY COLUMN column_name datatype
```