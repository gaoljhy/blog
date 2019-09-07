```shell
SQL> show all --查看所有68个系统变量值 
SQL> show user --显示当前连接用户 
SQL> show error　　 --显示错误 
SQL> set heading off --禁止输出列标题，默认值为ON 
SQL> set feedback off --禁止显示最后一行的计数反馈信息，默认值为"对6个或更多的记录，回送ON" 
SQL> set timing on --默认为OFF，设置查询耗时，可用来估计SQL语句的执行时间，测试性能 
SQL> set sqlprompt "SQL> " --设置默认提示符，默认值就是"SQL> " 
SQL> set linesize 1000 --设置屏幕显示行宽，默认100 
SQL> set autocommit ON --设置是否自动提交，默认为OFF 
SQL> set pause on --默认为OFF，设置暂停，会使屏幕显示停止，等待按下ENTER键，再显示下一页 
SQL> set arraysize 1 --默认为15 
SQL> set long 1000 --默认为80 
```
说明： 
`long`值默认为80，设置1000是为了显示更多的内容，因为很多数据字典视图中用到了long数据类型，如： 

----------------------------------------------
```bash
SQL> desc user_views 
SQL> set heading off --禁止输出列标题 
SQL> set feedback off --禁止显示最后一行的计数反馈信息 
列出当前用户下所有同义词的定义，可用来测试同义词的真实存在性 
select 'desc '||tname from tab where tabtype='SYNONYM'; 
查询当前用户下所有表的记录数 
select 'select '''||tname||''',count(*) from '||tname||';' from tab where tabtype='TABLE'; 
把所有符合条件的表的select权限授予为public 
select 'grant select on '||table_name||' to public;' from user_tables where 《条件》; 
删除用户下各种对象 
select 'drop '||tabtype||' '||tname from tab; 
删除符合条件用户 
select 'drop user '||username||' cascade;' from all_users where user_id>25; 
```


-------------------------------------------------
## 快速编译所有视图 

    ----当在把数据库倒入到新的服务器上后(数据库重建)，需要将视图重新编译一遍， 
    ----因为该表空间视图到其它表空间的表的连接会出现问题，可以利用PL/SQL的语言特性，快速编译。 
    SQL> SPOOL ON.SQL 
    SQL> SELECT'ALTER VIEW '||TNAME||' COMPILE;' FROM TAB; 
    SQL> SPOOL FF 
    然后执行ON.SQL即可。 
    SQL> @ON.SQL 
    当然，授权和创建同义词也可以快速进行，如： 
    SQL> SELECT 'GRANT SELECT ON '||TNAME||' TO 用户名;' FROM TAB; 
    SQL> SELECT 'CREATE SYNONYM '||TNAME||' FOR 用户名.'||TNAME||';' FROM TAB; 

### 命令列表： 

> 假设当前执行命令为：select * from tab; 
```
(a)ppend　　　　 添加文本到缓冲区当前行尾　　　　a order by tname　结果：select * from tab order by tname; 　　　　　　　　　　　　　　　　（注：a后面跟2个空格） 
(c)hange/old/new 在当前行用新的文本替换旧的文本　c/*/tname　　　　　结果：select tname from tab; 
(c)hange/text　　从当前行删除文本　　　　　　　　c/tab　　　　　　　结果：select tname from ; 
del　　　　　　　删除当前行 
del n　　　　　　删除第n行 
(i)nput 文本　　 在当前行之后添加一行 
(l)ist　　　　　 显示缓冲区中所有行 
(l)ist n　　　　 显示缓冲区中第 n 行 
(l)ist m n　　　 显示缓冲区中 m 到 n 行 
run　　　　　　　执行当前缓冲区的命令 
/　　　　　　　　执行当前缓冲区的命令 
r　　　　　　　　执行当前缓冲区的命令 
@文件名　　　　　运行调入内存的sql文件，如： 
SQL> edit s<回车> 
                如果当前目录下不存在s.sql文件，则系统自动生成s.sql文件， 
                在其中输入"select * from tab;"，存盘退出。 
SQL> @s<回车> 
                系统会自动查询当前用户下的所有表、视图、同义词。 
@@文件名　　　　 在.sql文件中调用令一个.sql文件时使用 
save 文件名　　　将缓冲区的命令以文件方式存盘，缺省文件扩展名为.sql 
get 文件名　　　 调入存盘的sql文件 
start 文件名　　 运行调入内存的sql文件 
spool 文件名　　 把这之后的各种操作及执行结果"假脱机"即存盘到磁盘文件上，默认文件扩展名为.lst 
spool　　　　　　显示当前的"假脱机"状态 
spool off　　　　停止输出 

```
例： 
SQL> spool a 
SQL> spool 
正假脱机到 A.LST 
SQL> spool off 
SQL> spool 
当前无假脱机 
exit　　　　　　 退出SQL*PLUS 
desc 表名　　　　显示表的结构 
show user　　　　显示当前连接用户 
show error　　　 显示错误 
show all　　　　 显示所有68个系统变量值 
edit　　　　　　 打开默认编辑器，Windows系统中默认是notepad.exe，把缓冲区中最后一条SQL语句调入afiedt.buf文件中进行编辑 
edit 文件名　　　把当前目录中指定的.sql文件调入编辑器进行编辑 
clear screen　　 清空当前屏幕显示 

二．Oracle sqlplus语句编辑命令 
首先输入这样一条指令： 
SELECT emp_id, emp_name 
FROM Employees 
input 命令可以接着上一条指令的后面添加语句，比如在上述语句运行后输入： 
input WHERE emp_age > 30 
便可得到如下指令： 
SELECT emp_id, emp_name 
FROM Employees 
WHERE emp_age > 30 
ln 命令用于指定对以输入的第n行语句进行操作，比如在上述语句运行后输入： 
l1则当前选中的语句行即为 
SELECT emp_id, emp_name 
（语句前有"*"表示） 
a 命令用于直接在当前行的末尾加上字符，比如在上述语句运行后输入： 
a , emp_dept 
则执行的指令变为： 
SELECT emp_id, emp_name, emp_dept 
FROM Employees 
WHERE emp_age > 30 
c 命令用于修改当前语句中的字符，比如在上述语句运行后输入： 
c /emp_name/emp_age/则执行的指令变为： 
SELECT emp_id, emp_age, emp_dept 
FROM Employees 
WHERE emp_age > 30 
del n 命令用于删除第n行指令，比如在上述语句运行后输入： 
DEL 3 
则执行的指令变为： 
SELECT emp_id, emp_age, emp_dept 
FROM Employees 
