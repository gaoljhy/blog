# 安装stage包

## 设置日期和时间

在安装`Gentoo`之前，最好确保日期和时间设置正确。

错误配置的时间可能会导致奇怪的结果：基本系统文件应设置精确的时间戳。

事实上，由于几个网站和服务使用加密通信（`SSL / TLS`），如果系统时间差的离谱，可能无法下载安装文件！

验证当前时间使用命令`date`:

`root #date`
`Mon Oct  3 13:16:22 PDT 2016`

如果显示的日期/时间不正确，请使用下列方法之一进行更新。

## 附注

    不包括实时时钟（RTC）的主板应配置为自动将系统时钟与时间服务器同步
    这也适用于包含RTC但具有故障电池的系统。

## 自动

Gentoo的官方安装光盘包含 `ntpd`命令 (属于包 `net-misc/ntp package`)。
官方光盘包括指向ntp.org时间服务器的配置文件。它可以用于使用时间服务器，使得系统时钟自动同步到UTC时间。使用方法见working network configuration 但在某些架构的光盘上可能不可用。

 警告
自动时间同步需要付出一个代价。它将向时间服务器显示系统的IP地址和相关网络信息（在下面的示例中为ntp.org）。有隐私问题的用户应该注意这个“之前”使用下面的方法设置系统时钟。
root #ntpd -q -g
手册
也可以用date 命令来对系统时钟执行手动设置。使用 MMDDhhmmYYYY 语法 (月, 日, 小时, 分钟 和 年)。

建议所有Linux系统使用UTC时间。 稍后在安装期间将定义时区。 这将修改时钟的显示为本地时间。

比如，设置时间到2016年10月3日的13:16：

root #date 100313162016
选择一个stage包
multilib（32和64位）
选择一个基础压缩包的系统可以在稍后的安装过程节省大量的时间，特别是当它是一次 choose a system profile。一个stage包的选择将直接影响未来的系统配置，可以在以后省的头痛。该压缩包multilib尽可能使用64位的库，只必要时对32位版本兼容。这对于大多数安装一个很好的选择，因为它在未来的定制提供了极大的灵活性量。那些谁希望自己的系统，能够容易地切换配置,应该下载根据各自的处理器架构multilib的压缩包选项。

大多数用户应该不需要使用“高级”tar包选项；它们用于特定的软件或硬件配置。

no-multilib（纯64位）
选择一个no-multilib压缩包:no-multilib是在系统的基础上提供了一个完整的64位操作系统环境。这有效地使得切换到multilib的profile是不可能的(不是完全不可能)。这些刚刚开始使用Gentoo的新手不应该选择一个 no-multilib 压缩包，除非"绝对必要"。而且应该有很好的理由并做出负责任的选择。

 警告
注意，把一个系统从no-multilib迁移到multilib需要极其丰富的使用Gentoo的知识并熟悉底层的工具链。这一做法甚至可能导致Toolchain developers 这令人不寒而栗。不适合内心柔弱之人,而且也超出了本指南的范围。
下载stage压缩包
前往挂载根文件系统的Gentoo挂载点（很像/mnt/gentoo）：

root #cd /mnt/gentoo
根据不同的安装媒介，下载stage压缩包所需的唯一工具是网络浏览器。

图形浏览器
那些使用图形化网页浏览器从主网站下载小节复制stage文件URL也没有问题。 只需选择适当的选项卡，右键单击stage文件的链接，然后复制链接地址（Firefox）或复制链接位置（Chromium）将链接复制到剪贴板，然后 将链接粘贴到命令行中的 wget程序以下载stage tarball：

root #wget <PASTED_STAGE_URL>
命令行浏览器
更传统的读者或是“老前辈”的Gentoo用户，只能命令行工作，可能更喜欢使用非图形化菜单驱动的浏览器 links。 要下载一个stage，请像下面这样访问Gentoo镜像列表：

root #links https://www.gentoo.org/downloads/mirrors/
要设置links使用一个HTTP代理，在传入URL上加一个-http-proxy选项：

root #links -http-proxy proxy.server.com:8080 https://www.gentoo.org/downloads/mirrors/
links之外还有一个lynx浏览器。和links类似，它也是一个非图形化的浏览器，但不是自带的。

root #lynx https://www.gentoo.org/downloads/mirrors/
如果需要定义一个代理，设置http_proxy和/或ftp_proxy变量：

root #export http_proxy="http://proxy.server.com:port"
root #export ftp_proxy="http://proxy.server.com:port"
在镜像列表中，选择一个附近镜像站。通常HTTP镜像站就足够了，但其他网络协议是可用的。请访问releases/x86/autobuilds/ 。 那里将显示所有可用stage文件 （可能他们个别小组架构在命名的子目录中存储）。选择一个，然后按 d 下载。

stage 文件下载完成后，可以验证 stage tarball 的完整性并验证其内容。 有兴趣的人应该进行下一节。

对验证stage文件不感兴趣的用户可以通过按 q 来关闭命令行浏览器，并且可以直接移步到 解压stage压缩包 部分。

验证
 附注
一些 tarballs 是通过XZ压缩的。在下载以 .tar.xz 结尾的 tarball 时，请确保在下面的命令中调整tarball文件名的 .tar.bz2 。
与最小安装CD一样，可以使用额外的下载来验证stage文件。 虽然这些步骤可以被跳过，但这些文件是为那些关心他们刚刚下载的文件合法性的用户提供的。

A .CONTENTS 文件包含stage压缩包内的所有文件的列表。
A .DIGESTS 文件，其中包含用不同的算法校验的stage文件。
A .DIGESTS.asc 像.DIGESTS文件一样, 包含不同的stage文件的校验和，但也加密签名，以确保它是由Gentoo项目提供的。
使用 openssl 并比较,提供的校验输出与.DIGESTS或者.DIGESTS.asc 文件的内容是否一致。

比如，要验证SHA512校验值：

root #openssl dgst -r -sha512 stage3-x86-<release>.tar.?(bz2|xz)
使用sha512sum命令的另外一种方式：

root #sha512sum stage3-x86-<release>.tar.?(bz2|xz)
要验证Whirlpool校验值：

root #openssl dgst -r -whirlpool stage3-x86-<release>.tar.?(bz2|xz)
该值需要匹配，否则下载的文件可能已损坏（或摘要文件）。比较这些命令的输出与.DIGESTS(.asc)中的值。该值需要匹配，否则下载的文件可能已损坏（或digests文件）。

就像在ISO文件中，它也可以来验证加密签名的.DIGESTS.asc。使用 gpg 以确保DIGESTS.asc文件校验和未被篡改:

root #gpg --verify stage3-x86-<release>.tar.?(bz2|xz){.DIGESTS.asc,}
解压stage压缩包
现在，解压下载的stage到系统。我们使用 tar来进行：

root #tar xpvf stage3-*.tar.bz2 --xattrs-include='*.*' --numeric-owner
确保你使用了同样的参数 ( xpf 和 --xattrs-include='*.*')。 x表示解开（Extract），v表示详细信息（Verbose）可以用来查看解压缩时发生了什么（可选参数）， p 表示保留权限（Preserve permissions），还有f 表示我们要解开一个文件，而不是标准输入。最后，--numeric-owner 被用于确保从tarball中提取的文件的用户和组ID与Gentoo发布工程团队预期的保持一致，即使大胆的用户使用的不是Gentoo官方安装媒介。

现在stage文件已经解压好了，下面我们继续 配置编译选项。

配置编译选项
介绍
为了优化Gentoo，可以设置一些影响Portage的变量，Gentoo官方支持包管理器。 所有这些变量可以设置为环境变量（使用export），但这不是永久的。 为了保留设置，Portage读入/etc/portage/make.conf文件 ，一个用于Portage的配置文件。

 附注
所有可能的变量的注释列表可以在 /mnt/gentoo/usr/share/portage/config/make.conf.example中找到。要成功安装Gentoo，只需要设置下面提到的变量。
启动编辑器（在本指南中，我们使用 nano）来更改我们将在下面讨论的优化变量。

root #nano -w /mnt/gentoo/etc/portage/make.conf
从make.conf.example文件中可以明显看出文件的结构：注释行以 "#"开头，其他行使用 VARIABLE="content 语法定义变量。 接下来选取其中的几个进行讨论。

CFLAGS和CXXFLAGS
CFLAGS 和 CXXFLAGS 变量分别定义了GCC C和C ++编译器的优化标志。 尽管这些标志一般在这里默认被定义过，但为了性能最大化，需要分别优化每个程序的这些配置。 原因是因为每个程序都不同。 但是，这是不可管理的，因此这些标志在 make.conf 文件中定义。

应该在make.conf中定义优化标志，这将使系统的响应速度最快。 不要在此变量中放置实验性的设置; 太多的优化可能会使程序表现不佳（崩溃，甚至更糟，故障）。

我们不会解释所有可能的优化选项。 要了解它们，请阅读GNU在线手册或gcc信息页面 (info gcc-只适用于可用的Linux系统)。make.conf.example 文件本身也包含了很多例子和信息; 不要忘了读它。

第一个设置是标志 -march= 和 -mtune= ，指定目标体系结构的名称。 可能用到的选项在make.conf.example文件中有描述（作为注释）。 一个常用的值是“native”，它告诉编译器选择当前系统体系结构（用户正在安装Gentoo时的系统）。

第二个是标志 -O（即大写的字母O，而不是数字零），它指定了gcc优化级别标志。 可能用到级别的是s（对于大小最优化），0（零 - 无优化），1,2或甚至3等更多的优化选项（每个级别具有与前面相同的标志，加上一些额外选项）。 -O2是建议的默认值。 -O3在整个系统范围内使用时会导致问题，因此我们建议您坚持使用-O2。

另一个普遍使用的优化标记是-pipe（不同编译阶段通信使用管道而不是临时文件）。它对产生的代码没有任何影响，但是会使用更多的内存。在内存不多的系统里，gcc可能会被杀掉。如果是那样的话，就不要用这个标记。

使用 -fomit-frame-pointer（它将不在寄存器里为不需要帧指针的函数保存帧指针）可能会在调试程序的时候造成严重后果！

在你定义 CFLAGS和CXXFLAGS的时候，你需要把这些优化标记都合并起来。stage3文件里包含的你解压缩出来的默认值已经足够好了。下面这个例子仅仅是个例子：

CODE Example CFLAGS and CXXFLAGS variables
# Compiler flags to set for all languages
COMMON_FLAGS="-O2 -march=i686 -pipe"
# Use the same settings for both variables
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
 Tip
通过GCC 优化指导这篇文章获取有更多的信息，比如这些优化变量如何影响你的系统，Safe CFLAGS也许是对初学者开始优化系统更实用的一篇文章
MAKEOPTS
通过使用MAKEOPTS 你可以定义在安装软件的时候同时可以产生并行编译的数目。你的CPU数目（CPU核心数）+1 是个不错的选择，但是这个准则并不总都是最佳的。

CODE 在make.conf中声明 MAKEOPTS 的示例
MAKEOPTS="-j2"
就位，预备，出发 ！
根据你的喜好更新并保存/mnt/gentoo/etc/portage/make.conf（nano用户可以敲 Ctrl+X）。