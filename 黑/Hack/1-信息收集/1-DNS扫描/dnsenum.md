## dnsenum 是一款非常强大的域名信息收集工具
它是由参与backtrack开发项目的程序员所设计，设计者名叫Fillp (barbsie) Waeythens ，该名开发者是一个精通web渗透测试的安全人员，并对DNS信息收集有着非常丰富的经验。

> dnsenum的目的是尽可能收集一个域的信息，它能够通过谷歌或者字典文件猜测可能存在的域名，以及对一个网段进行反向查询。

它可以查询网站的主机地址信息、域名服务器、mx record（函件交换记录），在域名服务器上执行axfr请求，通过谷歌脚本得到扩展域名信息（google hacking），提取自域名并查询，计算C类地址并执行whois查询，执行反向查询，把地址段写入文件。


## 参数
```
  --dnsserver     <server>
            Use this DNS server for A, NS and MX queries.

  --enum        Shortcut option equivalent to 
  
  --threads 5 
  -s 15 
  -w.
```


使用 示例
`dnsenum --dnsserver 8.8.8.8 baidu.com`