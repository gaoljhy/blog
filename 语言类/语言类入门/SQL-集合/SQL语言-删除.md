## 删除表中 数据
```
DELETE FROM table_name
WHERE some_column=some_value;
```
>`WHERE` 子句规定哪条记录或者哪些记录需要删除。<br/>
>如果省略了 W`HERE` 子句，所有的记录都将被删除！


---
## 删除索引

> DROP INDEX 语句

DROP INDEX 语句用于删除表中的索引。

用于 MS Access 的 DROP INDEX 语法：
```
DROP INDEX index_name ON table_name
```
用于 MS SQL Server 的 DROP INDEX 语法：
```
DROP INDEX table_name.index_name
```
用于 DB2/Oracle 的 DROP INDEX 语法：
```
DROP INDEX index_name
```
用于 MySQL 的 DROP INDEX 语法：
```
ALTER TABLE table_name DROP INDEX index_name
```

---
## 删除表

> DROP TABLE 语句

DROP TABLE 语句用于删除表。

```
DROP TABLE table_name
```

> DROP DATABASE 语句

DROP DATABASE 语句用于删除数据库。

```
DROP DATABASE database_name
```

>TRUNCATE TABLE 语句

仅删除表内的数据，并不删除表本身

>TRUNCATE TABLE 语句：

```
TRUNCATE TABLE table_name
```