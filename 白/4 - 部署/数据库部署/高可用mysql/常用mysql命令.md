# command

## 查看 状态

### 查看 系统全局状态 

`SHOW GLOBAL STATUS;`

> 结果信息参考 <https://dev.mysql.com/doc/refman/5.5/en/server-status-variables.html>


### 查看引擎状态信息

> `SHOW ENGINE engine_name {STATUS | MUTEX}`

示例

```sql
SHOW ENGINE INNODB STATUS
SHOW ENGINE INNODB MUTEX
SHOW ENGINE {NDB | NDBCLUSTER} STATUS
SHOW ENGINE PERFORMANCE_SCHEMA STATUS
```

> 结果参考 <https://dev.mysql.com/doc/refman/5.5/en/show-engine.html>


### 查看子节点状态信息

`SHOW SLAVE STATUS`

> 结果参考 <https://dev.mysql.com/doc/refman/5.5/en/show-slave-status.html>

### 查看表状态信息

```sql
SHOW TABLE STATUS
    [{FROM | IN} db_name]
    [LIKE 'pattern' | WHERE expr]
```

> 结果参考 <https://dev.mysql.com/doc/refman/5.5/en/show-table-status.html>