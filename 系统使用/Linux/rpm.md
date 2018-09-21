## `RPM` 安装操作 
`rpm -ivh example.rpm `
安装 `example.rpm` 包并在安装过程中显示正在安装的文件信息及安装进度； 

---------------------------
## `RPM` 卸载操作 
命令： 
`rpm -e ` 需要卸载的安装包 
> 在卸载之前，通常需要使用`rpm -q` 命令查出需要卸载的安装包名称。 

举例如下： 
`rpm -e tomcat4 `卸载 tomcat4 软件包 

-----------------------------
## `RPM` 升级操作 
命令： 
`rpm -U `需要升级的包 

举例如下： 
`rpm -Uvh example.rpm` 升级 example.rpm 软件包 

--------------------------
## RPM 验证操作 
命令： 
`rpm -V` 需要验证的包 
举例如下： 
`rpm -Vf /etc/tomcat4/tomcat4.conf `

输出信息类似如下： 
`S.5….T c /etc/tomcat4/tomcat4.conf `
其中，S 表示文件大小修改过，T 表示文件日期修改过。

---------------------------------
## `RPM` 的其他附加命令 
–force 强制操作 如强制安装删除等； 
–requires 显示该包的依赖关系； 
–nodeps 忽略依赖关系并继续操作