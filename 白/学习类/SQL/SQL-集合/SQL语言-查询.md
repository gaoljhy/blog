## `SQL` 语言具有`交互式SQL` 和 `嵌入式SQL` 俩中使用方式

|语句|作用|
|:---:|----|
|` SELECT  column_name `<br/> `FROM  table_name `| 从 表中 查看 某些属性(列)|
|` SELECT DISTINCT column_name,column_name`<br/> `FROM table_name`|从 表中 查看 某些属性(列)，且将该列 中重复的去掉 |
|`SELECT column_name,column_name `<br/>`FROM table_name` <br/>`WHERE column_name operator value`| 从表中 查看 符合某些规则的 某些属性(列)

---
### 比较运算符：
`=` , `>` , `<` , `>=` , `<=` , `!=` , `<> 表示（不等于）`

### 逻辑运算
1. `And`:与 同时满足两个条件的值。

    >`Select * from emp where sal > 2000 and sal < 3000;`<br/>
`>查询 EMP 表中 SAL 列中大于 2000 小于 3000 的值。

2. `Or`:或 满足其中一个条件的值

    >`Select * from emp where sal > 2000 or comm > 500;`<br/>
    >查询 emp 表中 SAL 大于 2000 或 COMM 大于500的值。

3. `Not`:非 满足不包含该条件的值。

    >`select * from emp where not sal > 1500;`<br/>
    >查询EMP表中 sal 小于等于 1500 的值。

### 逻辑运算的优先级：

`()    not        and         or`

### 特殊条件
1. 空值判断： `is null`

    >`Select * from emp where comm is null;`<br/>
    >查询 emp 表中 comm 列中为空的行。

2. `between and` (在 之间的值)

    >`Select * from emp where sal between 1500 and 3000;`<br/>
    >查询 emp 表中 SAL 列中大于 1500 的小于 3000 的值。

    > 注意：<br/>
    >大于等于 1500 且小于等于 3000， 1500 为下限，3000 为上限，下限在前，上限在后，查询的范围 **包含有上下限的值**。

3. `In`

    >`Select * from emp where sal in (5000,3000,1500);`<br/>
    >查询 EMP 表 SAL 列中等于 5000，3000，1500 的值。

4. `like` 模糊查询
    >`Select * from emp where ename like 'M%';`<br/>
    >查询 EMP 表中 Ename 列中以 M 开头 的值，M 为要查询内容中的模糊信息。
    ```
    %  表示多个字值
    _  下划线表示一个字符；
    M%  :  为能配符，正则表达式，表示的意思为模糊查询信息为 M 开头的。
    %M% : 表示查询包含M的所有内容。
    %M_ : 表示查询以M在倒数第二位的所有内容。

    ```

|语句|作用|
|:---:|----|
|`SELECT column_name,column_name`<br/>`FROM table_name`<br/>`ORDER BY column_name,column_name ASC|DESC;`| 从表中 查看 某些属性(列) ，并通过某些列进行 升(默认)降序 排列


