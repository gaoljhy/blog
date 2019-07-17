## `Nessus`  完成扫描，结果保存为`.nessus` 格式

`Metasploit`可以自动处理来自`Nessus`和`OpenVAS`的漏洞扫描结果文件。

> msf 可以自动识别导入文件格式

1. `load nessus`   载入模块
2. `help` 将展示所有 载入的 帮助通用命令
3. `db_import /root/Nessus/nessus_scan.nessus` 载入`nbe`文件
4. `hosts`, `services ip`
5. `help vulns`
6. `search exploit`
7. `exploit`



------------------------
## 连接 `Nessus`

先查看`nessus`连接的命令的用法，如下图有几种连接的方式：

1. `load nessus`
2. `nessus_help`
3. `nessus_connect root:toor@localhost:8834 ok`
    >最后一个参数为`OK`，代表确认可能发生中间人的风险。
4. `nessus_save`
    > 保存登陆凭据 ，下回直接 `nessus_connect` 就可以了


---------------------------

## 导入结果后，自动化攻击

1. `load db_autopwn`  
2. `db_autopwn -h` 查看自动渗透选项
    >` db_autopwn -t -p -e -r`

