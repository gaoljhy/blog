## dnsmap功能
> dnsmap - DNS域名蛮力穷举工具
> 只能用来，在一个网站域名 前面加前坠，查询子域名

`root@kali:~# dnsmap`

> dnsmap 0.30 - DNS Network Mapper by pagvac (gnucitizen.org)

用法: dnsmap <目标域> [选项]
## 选项:
```
-w <指定字典文件>
-r <指定结果以常规格式输出文件>
-c <指定结果以csv格式输出文件>
-d <设置延迟(毫秒)>
-i <忽略的IP> (当你遇到一个虚假的IP地址时很有用)
```

## 示例:
```
dnsmap target-domain.com
dnsmap target-domain.com -w yourwordlist.txt -r /tmp/domainbf_results.txt
dnsmap target-fomain.com -r /tmp/ -d 3000
dnsmap target-fomain.com -r ./domainbf_results.txt
```


## dnsmap用法示例

`dnsmap xxx.ccom`

` dnsmap xxx.com -w /usr/share/wordlists/dnsmap.txt -r domain.txt `

> 默认在 `/usr/share/wordlist/` 中存在一个
