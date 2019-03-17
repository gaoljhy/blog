# createrepo

相关命令：暂无相关命令

> createrepo用以创建yum源（软件仓库），即为存放于本地特定位置的众多rpm包建立索引，描述各包所需依赖信息，并形成元数据。

基本语法：`createrepo [option] <directory>`

常用参数详解

```bash
    -u  --baseurl <url>
        指定Base URL的地址


    -o --outputdir <url>
        指定元数据的输出位置


    -x --excludes <packages>
        指定在形成元数据时需要排除的包


    -i --pkglist <filename>
        指定一个文件，该文件内的包信息将被包含在即将生成的元数据中，格式为每个包信息独占一行，不含通配符、正则，以及范围表达式。


    -n --includepkg
        通过命令行指定要纳入本地库中的包信息，需要提供URL或本地路径。


    -q --quiet
        安静模式执行操作，不输出任何信息。


    -g --groupfile <groupfile>
        指定本地软件仓库的组划分，范例如下：

    createrepo -g comps.xml /path/to/rpms
        注意：组文件需要和rpm包放置于同一路径下。


    -v --verbose
        输出详细信息。


    -c --cachedir <path>
        指定一个目录，用作存放软件仓库中软件包的校验和信息。当createrepo在未发生明显改变的相同仓库文件上持续多次运行时，指定cachedir会明显提高其性能。


    --update
        如果元数据已经存在，且软件仓库中只有部分软件发生了改变或增减，则可用update参数直接对原有元数据进行升级，效率比重新分析rpm包依赖并生成新的元数据要高很多。


    -p --pretty
        以整洁的格式输出xml文件。


    -d --database
        该选项指定使用SQLite来存储生成的元数据，默认项。
```


例1

`mkdir -p /yum/centos/6/`      #创建本地源目录

`createrepo -p -d -o /yum/centos/6/ix86_64 /yum/centos/6/ix86_64`   #初始化源目录，产生repodata
