`Mac OS`安装启动盘的制作
=====================

> 准备材料:

1. `OS X` 安装程序（Mac App Store上下载或任何可信源）

2. `8G`以上的U盘，或硬盘，或分区(GUID MAX OS日志格式)。

制作安装盘：

1. 将准备好的`U`盘或移动硬盘或分区，用磁盘工具格式化成`Mac OS`扩展（日志式）格式，输入名称并创建

2，从`Mac App Store`下载安装程序。（或其它任何地方获得可信的安装程序）

如何获得，从AppStore中下载下来的OS X的系统镜像文件：
    从`AppStore`中下载下来后，会自动安装到Finder－》应用程序
    在 `Finder－》应用程序－》Install OS X EI Caption －》右击 显示包内容－》Contents－》SharedSupport－》InstallESD.dmg`

3. 按照以下步骤输入代码（均不含引号，如未设置系统密码，请前往设置-用户-设置系统密码）

    `sudo createinstallmedia --volume 盘 --applicationpath 安装程序 --nointeraction`
    `sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume /Volumes/PC6 --applicationpath /Applications/Install\ OS\ X\ Yosemite.app`
        `/Volumes/U盘名称` 是我们的U盘地址，如果您的U盘为【username】，那么这里的格式应为：`volume /Volumes/username`
        `Install\ OS\ X\ Yosemite.app`这里没有写错，这里的\ 是转义语法，整个名称对应的是：`Install OS X Yosemite.app`即我们从 AppStore下载的 系统安装文件名，如果是中文，仍然需要写成英文，并且需注意其【\】转义符号（保留空格）

        如果发生错误:
            可能是在终端中打开过，影响写入，关掉该终端即可

        文件位置在 安装程序 - 右键显示包文件 - Contents - Resources里
        程序自动空格，若无空格请自行空格

重启并按`Option`键，选择安装盘安装。

-------------------

1. 从`App Store`下载 `macOS` 安装程序，下载完成在Launchpad可以看到安装程序
2. 在桌面创建一个文件夹，命名为：`OSX.10.12.5` 
    (苹果系统文件夹命名 鼠标选中按回车键就好了)
3. 用 `Finder` 将 应用程序 文件夹里的 安装 `macOS Sierra.app` 移动
    拖拽同时按住Command键）到`OSX.10.12.5`文件夹里（从应用程序移动文件需要输入登录密码）
4. 打开磁盘工具，菜单：文件 -> 新建 -> 文件夹的镜磁盘映像

    设置映像的名字为`macOSX10.12.5`,标记为红色，格式设置为读/写，点`存储`按钮。
    此操作目的是创建一个适合大小的dmg文件

    系统制作完成后就能够在桌面上看到dmg文件了

5. 转换后的名字为`macOSX10.12.15_1`，标记为绿色，格式为压缩，单击存储

6. 右击磁盘上图的磁盘图标，选择 推出 功能按钮：
7. 如果需要制作苹果电脑U盘启动盘需要插入U盘，打开磁盘工具，选择U盘（不是卷），点抹掉，U盘中的数据会被全部清除，并被重新创建为GUID分区格式，分区为Mac OS 扩展（日志式）。
8. 选择U盘的卷，菜单：`编辑 - 恢复`，点映像按钮，选择我们前面创建的`dmg`，然后点恢复。
9. 完成后，U盘就是一个`OSX`安装盘了。
