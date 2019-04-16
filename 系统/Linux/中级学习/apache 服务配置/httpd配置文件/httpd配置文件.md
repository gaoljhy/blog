# httpd 配置文件

## 标签内选项

1. Options：控制在特定目录中将使用哪些服务器特性

    语法：`Options [+|-]option [[+|-]option] ...`

    `option`可以为`None`，不启用任何额外特性，或者下面选项中的一个或多个：

    `All` 　除MultiViews之外的所有特性，这是默认设置。

    `ExecCGI` 　允许使用mod_cgi执行CGI脚本。

    `FollowSymLinks` 　服务器允许在此目录中使用符号连接，如果此配置位于`<Location>`配置段中，则会被忽略。

2. `Includes` 　允许使用`mod_include`提供的服务器端包含。

    `IncludesNOEXEC` 　允许服务器端包含，但禁用`#exec cmd`和`#exec cgi`，但仍可以从`ScriptAlias`目录使用`#include virtual`虚拟CGI脚本。

3. `Indexes` 　如果一个映射到目录的URL被请求，而此目录中又没有`DirectoryIndex`
    例如：`index.html`，那么服务器会返回由`mod_autoindex`生成的一个格式化后的目录列表。

4. `MultiViews`
   允许使用`mod_negotiation`提供内容协商的`多重视图`
   MultiViews

5. `SymLinksIfOwnerMatch`
   服务器仅在符号连接与其目的目录或文件的拥有者具有相同的uid时才使用它
   如果此配置出现在`<Location>`配置段中，则将被忽略。

一般来说，如果一个目录被多次设置了`Options`，则最特殊的一个会被完全接受(其它的被忽略)
而各个可选项的设定彼此并不融合。
然而，如果所有作用于`Options`指令的可选项

前都加有"+" 或"-"符号，此可选项将被合并。所有前面加有"+"号的可选项将强制覆盖当前的可选项设置，而所有前面有"-"号的可选项将强制从当前可选项设置中去除。

1.  AllowOverride：确定允许存在于.htaccess文件中的指令类型。

语法：AllowOverride All|None|directive-type [directive-type] ...

如果此指令被设置为None ，那么.htaccess文件将被完全忽略。事实上，服务器根本不会读取.htaccess文件。

当此指令设置为All时，所有具有".htaccess"作用域的指令都允许出现在.htaccess文件中。

directive-type可以是下列各组指令之一：

AuthConfig 　允许使用与认证授权相关的指令

FileInfo 　允许使用控制文档类型的指令、控制文档元数据的指令、mod_rewrite中的指令、mod_actions中的Action指令

Indexes 　允许使用控制目录索引的指令

Limit 　允许使用控制主机访问的指令

Options[=Option,...] 　允许使用控制指定目录功能的指令(Options和XBitHack)。可以在等号后面附加一个逗号分隔的(无空格的)Options选项列表，用来控制允许Options指令

使用哪些选项。

AllowOverride仅在不包含正则表达式的<Directory>配置段中才是有效的。在<Location>, <DirectoryMatch>, <Files>配置段中都是无效的。

Order：控制默认的访问状态与Allow和Deny指令生效的顺序。

Ordering取值范围是以下几种范例之一：

Deny,Allow 　Deny指令在Allow指令之前被评估。默认允许所有访问。任何不匹配Deny指令或者匹配Allow指令的客户都被允许访问。

Allow,Deny 　Allow指令在Deny指令之前被评估。默认拒绝所有访问。任何不匹配Allow指令或者匹配Deny指令的客户都将被禁止访问。

Mutual-failure 　只有出现在Allow列表并且不出现在Deny列表中的主机才被允许访问。这种顺序与"Order Allow,Deny"具有同样效果，不赞成使用。

关键字只能用逗号分隔，它们之间不能有空格，在所有情况下每个Allow和Deny指令语句都将被评估。

Allow：控制哪些主机可以访问服务器的该区域。可以根据主机名、IP地址、 IP地址范围或其他环境变量中捕获的客户端请求特性进行控制。

语法：Allow from all|host|env=env-variable [host|env=env-variable] ...

这个指令的第一个参数总是"from"，随后的参数可以有三种不同形式：如果指定"Allow from all"，则允许所有主机访问，按照下述Deny和Order指令的配置；若要只允许特定的主

机或主机群访问服务器，host可以用下面任何一种格式来指定：一个（部分）域名、完整的IP地址、部分IP地址、网络/掩码、网络/nnn无类别域间路由规格；第三种参数格式允许

对服务器的访问由环境变量的一个扩展指定，指定"Allow from env=env-variable"时，如果环境变量env-variable存在则访问被允许，使用由mod_setenvif提供的指令，服务器用

一种基于客户端请求的弹性方式提供了设置环境变量的能力。因此，这条指令可以用于允许基于像User-Agent(浏览器类型)、Referer或其他 HTTP请求头字段的访问。

Deny：控制哪些主机被禁止访问服务器的该区域。可以根据主机名、IP地址、 IP地址范围或其他环境变量中捕获的客户端请求特性进行控制。

语法：Deny from all|host|env=env-variable [host|env=env-variable] ...

此指令的参数设置和Allow指令完全相同。

14. DirectoryIndex：当客户端请求一个目录时寻找的资源列表。

语法：DirectoryIndex Local-url [Local-url] ...

Local-url(%已解码的)是一个相对于被请求目录的文档的URL(通常是那个目录中的一个文件)。可以指定多个URL，服务器将返回最先找到的那一个，比如：

DirectoryIndex index.html index.php



20. Alias：映射URL到文件系统的特定区域。

语法：Alias URL-path file-path|directory-path

Alias指令使文档可以被存储在DocumentRoot以外的本地文件系统中。以(%已解码的)url-path路径开头的URL可以被映射到以directory-path开头的本地文件。

如果对在DocumentRoot之外的某个目录建立了一个Alias ，则可能需要通过<Directory>段明确的对目标目录设定访问权限。

21.ScriptAlias：映射一个URL到文件系统并视之为CGI脚本目录。

语法：ScriptAlias URL-path file-path|directory-path

ScriptAlias指令的行为与Alias指令相同，但同时它又标明此目录中含有应该由cgi-script处理器处理的CGI脚本。以URL-path开头的(%已解码的)的URL会被映射到由第二个参数指

定的具有完整路径名的本地文件系统中的脚本。

ScriptSock：在以线程式MPM(worker)运行的Apache中设置用来与CGI守护进程通信的套接字文件名前缀(其后附加父进程 PID组成完整的文件名)。这个套接字将会用启动Apache服

务器的父进程用户权限(通常是root)打开。为了维护与CGI脚本通讯的安全性，不允许其他用户拥有写入套接字所在目录的权限是很重要的。

22. DefaultType：在服务器无法由其他方法确定内容类型时，发送的默认MIME内容类型。

语法：DefaultType MIME-type

默认：DefaultType text/plain

23. AddType：在给定的文件扩展名与特定的内容类型之间建立映射关系。

语法：AddType MIME-type extension [extension] ...

MIME-type指明了包含extension扩展名的文件的媒体类型。这个映射关系会添加在所有有效的映射关系上，并覆盖所有相同的extension扩展名映射。

extension参数是不区分大小的，并且可以带或不带前导点。

24. ErrorDocument：批示当遇到错误的时候服务器将给客户端什么样的应答。

语法：ErrorDocument error-code document

error-code 　服务器返回的错误代码

document 　可以由一个斜杠(/)开头来指示一个本地URL(相对于DocumentRoot)，或是提供一个能被客户端解释的完整的URL。此外还能提供一个可以被浏览器显示的消息。比如：

ErrorDocument 500http://www.entage.net/err500.html

ErrorDocument 404 /errors/bad_urls.html

ErrorDocument 403 "Sorry can't allow you access today"

25. EnableMMAP：指示httpd在递送中如果需要读取一个文件的内容，它是否可以使用内存映射。

语法：EnableMMAP On|Off

当处理一个需要访问文件中的数据的请求时，比如说当递送一个使用mod_include进行服务器端分析的文件时，如果操作系统支持，Apache将默认使用内存映射。

这种内存映射有时会带来性能的提高，但在某些情况下，您可能会需要禁用内存映射以避免一些操作系统的问题：

在一些多处理器的系统上，内存映射会减低一些httpd的性能；

在挂载了NFS的DocumentRoot上，若已经将一个文件进行了内存映射，则删除或截断这个文件会造成httpd因为分段故障而崩溃。

在可能遇到这些问题的服务器配置过程中，应当使用下面的命令来禁用内存映射：

26. EnableMMAP Off

对于挂载了NFS的文件夹，可以单独在<directory>段中指定禁用内存映射：

<Directory "/path-to-nfs-files">
EnableMMAP Off
</Directory>

27. EnableSendfile：控制httpd是否可以使用操作系统内核的sendfile支持来将文件发送到客户端。

默认情况下，当处理一个请求并不需要访问文件内部的数据时(比如发送一个静态的文件内容)，如果操作系统支持，Apache将使用sendfile将文件内容直接发送到客户端而并不读

取文件。

这个sendfile机制避免了分开的读和写操作以及缓冲区分配，但是在一些平台或者一些文件系统上，最好禁止这个特性来避免一些问题：

一些平台可能会有编译系统检测不到的有缺陷的sendfile支持，特别是将在其他平台上使用交叉编译得到的二进制文件运行于当前对sendfile支持有缺陷的平台时；

在Linux上启用IPv6时，使用sendfile将会触发某些网卡上的TCP校验和卸载bug；

当Linux运行在Itanium处理器上的时候，sendfile可能无法处理大于2GB的文件；

对于一个通过网络挂载了NFS文件系统的DocumentRoot (比如：NFS或SMB)，内核可能无法可靠的通过自己的缓冲区服务于网络文件。

如果出现以上情况，你应当禁用sendfile ：

EnableSendfile Off

针对NFS或SMB，可以单独在<directory>段中指定禁用：

<Directory "/path-to-nfs-files">
EnableSendfile Off
</Directory>

28. include：在服务器配置文件中包含其它配置文件。

语法：Include file-path|directory-path

Shell风格(fnmatch())的通配符可以用于按照字母顺序一次包含多个文件。另外，如果Include指向了一个目录而不是一个文件，Apache将读入该目录及其子目录下的所有文件，并

依照字母顺序将这些文件作为配置文件进行解析。但是并不推荐这么做，因为偶尔会有临时文件在这个目录中生成，从而导致httpd启动失败。

文件的路径可以是一个完整的绝对路径(以一个斜杠开头)，或是相对于ServerRoot目录的相对路径。

 

29. 设置动态加载的DSO模块

#如果需要提供基于文本文件的认证,加载此模块，否则注释掉

LoadModule authn_file_module modules/mod_authn_file.so

#如果需要提供基于DBM文件的认证,加载此模块,否则注释掉

#LoadModule authn_dbm_module modules/mod_authn_dbm.so

#如果需要提供匿名用户认证,加载此模块,否则注释掉

#LoadModule authn_anon_module modules/mod_authn_anon.so

#如果需要提供基于SQL数据库的认证,加载此模块,否则注释掉

#LoadModule authn_dbd_module modules/mod_authn_dbd.so

#如果需要在未正确配置认证模块的情况下简单拒绝一切认证信息,加载此模块,否则注释掉

LoadModule authn_default_module modules/mod_authn_default.so

#此模块提供基于主机名、IP地址、请求特征的访问控制,Allow、Deny指令需要,推荐加载。

LoadModule authz_host_module modules/mod_authz_host.so

#如果需要使用纯文本文件为组提供授权支持,加载此模块,否则注释掉

#LoadModule authz_groupfile_module modules/mod_authz_groupfile.so

#如果需要提供基于每个用户的授权支持,加载此模块,否则注释掉

LoadModule authz_user_module modules/mod_authz_user.so

#如果需要使用DBM文件为组提供授权支持,加载此模块,否则注释掉

#LoadModule authz_dbm_module modules/mod_authz_dbm.so

#如果需要基于文件的所有者进行授权,加载此模块,否则注释掉

#LoadModule authz_owner_module modules/mod_authz_owner.so

#如果需要在未正确配置授权支持模块的情况下简单拒绝一切授权请求,加载此模块,否则注释掉

LoadModule authz_default_module modules/mod_authz_default.so

#如果需要提供基本的HTTP认证,加载此模块,否则注释掉,此模块至少需要同时加载一个认证支持模块和一个授权支持模块

LoadModule auth_basic_module modules/mod_auth_basic.so

##如果需要提供HTTP MD5摘要认证,加载此模块,否则注释掉,此模块至少需要同时加载一个认证支持模块和一个授权支持模块

#LoadModule auth_digest_module modules/mod_auth_digest.so

#此模块提供文件描述符缓存支持,从而提高Apache性能,推荐加载,但请小心使用

LoadModule file_cache_module modules/mod_file_cache.so

#此模块提供基于URI键的内容动态缓存(内存或磁盘),从而提高Apache性能,必须与mod_disk_cache/mod_mem_cache同时使用,推荐加载

LoadModule cache_module modules/mod_cache.so

#此模块为mod_cache提供基于磁盘的缓存管理,推荐加载

LoadModule disk_cache_module modules/mod_disk_cache.so

#此模块为mod_cache提供基于内存的缓存管理,推荐加载

LoadModule mem_cache_module modules/mod_mem_cache.so

#如果需要管理SQL数据库连接，为需要数据库功能的模块提供支持,加载此模块,否则注释掉(推荐)

#LoadModule dbd_module modules/mod_dbd.so

#此模块将所有I/O操作转储到错误日志中,会导致在日志中写入及其海量的数据,只建议在发现问题并进行调试的时候使用

#LoadModule dumpio_module modules/mod_dumpio.so

#如果需要使用外部程序作为过滤器,加载此模块(不推荐),否则注释掉

#LoadModule ext_filter_module modules/mod_ext_filter.so

#如果需要实现服务端包含文档(SSI)处理,加载此模块(不推荐),否则注释掉

#LoadModule include_module modules/mod_include.so

#如果需要根据上下文实际情况对输出过滤器进行动态配置,加载此模块,否则注释掉

LoadModule filter_module modules/mod_filter.so

#如果需要服务器在将输出内容发送到客户端以前进行压缩以节约带宽,加载此模块(推荐),否则注释掉

LoadModule deflate_module modules/mod_deflate.so

##如果需要记录日志和定制日志文件格式,加载此模块(推荐),否则注释掉

LoadModule log_config_module modules/mod_log_config.so

#如果需要对每个请求的输入/输出字节数以及HTTP头进行日志记录,加载此模块,否则注释掉

#LoadModule logio_module modules/mod_logio.so

#如果允许Apache修改或清除传送到CGI脚本和SSI页面的环境变量,加载此模块,否则注释掉

LoadModule env_module modules/mod_env.so

#如果允许通过配置文件控制HTTP的"Expires:"和"Cache-Control:"头内容,加载此模块(推荐),否则注释掉

LoadModule expires_module modules/mod_expires.so

#如果允许通过配置文件控制任意的HTTP请求和应答头信息,加载此模块,否则注释掉

LoadModule headers_module modules/mod_headers.so

#如果需要实现RFC1413规定的ident查找,加载此模块(不推荐),否则注释掉

#LoadModule ident_module modules/mod_ident.so

#如果需要根据客户端请求头字段设置环境变量,加载此模块,否则注释掉

LoadModule setenvif_module modules/mod_setenvif.so

#此模块是mod_proxy的扩展,提供Apache JServ Protocol支持,只在必要时加载

#LoadModule proxy_ajp_module modules/mod_proxy_ajp.so

#此模块是mod_proxy的扩展,提供负载均衡支持,只在必要时加载

#LoadModule proxy_balancer_module modules/mod_proxy_balancer.so

#如果需要根据文件扩展名决定应答的行为(处理器/过滤器)和内容(MIME类型/语言/字符集/编码),加载此模块,否则注释掉

LoadModule mime_module modules/mod_mime.so

#如果允许Apache提供DAV协议支持,加载此模块,否则注释掉

#LoadModule dav_module modules/mod_dav.so

#此模块生成描述服务器状态的Web页面,只建议在追踪服务器性能和问题时加载

#LoadModule status_module modules/mod_status.so

#如果需要自动对目录中的内容生成列表(类似于"ls"或"dir"命令),加载此模块(会带来安全问题,不推荐),否则注释掉

#LoadModule autoindex_module modules/mod_autoindex.so

#如果需要服务器发送自己包含HTTP头内容的文件,加载此模块,否则注释掉

#LoadModule asis_module modules/mod_asis.so

#如果需要生成Apache配置情况的Web页面,加载此模块(会带来安全问题,不推荐),否则注释掉

#LoadModule info_module modules/mod_info.so

#如果需要在非线程型MPM(prefork)上提供对CGI脚本执行的支持,加载此模块,否则注释掉

#LoadModule cgi_module modules/mod_cgi.so

#此模块在线程型MPM(worker)上用一个外部CGI守护进程执行CGI脚本,如果正在多线程模式下使用CGI程序,推荐替换mod_cgi加载,否则注释掉

#LoadModule cgid_module modules/mod_cgid.so

#此模块为mod_dav访问服务器上的文件系统提供支持,如果加载mod_dav,则也应加载此模块,否则注释掉

#LoadModule dav_fs_module modules/mod_dav_fs.so

#如果需要提供大批量虚拟主机的动态配置支持,加载此模块,否则注释掉

#LoadModule vhost_alias_module modules/mod_vhost_alias.so

#如果需要提供内容协商支持(从几个有效文档中选择一个最匹配客户端要求的文档),加载此模块(推荐),否则注释掉

LoadModule negotiation_module modules/mod_negotiation.so

#如果需要指定目录索引文件以及为目录提供"尾斜杠"重定向,加载此模块(推荐),否则注释掉

LoadModule dir_module modules/mod_dir.so

#如果需要处理服务器端图像映射,加载此模块,否则注释掉

#LoadModule imagemap_module modules/mod_imagemap.so

#如果需要针对特定的媒体类型或请求方法执行CGI脚本,加载此模块,否则注释掉

#LoadModule actions_module modules/mod_actions.so

#如果希望服务器自动纠正URL中的拼写错误,加载此模块(推荐),否则注释掉

LoadModule speling_module modules/mod_speling.so

#如果允许在URL中通过"/~username"形式从用户自己的主目录中提供页面,加载此模块,否则注释掉

#LoadModule userdir_module modules/mod_userdir.so

#此模块提供从文件系统的不同部分到文档树的映射和URL重定向,推荐加载

LoadModule alias_module modules/mod_alias.so

#如果需要基于一定规则实时重写URL请求,加载此模块(推荐),否则注释掉

LoadModule rewrite_module modules/mod_rewrite.so

DocumentRoot "/usr/local/apache-2.2.6/htdocs"

#设置WEB文档根目录的默认属性

<Directory />

    Options FollowSymLinks

    AllowOverride None

    Order deny,allow

    Deny from all

</Directory>

#设置DocumentRoot指定目录的属性

<Directory "/usr/local/apache-2.2.6/htdocs">

    Options FollowSymLinks

    AllowOverride None

    Order allow,deny

    Allow from all

</Directory>

#设置默认目录资源列表文件

<IfModule dir_module>

    DirectoryIndex index.html

</IfModule>

#拒绝对.ht开头文件的访问,以保护.htaccess文件

<FilesMatch "^\.ht">

    Order allow,deny

    Deny from all

    Satisfy All

</FilesMatch>


<IfModule log_config_module>

#定义访问日志的格式

    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined

    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>

      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio

    </IfModule>

#指定访问日志及使用的格式

    CustomLog logs/access_log combined

</IfModule>

#设定默认CGI脚本目录及别名

ScriptAlias /cgi-bin/ "/usr/local/apache-2.2.6/cgi-bin/"


#在以线程式MPM(worker)运行的Apache中设置用来与CGI守护进程通信的套接字文件名前缀

<IfModule cgid_module>

    Scriptsock logs/cgisock

</IfModule>

#设定默认CGI脚本目录的属性

<Directory "/usr/local/apache-2.2.6/cgi-bin">

    AllowOverride None

    Options None

    Order allow,deny

    Allow from all

</Directory>

#设定默认MIME内容类型

DefaultType text/plain

<IfModule mime_module>

##指定MIME类型映射文件

    TypesConfig conf/mime.types

#增加.Z .tgz的类型映射

    AddType application/x-compress .Z

    AddType application/x-gzip .gz .tgz

</IfModule>

#启用内存映射

EnableMMAP on

##使用操作系统内核的sendfile支持来将文件发送到客户端

EnableSendfile on

#指定多路处理模块(MPM)配置文件并将其附加到主配置文件

Include conf/extra/httpd-mpm.conf

#指定多语言错误应答配置文件并将其附加到主配置文件

Include conf/extra/httpd-multilang-errordoc.conf

#指定目录列表配置文件并将其附加到主配置文件

#Include conf/extra/httpd-autoindex.conf

#指定语言配置文件并将其附加到主配置文件

Include conf/extra/httpd-languages.conf

#指定用户主目录配置文件并将其附加到主配置文件

#Include conf/extra/httpd-userdir.conf

#指定用于服务器信息和状态显示的配置文件并将其附加到主配置文件

#Include conf/extra/httpd-info.conf

#指定提供Apache文档访问的配置文件并将其附加到配置文件

#Include conf/extra/httpd-manual.conf

#指定DAV配置文件并将其附加到主配置文件

#Include conf/extra/httpd-dav.conf

#指定与Apache服务自身相关的配置文件并将其附加到主配置文件

Include conf/extra/httpd-default.conf

#指定mod_deflate压缩模块配置文件并将其附加到主配置文件

Include conf/extra/httpd-deflate.conf

#指定mod_expires模块配置文件并将其附加到主配置文件

Include conf/extra/httpd-expires.conf

##指定虚拟主机配置文件并将其附加到主配置文件

#Include conf/extra/httpd-vhosts.conf

#指定SSL配置文件并将其附加到主配置文件

Include conf/extra/httpd-ssl.conf

##SSL默认配置

<IfModule ssl_module>

SSLRandomSeed startup builtin

SSLRandomSeed connect builtin

</IfModule>

 

#配置多路处理模块(MPM) httpd-mpm.conf

首先说一下原理:

prefork模式
这个多路处理模块(MPM)实现了一个非线程型的、预派生的web服务器，它的工作方式类似于Apache 1.3。它适合于没有线程安全库，需要避免线程兼容性问题的系统。它是要求将

每个请求相互独立的情况下最好的MPM，这样若一个请求出现问题就不会影响到其他请求。

这个MPM具有很强的自我调节能力，只需要很少的配置指令调整。最重要的是将MaxClients设置为一个足够大的数值以处理潜在的请求高峰，同时又不能太大，以致需要使用的内存

超出物理内存的大小。

worker模式
此多路处理模块(MPM)使网络服务器支持混合的多线程多进程。由于使用线程来处理请求，所以可以处理海量请求，而系统资源的开销小于基于进程的MPM。但是，它也使用了多进

程，每个进程又有多个线程，以获得基于进程的MPM的稳定性。

控制这个MPM的最重要的指令是，控制每个子进程允许建立的线程数的ThreadsPerChild指令，和控制允许建立的总线程数的MaxClients指令


#设置prefork多路处理模块

<IfModule mpm_prefork_module>

    StartServers          5

    MinSpareServers       5

    MaxSpareServers      10

    ServerLimit　　　　8000

    MaxClients         8000

    MaxRequestsPerChild   0

</IfModule>

StartServers：设置服务器启动时建立的子进程数量。因为子进程数量动态的取决于负载的轻重,所有一般没有必要调整这个参数。

MinSpareServers：设置空闲子进程的最小数量。所谓空闲子进程是指没有正在处理请求的子进程。如果当前空闲子进程数少于 MinSpareServers ,那么Apache将以最大每秒一个的

速度产生新的子进程。只有在非常繁忙机器上才需要调整这个参数。将此参数设的太大通常是一个坏主意。

MaxSpareServers：设置空闲子进程的最大数量。如果当前有超过MaxSpareServers数量的空闲子进程,那么父进程将杀死多余的子进程。只有在非常繁忙机器上才需要调整这个参数

。将此参数设的太大通常是一个坏主意。如果你将该指令的值设置为比MinSpareServers 小,Apache将会自动将其修改成"MinSpareServers+1"。

ServerLimit：服务器允许配置的进程数上限。只有在你需要将MaxClients设置成高于默认值256的时候才需要使用。要将此指令的值保持和MaxClients一样。修改此指令的值必须

完全停止服务后再启动才能生效，以restart方式重启动将不会生效。

MaxClients：用于伺服客户端请求的最大请求数量（最大子进程数），任何超过MaxClients限制的请求都将进入等候队列。默认值是256，如果要提高这个值必须同时提高

ServerLimit的值。笔者建议将初始值设为(以Mb为单位的最大物理内存/2),然后根据负载情况进行动态调整。比如一台4G内存的机器，那么初始值就是4000/2=2000。

MaxRequestsPerChild：设置每个子进程在其生存期内允许伺服的最大请求数量。到达MaxRequestsPerChild的限制后，子进程将会结束。如果MaxRequestsPerChild为"0"，子进程

将永远不会结束。将MaxRequestsPerChild设置成非零值有两个好处：可以防止(偶然的)内存泄漏无限进行而耗尽内存；

给进程一个有限寿命，从而有助于当服务器负载减轻的时候减少活动进程的数量。

如果设置为非零值，建议设为10000-30000之间的一个值。

公式：MaxClients<=ServerLimit


#设置worker多路处理模块

<IfModule mpm_worker_module>

    StartServers          5

    ServerLimit          20

    ThreadLimit         200

    MaxClients         4000

    MinSpareThreads      25

    MaxSpareThreads   250

    ThreadsPerChild     200

    MaxRequestsPerChild   0

</IfModule>

StartServers：设置服务器启动时建立的子进程数量。因为子进程数量动态的取决于负载的轻重,所有一般没有必要调整这个参数。

ServerLimit：服务器允许配置的进程数上限。只有在你需要将MaxClients和ThreadsPerChild设置成需要超过默认值16个子进程的时候才需要使用这个指令。不要将该指令的值设

置的比MaxClients 和ThreadsPerChild需要的子进程数量高。修改此指令的值必须完全停止服务后再启动才能生效，以restart方式重启动将不会生效。

ThreadLimit：设置每个子进程可配置的线程数ThreadsPerChild上限,该指令的值应当和ThreadsPerChild可能达到的最大值保持一致。修改此指令的值必须完全停止服务后再启动

才能生效，以restart方式重启动将不会生效。

MaxClients：用于伺服客户端请求的最大接入请求数量（最大线程数）。任何超过MaxClients限制的请求都将进入等候队列。默认值是"400"，16 (ServerLimit)乘以25

(ThreadsPerChild)的结果。因此要增加MaxClients的时候，你必须同时增加 ServerLimit的值。笔者建议将初始值设为(以Mb为单位的最大物理内存/2),然后根据负载情况进行动

态调整。比如一台4G内存的机器，那么初始值就是4000/2=2000。
MinSpareThreads：最小空闲线程数,默认值是"75"。这个MPM将基于整个服务器监视空闲线程数。如果服务器中总的空闲线程数太少，子进程将产生新的空闲线程。

MaxSpareThreads：设置最大空闲线程数。默认值是"250"。这个MPM将基于整个服务器监视空闲线程数。如果服务器中总的空闲线程数太多，子进程将杀死多余的空闲线程。

MaxSpareThreads的取值范围是有限制的。Apache将按照如下限制自动修正你设置的值：worker要求其大于等于 MinSpareThreads加上ThreadsPerChild的和。

ThreadsPerChild：每个子进程建立的线程数。默认值是25。子进程在启动时建立这些线程后就不再建立新的线程了。每个子进程所拥有的所有线程的总数要足够大，以便可以处理

可能的请求高峰。

MaxRequestsPerChild：设置每个子进程在其生存期内允许伺服的最大请求数量。到达MaxRequestsPerChild的限制后，子进程将会结束。如果MaxRequestsPerChild为"0"，子进程

将永远不会结束。将MaxRequestsPerChild设置成非零值有两个好处：可以防止(偶然的)内存泄漏无限进行而耗尽内存；

给进程一个有限寿命，从而有助于当服务器负载减轻的时候减少活动进程的数量。

如果设置为非零值，建议设为10000-30000之间的一个值。

公式：

         ThreadLimit >= ThreadsPerChild

         MaxClients <= ServerLimit * ThreadsPerChild 必须是ThreadsPerChild的倍数

         MaxSpareThreads >= MinSpareThreads+ThreadsPerChild

#配置Apache服务器默认设置 httpd-default.conf

Timeout 300

KeepAlive Off

MaxKeepAliveRequests 100

KeepAliveTimeout 5

UseCanonicalName Off

AccessFileName .htaccess

ServerTokens Prod

ServerSignature Off

HostnameLookups Off


Timeout：设置服务器在断定请求失败前等待的秒数。默认值300。

KeepAlive：设置是否启用HTTP持久链接，On 代表打开，Off 代表关闭。如果用于同一页面包含大量静态文件的应用，设置为On，以提高性能；如果用于主要为动态页面的应用，

设置为Off，以节约内存资源；如果服务器前跑有squid或者其它七层设备，设置为On。

MaxKeepAliveRequests：限制当启用KeepAlive时，每个连接允许的请求数量。如果将此值设为"0"，将不限制请求的数目。笔者建议将此值设为100-500之间的一个值，以确保最优

的服务器性能。

KeepAliveTimeout：设置持久链接中服务器在两次请求之间等待的秒数。对于高负荷服务器来说，KeepAliveTimeout值较大会导致一些性能方面的问题：超时值越大，与空闲客户

端保持连接的进程就越多。

UseCanonicalName：配置服务器如何确定它自己的域名，可选值为On | Off | DNS。DNS用于为大量基于IP的虚拟主机支持那些古董级的不提供"Host:"头的浏览器使用。笔者建议

设置为Off。

AccessFileName：设置分布式配置文件的名字，默认为.htaccess。如果为某个目录启用了分布式配置文件功能，那么在向客户端返回其中的文档时，服务器将在这个文档所在的各

级目录中查找此配置文件，因此会带来性能问题，笔者建议关闭分布式配置文件功能。

ServerTokens：控制服务器回应给客户端的"Server:"应答头是否包含关于服务器操作系统类型和编译进的模块描述信息，同时还控制着 ServerSignature指令的显示内容。可选值

为Full | OS | Minor | Minimal | Major | Prod。笔者建议设置为显示最少信息的Prod。

ServerSignature：配置服务器生成页面的页脚，可选值为On | Off | EMail。采用On会简单的增加一行关于服务器版本和正在伺服的虚拟主机的ServerName，而EMail设置会额外

创建一个指向 ServerAdmin的"mailto:"部分。建议使用默认值Off。

HostnameLookups：设置是否启用对客户端IP的DNS查找，可选值为On | Off | Double。DNS查询会造成明显的时间消耗，建议设置为Off。

 

#配置mod_deflate压缩模块 httpd-deflate.conf

mod_deflate模块提供了DEFLATE输出过滤器，允许服务器在将输出内容发送到客户端以前进行压缩，以节约带宽。

编辑mod_deflate压缩模块设置文件：


<IfModule mod_deflate.c>

    DeflateMemLevel 9

    DeflateWindowSize 15

    DeflateBufferSize 8096

    DeflateCompressionLevel 8

    ## 调试时去掉下面5行前的注释符，用以记录压缩日志

    #DeflateFilterNote Input instream

    #DeflateFilterNote Output outstream

    #DeflateFilterNote Ratio ratio

    #LogFormat '"%r" %b %{outstream}n/%{instream}n (%{ratio}n%%) "%{User-agent}i"' deflate

    #CustomLog logs/deflate_log deflate

    ## 插入DEFLATE过滤器，以启用输出压缩

　SetOutputFilter DEFLATE

　## Netscape 4.x 有一些问题，仅压缩txt/html类型

    BrowserMatch ^Mozilla/4 gzip-only-text/html

　## Netscape 4.06-4.08不能处理任何压缩内容，不进行压缩

    BrowserMatch ^Mozilla/4.0[678] no-gzip

    ## MSIE 会伪装成 Netscape ，但是事实上它没有问题

    BrowserMatch \bMSIE !no-gzip !gzip-only-text/html

    ## 设置图片、mp3、压缩格式文件等不需要进行压缩内容

    SetEnvIfNoCase Request_URI .(?:gif|jpe?g|png)$ no-gzip dont-vary

    SetEnvIfNoCase Request_URI .(?:exe|t?gz|zip|bz2|sit|rar)$ no-gzip dont-vary

    SetEnvIfNoCase Request_URI .(?:pdf|mov|avi|mp3|mp4|rm)$ no-gzip dont-vary

    ## 确保代理不会发送错误的内容

    Header append Vary User-Agent env=!dont-vary

</IfModule>


DeflateMemLevel：指定zlib在压缩时最多可以使用多少内存，取值范围在1到9之间。

DeflateWindowSize：定义zlib压缩窗口(compression window)的大小，取值范围在1到15之间，通常窗口越大压缩效果越好。

DeflateBufferSize：定义zlib一次压缩的片断的字节数，默认为8096。

DeflateCompressionLevel：设定压缩程度，越高的压缩程度就会有越好的压缩效果，同时也意味着占用越多的CPU资源。取值范围在 1(最低压缩率) 到 9(最高压缩率)之间，如果

不设置此指令，默认为zlib的默认值。

DeflateFilterNote：在日志中放置压缩率标记。

语法为：DeflateFilterNote type notename

notename就表示这个压缩率标记的名字，你可以为了某种统计目的将这个标记的名字添加到访问日志中。

type指定notename标记所记录的数据类型：Input，在标记中存储过滤器输入流的字节数；Output，在标记中存储过滤器输出流的字节数；Ratio，在标记中存储过滤器的压缩比(输

出/输入*100)，这是type的默认值。

SetOutputFilter：设置用于在服务器应答发送到客户端之前使用的过滤器。如果多于一个过滤器，必须按照处理内容的顺序用分号(;)分隔。

BrowserMatch：基于User-Agent头有条件地设置环境变量。

SetEnvIfNoCase：根据大小写无关的客户端请求属性设置环境变量。

Headers：配置HTTP应答头。这个指令可以替换、合并、删除HTTP应答头。应答头紧跟在内容处理器和输出过滤器完工之后生成，这时候才能对头进行修改。


#配置mod_expires模块

这个模块控制服务器应答时的Expires头内容和Cache-Control头的max-age指令。有效期(expiration date)可以设置为相对于源文件的最后修改时刻或者客户端的访问时刻。这些

HTTP头向客户端表明了文档的有效性和持久性。如果有缓存，文档就可以从缓存(除已经过期)而不是从服务器读取。接着，客户端考察缓存中的副本，看看是否过期或者失效，以

决定是否必须从服务器获得更新。

编辑mod_expires设置文件：httpd-expires.conf


## mod_expires设置文件

<IfModule mod_expires.c>

        ExpiresActive on

　    ExpiresDefault A300

        ExpiresByType text/html A300

        ExpiresByType image/gif A2592000

        ExpiresByType image/jpeg A2592000

        ExpiresByType image/png A2592000

        ExpiresByType text/css A2592000

        ExpiresByType text/js A2592000

        ExpiresByType text/javascript A2592000

        ExpiresByType application/x-javascript A2592000

</IfModule>


ExpiresActive：对其作用范围内的文档启用或禁用产生Expires和Cache-Control头的功能。若设置为 Off 则不会为其作用范围内的任何文档生成Expires和Cache-Control头(除非

被更低一层的规则改写，比如.htaccess文件)。若设置为 On 则会按照ExpiresByType和ExpiresDefault指令定义的标准为其作用范围内的文档生成Expires和Cache-Control 头。

注意，这个指令并不保证Expires或Cache-Control头一定会产生。如果定义的标准不规范，将不会产生这两个头，其效果是好像从未设置过这个指令一样。

ExpiresByType：为指定MIME类型的文档配置Expires头的值。

语法为：ExpiresByType MIME-type <code>seconds

seconds参数设置了添加到基准时间以构造有效期限的秒数。Cache-Control: max-age的计算方法是从有效期减去当前请求时间并转化为秒数。

基准时刻可以是源文件的最后修改时刻或者客户端对源文件的访问时刻，至于使用那一个则由<code>指定。"M"表示源文件的最后修改时刻，"A"表示客户端对源文件的访问时刻。

需要注意的是<code>和seconds之间没有空格。如果使用"M"，所有当前缓存中的文档副本都将在同一时刻过期，这个可能对定期更新的URL(比如位于同一位置的每周通告)很有好处

。如果使用"A"，则每个客户端所得到的有效期是不一样的，这个可能对那些几乎不更新的图片文件很有好处，特别是对于一组都引用了相同图片的相关文档。

ExpiresDefault：设置其作用范围内的所有文档的默认有效期的计算方法，它可以被ExpiresByType指令基于MIME类型被改写。
语法为：ExpiresDefault <code>seconds

<code>seconds同ExpiresByType一致。

#最后配置一下虚拟主机  httpd-vhost.conf

#这里重点介绍一下基于多端口的配置

NameVirtualHost *:81
NameVirtualHost *:82
NameVirtualHost *:83


<VirtualHost *:81>
ServerAdmin jafy@jafy00.com
DocumentRoot /www1
ServerName www.jafy00.com
ErrorLog logs/www1-error.log
CustomLog logs/www1-access_log common
</VirtualHost>

 


<VirtualHost *:82>
<Directory "/www2" >
Options FollowSymLinks
#Deny from all
Allow from all
</Directory>
ServerAdmin jafy@jafy00.com
DocumentRoot /www2
ServerName www.jafy00.com
DirectoryIndex index.php index.html
ErrorLog logs/www2-error.log
CustomLog logs/www2-access_log combined
</VirtualHost>