
## 创建表
```sql
CREATE TABLE IF NOT EXISTS `gao_tbl`(
   `gao_id` INT UNSIGNED AUTO_INCREMENT,
   `gao_title` VARCHAR(100) NOT NULL,
   `gao_author` VARCHAR(40) NOT NULL,
   `submission_date` DATE,
   PRIMARY KEY ( `gao_id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```
##表的格式更改:

`ALTER TABLE testalter_tbl  DROP columns;`

`ALTER TABLE testalter_tbl ADD columns INT`

`ALTER TABLE testalter_tbl MODIFY col CHAR(10);`

`ALTER TABLE testalter_tbl CHANGE i j BIGINT;`
>在 `CHANGE` 关键字之后，紧跟着的是你要修改的字段名，然后指定新字段名及类型。

`ALTER TABLE testalter_tbl ALTER i SET DEFAULT 1000;`

`ALTER TABLE testalter_tbl RENAME TO alter_tbl;`
>修改表名字

## 表内数据修改：

```sql
INSERT INTO table_name ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN );
```

`UPDATE table_name SET field1=new-value1, field2=new-value2 [WHERE Clause]`


`DELETE FROM table_name [WHERE Clause]`
