## 创建表

> 一般创建方式
```
CREATE TABLE table_name
(
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size),
....
);
```


> SQL CREATE TABLE + CONSTRAINT 创建
```
CREATE TABLE table_name
(
column_name1 data_type(size) constraint_name,
column_name2 data_type(size) constraint_name,
column_name3 data_type(size) constraint_name,
....
);
```
---

## 约束

|约束名|作用|
|----|----|
|`NOT NULL` | 指示某列不能存储 NULL 值。
|`UNIQUE`|  保证某列的每行必须有唯一的值。
|`PRIMARY KEY`|  `NOT NULL` 和 `UNIQUE` 的结合。确保某列（或两个列多个列的结合）有唯一标识，有助于更容易更快速地找到表中的一个特定的记录。
|`FOREIGN KEY`| - 保证一个表中的数据匹配另一个表中的值的参照完整性。
|`CHECK`| - 保证列中的值符合指定的条件。
|`DEFAULT`| - 规定没有给列赋值时的默认值。

---
## 示例
```
CREATE TABLE Persons
(
    Id_P int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255),
    PRIMARY KEY (Id_P)  //PRIMARY KEY约束
)
CREATE TABLE Persons
(
    Id_P int NOT NULL PRIMARY KEY,   //PRIMARY KEY约束
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
)
```


---
## 创建索引
便于查找更高效，快速
```
CREATE INDEX index_name
ON table_name (column_name)
```

> SQL CREATE UNIQUE INDEX 语法

在表上创建一个唯一的索引。<br/>
不允许使用重复的值：唯一的索引意味着两个行不能拥有相同的索引值。
```
CREATE UNIQUE INDEX index_name
ON table_name (column_name)
```
注释：用于创建索引的语法在不同的数据库中不一样。<br/>
因此，检查您的数据库中创建索引的语法。

**CREATE INDEX 实例**

下面的 SQL 语句在 "Persons" 表的 "LastName" 列上创建一个名为 "PIndex" 的索引：

```
CREATE INDEX PIndex
ON Persons (LastName)
```

如果您希望索引不止一个列，您可以在括号中列出这些列的名称，用逗号隔开：
```
CREATE INDEX PIndex
ON Persons (LastName, FirstName)
```



