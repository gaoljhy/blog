# yum 常用

1. 查询指定软件包 (可判断是否安装在本机上)
    `yum search 软件`
2. 查询 软件详细信息
    `yum info 软件`
3. 安装指定软件包
    `yum install 软件`
    `yum -y install 软件` 强制安装 不受依赖项 约束
4. 删除指定软件包
    `yum erase 软件包`
    `yum -y erase 软件包` 强制删除 不受依赖项 约束
5. 提供 `yum` 字典
    `yum whatprovides <string>`

6. group组 操作
    1. 查看依赖项
        `yum groups info`
    2. 查看继承的依赖包
        `yum groups list`
    3. 成组安装 安集成包
        `yum groups install <string>`
    4. 成组 删除
        `yum groups remove <string>`

`clean`          Remove cached data
`deplist`        List a package's dependencies