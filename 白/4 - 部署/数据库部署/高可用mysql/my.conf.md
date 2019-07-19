# my.conf

## 配置文件

参考 : <https://dev.mysql.com/doc/refman/5.6/en/server-configuration.html>

## Configuring the Server
The MySQL server, mysqld, has many command options and system variables that can be set at startup to configure its operation. To determine the default command option and system variable values used by the server, execute this command:

`shell> mysqld --verbose --help`

The command produces a list of all mysqld options and configurable system variables. Its output includes the default option and variable values and looks something like this:

```conf
abort-slave-event-count           0
allow-suspicious-udfs             FALSE
archive                           ON
auto-increment-increment          1
auto-increment-offset             1
autocommit                        TRUE
automatic-sp-privileges           TRUE
back-log                          80
basedir                           /home/jon/bin/mysql-5.6/
...
tmpdir                            /tmp
transaction-alloc-block-size      8192
transaction-isolation             REPEATABLE-READ
transaction-prealloc-size         4096
transaction-read-only             FALSE
updatable-views-with-limit        YES
verbose                           TRUE
wait-timeout                      28800
```

To see the current system variable values actually used by the server as it runs, connect to it and execute this statement:

`mysql> SHOW VARIABLES;`

To see some statistical and status indicators for a running server, execute this statement:

`mysql> SHOW STATUS;`

System variable and status information also is available using the mysqladmin command:

```sh
shell> mysqladmin variables
shell> mysqladmin extended-status
```

For a full description of all command options, system variables, and status variables, see these sections:

[Section 5.1.6, “Server Command Options”](https://dev.mysql.com/doc/refman/5.6/en/server-options.html)

[Section 5.1.7, “Server System Variables”](https://dev.mysql.com/doc/refman/5.6/en/server-system-variables.html)

[Section 5.1.9, “Server Status Variables”](https://dev.mysql.com/doc/refman/5.6/en/server-status-variables.html)

More detailed monitoring information is available from the Performance Schema; 