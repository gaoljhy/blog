# bind

- `BIND`配置文件保存在两个位置：

 `/etc/named.conf`　　- BIND服务主配置文件
 `/var/named/`　　　　- zone文件（域的dns信息）

- 如果安装了`bind-chroot`（其中chroot是 change root 的缩写），BIND会被封装到一个伪根目录内

 配置文件的位置变为：
 `/var/named/chroot/etc/named.conf` 　　- BIND服务主配置文件
 `/var/named/chroot/var/named/`　　　　- zone文件

　　chroot 是通过相关文件封装在一个伪根目录内，已达到安全防护的目的，一旦程序被攻破，将只能访问伪根目录内的内容，而不是真实的根目录

- BIND安装好之后不会有预制的配置文件
  但是在BIND的文档文件夹内（`/usr/share/doc/bind-9.9.4`），BIND为提供了配置文件模板，可以直接拷贝过来：
　　　　`cp -r /usr/share/doc/bind-9.9.4/sample/etc/* /var/named/chroot/etc/`
　　　　`cp -r /usr/share/doc/bind-9.9.4/sample/var/* /var/named/chroot/var/`
