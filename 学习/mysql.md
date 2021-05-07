# 快速使用

1. 创建数据库

    create database temp；

2. 删除数据库
    
    drop database temp;

3. 创建数据表
   
   CREATE TABLE IF NOT EXISTS `runoob_tbl`(
    `runoob_id` INT UNSIGNED AUTO_INCREMENT,
    `runoob_title` VARCHAR(100) NOT NULL,
    `runoob_author` VARCHAR(40) NOT NULL,
    `submission_date` DATE,
    PRIMARY KEY ( `runoob_id` )
    )ENGINE=InnoDB DEFAULT CHARSET=utf8;

4. 删除数据表
   DROP TABLE runoob_tbl

5. 插入数据

    INSERT INTO table_name ( field1, field2,...fieldN )
                       VALUES
                       ( value1, value2,...valueN );

6. 查询

    SELECT column_name,column_name
        FROM table_name
        [WHERE Clause]
        [LIMIT N][ OFFSET M]

7. 更新数据
    UPDATE table_name SET field1=new-value1, field2=new-value2
[WHERE Clause]

8. 删除数据
   DELETE FROM table_name [WHERE Clause]

9. 连接

    SELECT expression1, expression2, ... expression_n
        FROM tables
        [WHERE conditions]
        UNION [ALL | DISTINCT]
        SELECT expression1, expression2, ... expression_n
        FROM tables
        [WHERE conditions];
    
10. 排序 ORDER BY
    SELECT field1, field2,...fieldN FROM table_name1, table_name2...
    ORDER BY field1 [ASC [DESC][默认 ASC]], [field2...] [ASC [DESC][默认 ASC]]

11. 分组 GROUP BY
    
    SELECT column_name, function(column_name)
    FROM table_name
    WHERE column_name operator value
    GROUP BY column_name;  

12. 