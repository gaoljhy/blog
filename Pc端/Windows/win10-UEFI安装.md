指定 磁盘 gpt 格式


删除文件“bootmgr.efi”和文件夹“efi”

## U盘安装WIN10时显示 windows无法安装到这个磁盘 选中的磁盘采用GPT分区形式 
一、原因分析
　　`win8/win10`系统均添加快速启动功能，预装的`win8/win10`电脑默认都是`UEFI`引导和`GPT`硬盘，传统的引导方式为`Legacy`引导和`MBR`硬盘
    `UEFI`必须跟`GPT`对应，同理`Legacy`必须跟`MBR`对应。
    
如果BIOS开启UEFI，而**硬盘分区表格式为MBR**则无法安装;
`BIOS`关闭`UEFI`而硬盘分区表格式为`GPT`也是无法安装`Windows。`
