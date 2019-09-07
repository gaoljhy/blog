# 安装3个虚拟机并实现ssh免密码登录

机器对应关系

```txt
192.168.119.128   master

192.168.119.129   slave1

192.168.119.130   slave2
```

1. 修改机器名称,设置完验证一下

2. 修改`/etc/hosts`文件
   修改这3台机器的/etc/hosts文件，在文件中添加以下内容：

    192.168.119.128   hserver1
    192.168.119.129   hserver2
    192.168.119.130   hserver3
   IP地址只是做一个映射

  检验是否能互相`ping`通
  
  `ping  -c 3  master`

3. 给3个机器生成秘钥文件

   以master为例，执行命令，生成空字符串的秘钥(后面要使用公钥)，命令是：

    `ssh-keygen  -t   rsa   -P  ''`

   秘钥文件保存到了 `/用户家目录/.ssh/` 目录内
   使用同样的方法为hserver2和hserver3生成秘钥(命令完全相同，不用做如何修改)。

4. 在hserver1上创建authorized_keys文件

  1. 在3台机器`.ssh/`目录下都存入一个内容相同的文件，文件名称叫`authorized_keys`,文件内容是刚才为3台机器生成的公钥。
  2. 把3台机器刚才生成的公钥加入到这个`master`的`authorized_keys`文件里
  3. 将这个`authorized_keys`文件复制到其余俩台机子上去

 `touch  /root/.ssh/authorized_keys`

如图：

    

      可以使用命令看，是否生成成功，命令是：

ls   /root/.ssh/

如图：

    

          其次将hserver1上的/root/.ssh/id_rsa.pub文件内容，hserver2上的/root/.ssh/id_rsa.pub文件内容，hserver3上的/root/.ssh/id_rsa.pub文件内容复制到这个authorized_keys文件中，复制的方法很多了，可以用cat命令和vim命令结合来弄，也可以直接把这3台机器上的/root/.ssh/id_rsa.pub文件下载到本地，在本地将authorized_keys文件编辑好在上载到这3台机器上。

hserver1机器上我的/root/.ssh/id_rsa.pub内容是:

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD8fTIVorOxgDo81yCEgcJTstUcyfOBecL+NZ/OLXCEzaBMw5pLV0UNRX6SZnaAgu/erazkz4sw74zfRIMzEeKKCeNcZ6W78cg+ZNxDcj8+FGeYqY5+nc0YPhXFVI7AwFmfr7fH5hoIT14ClKfGklPgpEgUjDth0PeRwnUTvUy9A1x76npjAZrknQsnoLYle7cVJZ/zO3eGxS75YEdTYDMv+UMiwtcJg7UxOqR+9UT3TO+xLk0yOl8GIISXzMhdCZkmyAH+DmW56ejzsd+JWwCMm177DtOZULl7Osq+OGOtpbloj4HCfstpoiG58SM6Nba8WUXWLnbgqZuHPBag/Kqjroot@hserver1
hserver2机器上我的/root/.ssh/id_rsa.pub内容是:

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC29kPkYz4c3bd9Qa1TV8kCR0bUNs4f7/dDcR1NKwrgIiecN7zPEWJpjILtlm3niNNx1j5R49QLTLBKKo8PE8mid47POvNypkVRGDeN2IVCivoAQ1T7S8bTJ4zDECGydFYyKQfS2nOAifAWECdgFFtIp52d+dLIAg1JC37pfER9f32rd7anhTHYKwnLwR/NDVGAw3tMkXOnFuFKUMdOJ3GSoVOZf3QHKykGIC2fz/lsXZHaCcQWvOU/Ecd9e0263Tvqh7zGWpF5WYEGjkLlY8v2sioeZxgzog1LWycUTMTqaO+fSdbvKqVj6W0qdy3Io8bJ29Q3S/6MxLa6xvFcBJEXroot@hserver2
hserver2机器上我的/root/.ssh/id_rsa.pub内容是:

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1a2o10ttv2570GpuUZy7g9o7lIkkeed7ba25VvFEBcUroQIZ+NIAiVIMGPRiOqm7X4bTLWj5EOz5JXG2l8rwA6CFnWfW3U+ttD1COLOrv2tHTiJ1PhQy1jJR/LpC1iX3sNIDDs+I0txZFGTCTRMLmrbHVTl8j5Yy/CTYLuC7reIZjzpHP7aaS2ev0dlbQzeB08ncjA5Jh4X72qQMOGPUUc2C9oa/CeCvI0SJbt8mkHwqFanZz/IfhLJIKhupjtYsqwQMmzLIjHxbLRwUGoWU6X4e76OkUz/xyyHlzBg1Vu2F9hjoXPW80VmupIRSXFDliDBJ8NlXXQN47wwYBG28broot@hserver3
合并之后，我的hserver1机器上的/root/.ssh/authorized_keys文件内容是：

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD8fTIVorOxgDo81yCEgcJTstUcyfOBecL+NZ/OLXCEzaBMw5pLV0UNRX6SZnaAgu/erazkz4sw74zfRIMzEeKKCeNcZ6W78cg+ZNxDcj8+FGeYqY5+nc0YPhXFVI7AwFmfr7fH5hoIT14ClKfGklPgpEgUjDth0PeRwnUTvUy9A1x76npjAZrknQsnoLYle7cVJZ/zO3eGxS75YEdTYDMv+UMiwtcJg7UxOqR+9UT3TO+xLk0yOl8GIISXzMhdCZkmyAH+DmW56ejzsd+JWwCMm177DtOZULl7Osq+OGOtpbloj4HCfstpoiG58SM6Nba8WUXWLnbgqZuHPBag/Kqjroot@hserver1
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC29kPkYz4c3bd9Qa1TV8kCR0bUNs4f7/dDcR1NKwrgIiecN7zPEWJpjILtlm3niNNx1j5R49QLTLBKKo8PE8mid47POvNypkVRGDeN2IVCivoAQ1T7S8bTJ4zDECGydFYyKQfS2nOAifAWECdgFFtIp52d+dLIAg1JC37pfER9f32rd7anhTHYKwnLwR/NDVGAw3tMkXOnFuFKUMdOJ3GSoVOZf3QHKykGIC2fz/lsXZHaCcQWvOU/Ecd9e0263Tvqh7zGWpF5WYEGjkLlY8v2sioeZxgzog1LWycUTMTqaO+fSdbvKqVj6W0qdy3Io8bJ29Q3S/6MxLa6xvFcBJEXroot@hserver2
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1a2o10ttv2570GpuUZy7g9o7lIkkeed7ba25VvFEBcUroQIZ+NIAiVIMGPRiOqm7X4bTLWj5EOz5JXG2l8rwA6CFnWfW3U+ttD1COLOrv2tHTiJ1PhQy1jJR/LpC1iX3sNIDDs+I0txZFGTCTRMLmrbHVTl8j5Yy/CTYLuC7reIZjzpHP7aaS2ev0dlbQzeB08ncjA5Jh4X72qQMOGPUUc2C9oa/CeCvI0SJbt8mkHwqFanZz/IfhLJIKhupjtYsqwQMmzLIjHxbLRwUGoWU6X4e76OkUz/xyyHlzBg1Vu2F9hjoXPW80VmupIRSXFDliDBJ8NlXXQN47wwYBG28broot@hserver3
如图：

    

2.6将authorized_keys文件复制到其他机器
        hserver1机器的/root/.ssh/目录下已经有authorized_keys这个文件了，该文件的内容也已经OK了，接下来要将该文件复制到hserver2的/root/.ssh/和hserver3的/root/.ssh/。

       复制的方法有很多，最简单的就是用SecureFX可视化工具操作吧。

       复制完成后，可以看到三台机器的/root/.ssh目录下都有了这样的文件

       如图：

       

        上图已经说得很清楚了，三台机器的/root/.ssh都有同名的文件，但是只有authorized_keys文件的内容是相同的。

2.7测试使用ssh进行无密码登录

2.7.1在hserver1上进行测试
       输入命令：

ssh   hserver2

如图：

  

 输入命令：

 exit回车

如图：

   


输入命令：

ssh   hserver3

如图：

   


输入命令：

 exit回车

如图：

    


2.7.2 在hserver2上进行测试
        方法类似2.7.1，只不过命令变成了ssh  hserver1和ssh  hserver3，但是一定要注意的是，每次ssh完成后，都要执行exit，否则你的后续命令是在另外一台机器上执行的。

2.7.3 在hserver3上进行测试
      方法类似2.7.1，只不过命令变成了ssh  hserver1和ssh  hserver2，但是一定要注意的是，每次ssh完成后，都要执行exit，否则你的后续命令是在另外一台机器上执行的。

原文：https://blog.csdn.net/pucao_cug/article/details/71698903 
