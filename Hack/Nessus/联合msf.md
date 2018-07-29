## 结合MSF进行漏扫并验证攻击

1. 启动nessus,终端输入：
>/etc/init.d/nesssusd start

2. 开启postgresql、metasploit服务，查看数据库连接情况:
    >service postgresql start<br>
    >msfconsole<br>
    >db_status

    [*]postgresql connected to msf

数据库连接成功

3. MSF上加载nessus：
    >load nessus

    [] Nessus Bridge for Metasploit [] Type nessus_help for a command listing [*] Successfully loaded plugin: Nessus

    加载nessus成功

4. nessus帮助命令：
    >nessus_help

5. MSF连接上nessus的数据库：
    nessus_connect <用户名>：<密码>@localhost:8834 ok

    [] Connecting to https://localhost:8834/ as root [] User root authenticated successfully.

    nessus在MSF上登录成功，这里需要nessus登录账号和密码

6. 查看nessus设置好的策略,获取policy UUID：
    >nessus_policy_list Policy ID 、Name 、Policy UUID 
    分别对应的是策略ID，策略名，策略代码

7. 创建扫描任务：
    生成Scan ID（任务ID）：nessus_scan_new <策略代码> <任务名> <描述> <目标IP>
    > IP地址之间可以用“,”隔开，也可以扫网段，例如：192.168.1.0/24

8. 执行扫描任务：
    获取任务ID，查看任务状态：>nessus_scan_list执行扫描：>nessus_scan_launch <任务ID>

9. 报告结果：
    获取主机高中低风险分布情况,命令如下：
    >nessus_report_hosts <任务ID>
    获取主机详细的漏洞风险情况,命令如下：
    >nessus_report_vulns <任务ID>

10. 导入postgresql数据库：
    >nessus_db_import <任务ID>

    [  ] Exporting scan ID 47 is Nessus format... [+] The export file ID for scan ID 47 is 312342081 [] Checking export status... [] Export status: loading [] Export status: ready [] The status of scan ID 47 export is ready [] Importing scan results to the database... [*] Importing data of 192.168.101.94 [+] Done

导入数据库成功。


用hosts命令查看Postgresql数据库中的IP地址,命令如下：>hosts

nessus还可以直接扫postgresql数据库中存有的IP地址,命令如下：>nessus_db_scan <策略代码> <任务名> <任务描述>其实跟第七步一样。

感兴趣的朋友可以继续深入了解nessus。

版权声明