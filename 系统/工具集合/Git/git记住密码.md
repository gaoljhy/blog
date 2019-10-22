#　git记住密码

## 使用ssh协议

step 1: 生成公钥

    ```bash
    ssh-keygen -t rsa -C "git@github.com"  
    # Generating public/private rsa key pair...
    # 三次回车即可生成 ssh key
    ```

step 2: 查看已生成的公钥

    ```bash
    cat ~/.ssh/id_rsa.pub
    # ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6eNtGpNGwstc....
    ```

step3: 复制已生成的公钥添加到git服务器
step4: 使用`ssh`协议`clone`远程仓库

or
    如果已经用`https`协议`clone`到本地了，那么就重新设置远程仓库
    `git remote set-url origin git@github.com:xxx/xxx.git`

## 2.设置git配置

对于 `HTTP` 协议 `git` 拥有一个凭证系统来处理这个事情
默认所有都不缓存。 每一次连接都会询问你的用户名和密码。

1. `cache` 模式会将凭证存放在内存中一段时间。
    密码永远不会被存储在磁盘中，并且在15分钟后从内存中清除。

2. `store` 模式会将凭证用明文的形式存放在磁盘中，并且永不过期。
    这意味着除非你修改了你在 Git 服务器上的密码，否则你永远不需要再次输入你的凭证信息。
    > 这种方式的缺点是你的密码是用明文的方式存放在你的 home 目录下。

> 如果你使用的是 `Mac`，Git 还有一种 `osxkeychain` 模式，它会将凭证缓存到你系统用户的钥匙串中。 
> 这种方式将凭证存放在磁盘中，并且永不过期，但是是被加密的，这种加密方式与存放 `HTTPS` 凭证以及 `Safari` 的自动填写是相同的。

如果你使用的是 `Windows`，你可以安装一个叫做 `winstore` 的辅助工具。
这和上面说的 `osxkeychain` 十分类似，但是是使用 `Windows Credential Store` 来控制敏感信息。 
可以在 <https://gitcredentialstore.codeplex.com> 下载。

### 可以设置 Git 的配置来选择上述的一种方式

`git config --global credential.helper cache`

部分辅助工具有一些选项。 `store` 模式可以接受一个 `--file <path>` 参数，可以自定义存放密码的文件路径（默认是`~/.git-credentials`）。 “cache” 模式有 `--timeout <seconds>` 参数，可以设置后台进程的存活时间（默认是 `900`，也就是 15 分钟）。 下面是一个配置 “store” 模式自定义路径的例子：

`git config --global credential.helper store --file ~/.my-credentials`

> Git 甚至允许你配置多个辅助工具。 当查找特定服务器的凭证时，Git 会按顺序查询，并且在找到第一个回答时停止查询。 
>> 当保存凭证时，Git 会将用户名和密码发送给 所有 配置列表中的辅助工具，它们会按自己的方式处理用户名和密码。 
>> 如果你在闪存上有一个凭证文件，但又希望在该闪存被拔出的情况下使用内存缓存来保存用户名密码，.gitconfig 配置文件如下：

```
[credential]
    helper = store --file /mnt/thumbdrive/.git-credentials
    helper = cache --timeout 30000
```

## 修改git配置文件

在用户文件夹下找到 `.gitconfig`文件,用编辑器或者vim打开，如果之前有配置过用户名和密码就会在里面看到

```config
[user]
    name = xxx
    email = xxx@xxxxx.com
# 在后面追加如下配置并保存

[credential]
     helper=store
```

下次执行`git push`再次输入用户名之后，`git`就会记住用户名密码并在上述目录下创建`.git-credentials`文件，记录的就是输入的用户名密码。
