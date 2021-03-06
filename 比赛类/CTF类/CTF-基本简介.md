# CTF 比赛模式

### 1、解题模式：

 > 在解题模式 `CTF`  赛制中，参赛队伍可以通过 **互联网** 或者 **现场网络** 参与
 通过解决 网络安全技术挑战题目 的分值和时间来排名
 通常用于在线选拔赛
 
 题目主要包含`逆向、漏洞挖掘与利用、Web渗透、密码、取证、隐写、安全编程等`类别

 ###  2、攻防模式（Attack-Defense）：

> 在攻防模式`CTF`赛制中，参赛队伍在 **网络空间** 互相进行**攻击和防守** **挖掘网络服务漏洞** 
**攻击对手服务**来得分，**修补自身服务漏洞进行防御**来避免丢分。

攻防模式 `CTF` 赛制 可以实时 通过得分反映出比赛情况，最终也以得分直接分出胜负，是一种竞争激烈，具有很强 观赏性 和高度 透明性 的网络安全赛制。
>在这种赛制中，不仅仅是比参赛队员的 智力和技术，也比体力（因为比赛一般都会持续48小时及以上），同时也比团队之间的分工配合与合作。

### 3、混合模式（mix）：

结合了 **解题模式** 与 **攻防模式** 的`CTF`赛制，比如 参赛队伍通过 解题可以获取一些 初始分数，然后通过 攻防对抗 进行 得分增减 的 零和游戏，最终以 得分高低分出胜负。
> 采用 混合模式 CTF 赛制的 典型代表 如 iCTF国际CTF竞赛。


## WEB（网络安全）：

`WEB`是`CTF`竞赛的主要题型，题目涉及到许多常见的`WEB漏洞`，诸如`XSS`、`文件包含`、`代码执行`、`上传漏洞`、`SQL注入`。
也有一些简单的关于网络基础知识的考察
>例如: `返回包`、`TCP-IP`、`数据包内容`和`构造`。可以说题目环境比较接近真实环境。



- 所需知识：`PHP`、`python`、`TCP-IP`、`SQL`



## MISC（安全杂项）：

`MISC`即 **安全杂项**
题目涉及`隐写术`、`流量分析`、`电子取证`、`人肉搜索`、`数据分析`、`大数据统计`等等

覆盖面比较广，主要考查参赛选手的各种基础综合知识。



- 所需知识：常见**隐写术工具**、`wireshark`等**流量审查工具**、**编码知识**。

## Crypto（密码学）：

题目考察各种**加解密技术**
包括 `古典加密`技术、`现代加密`技术
甚至出题者 **自创加密**技术，以及一些常见`编码解码`，主要考查参赛选手密码学相关知识点。

通常也会和其他题目相结合。



- 所需知识：`矩阵`、`数论`、`古典密码学`



## Reverse（逆向工程）：

 题目涉及到`软件逆向`、`破解技术`等
 要求有较强的`反汇编`、`反编译`扎实功底。
 >主要考查参赛选手的逆向分析能力。

- 所需知识：`汇编语言`、`加密与解密`、常见`反编译工具`

## PPC（编程类题目）：

题目涉及到`程序编写`、`编程算法实现`，当然`PPC`相比`ACM`来说，还是较为容易的。

至于编程语言嘛，推荐使用`Python`来尝试。

题目较少，一般与其他类型相结合。



- 所需知识：基本编程思路、`C`,`C++`,`Python`,`php`皆可。

## PWN（二进制安全）：

PWN在 黑客俚语中代表着`攻破`，`取得权限`
在`CTF`比赛中它代表着`溢出类`的题目，其中常见类型溢出漏洞有`栈溢出`、`堆溢出`。

>主要考察参数选手对漏洞的利用能力。

- 所需知识：`C`，`OD+IDA`，`数据结构`，`操作系统`。


# 国内外的赛事

### 国外：

- DEFCON CTF：CTF赛事中的“世界杯”


- UCSB iCTF：来自UCSB的面向世界高校的CTF


- Plaid CTF：包揽多项赛事冠军的CMU的PPP团队举办的在线解题赛


- Boston Key Party：近年来崛起的在线解题赛


- Codegate CTF：韩国首尔“大奖赛”，冠军奖金3000万韩元


- Secuinside CTF：韩国首尔“大奖赛”，冠军奖金3000万韩元


- XXC3 CTF：欧洲历史最悠久CCC黑客大会举办的CTF


- SIGINT CTF：德国CCCAC协会另一场解题模式竞赛


- Hack.lu CTF：卢森堡黑客会议同期举办的CTF


- EBCTF：荷兰老牌强队Eindbazen组织的在线解题赛


- Ghost in the Shellcode：由Marauders和Men
in Black Hats共同组织的在线解题赛


- RwthCTF：由德国0ldEur0pe组织的在线攻防赛


- RuCTF：由俄罗斯Hackerdom组织，解题模式资格赛面向全球参赛，解题攻防混合模式的决赛面向俄罗斯队伍的国家级竞赛[2] 


- RuCTFe：由俄罗斯Hackerdom组织面向全球参赛队伍的在线攻防赛


- PHD CTF：俄罗斯Positive Hacking Day会议同期举办的CTF

### 国内： 

- XCTF全国联赛

> 中国网络空间安全协会竞评演练工作组主办、南京赛宁承办的全国性网络安全赛事平台，2014-2015赛季五站选拔赛分别由清华、上交、浙大、杭电和成信技术团队组织（包括杭电HCTF、成信SCTF、清华BCTF、上交0CTF和浙大ACTF），XCTF联赛总决赛由蓝莲花战队组织。XCTF联赛是国内最权威、最高技术水平与最大影响力的网络安全CTF赛事平台。

- AliCTF

> 由阿里巴巴公司组织，面向在校学生的CTF竞赛，冠军奖金10万元加BlackHat全程费用。

- XDCTF

> 由西安电子科技大学信息安全协会组织的CTF竞赛，其特点是偏向于渗透实战经验。

- HCTF

> 由杭州电子科技大学信息安全协会承办组织的CTF
>>杭州电子科技大学信息安全协会由杭州电子科技大学通信工程学院组织建立，协会已有七年历史，曾经出征DEFCON,BCTF等大型比赛并取得优异成绩，同时协会还有大量有影响力的软件作品。协会内部成员由热爱黑客技术和计算机技术的一些在校大学生组成，有多个研究方向，主要有渗透，逆向，内核，web等多个研究方向。至今已经成功举办6次CTF比赛。

- ISCC

> 由北理工组织的传统网络安全竞赛，最近两年逐渐转向CTF赛制。

- TCTF

> TCTF由中国网络空间安全协会竞评演练工作委员会指导、腾讯安全发起、腾讯安全联合实验室主办，0ops战队和北京邮电大学协办的CTF竞赛.
