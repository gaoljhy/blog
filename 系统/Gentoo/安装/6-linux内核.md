# Linux 内核

## 安装源码
Linux内核是所有发行版的核心。它位于用户程序和系统硬件之间。Gentoo提供给用户一些可选的内核源码。完整的带描述的列表在内核概述页面。

针对基于x86-系统的Gentoo，建议使用包 sys-kernel/gentoo-sources。

选择一个合适的内核并使用emerge来安装它。

root #emerge --ask sys-kernel/gentoo-sources
这将在/usr/src/中安装Linux内核源码，并有一个符号连接叫作linux将指向安装的内核源码：

root #ls -l /usr/src/linux
lrwxrwxrwx    1 root   root    12 Oct 13 11:04 /usr/src/linux -> linux-3.16.5-gentoo
现在是时候来配置和编译内核源代码了。有两种方法：

手动配置并生成内核。
一个叫作genkernel的工具用来自动化生成并安装Linux内核。
我们在这里解释做为默认选择的手动配置，它是优化环境的最好方式。

默认：手动配置
介绍
手动配置内核经常被Linux用户认为是最困难的步骤。事实并非如此——但是当您手动配置几次内核之后，你就不会再觉得它有多么难了：）

无论如何，有一件事是真实的：当手动配置内核时，了解（硬件）系统是至关重要的。大多数信息可以通过安装包含lspci命令的sys-apps/pciutils来收集：

root #emerge --ask sys-apps/pciutils
 附注
在chroot中，可以安全的忽略任何lspci可能抛出的关于pcilib的警告（比如pcilib: cannot open /sys/bus/pci/devices）。
另一个系统信息来源是运行lsmod来查看安装CD使用什么内核模块，它可能对启用什么提供了一个好的暗示。

现在进入内核源码目录并执行make menuconfig。这将启动一个菜单驱动的配置屏幕。

root #cd /usr/src/linux
root #make menuconfig
Linux内核配置有很多很多的章节。我们先列出一些必须激活的选项（否则Gentoo将无法工作，或者离开附加的调整将无法正常工作）。我们同时在Gentoo维基上有一个Gentoo内核配置指南可能会在将来有帮助。

激活必要的选项
确保引导系统的每一个至关重要的驱动（比如SCSI控制器,等等）是编译进内核而不是作为一个模块，否则系统将无法完全引导。

接下来选择最控制的CPU类型。同时建议启用MCE功能（如果可用）能在硬件出现问题时通知用户。在一些架构（比如x86_64），这些错误不会打印到 dmesg，但是会到/dev/mcelog。这需要app-admin/mcelog包。

同时选择Maintain a devtmpfs file system to mount at /dev来让重要的设备文件在引导过程的早期就已就绪(CONFIG_DEVTMPFS and CONFIG_DEVTMPFS_MOUNT):

KERNEL 启用devtmpfs支持
Device Drivers --->
  Generic Driver Options --->
    [*] Maintain a devtmpfs filesystem to mount at /dev
    [ ]   Automount devtmpfs at /dev, after the kernel mounted the rootfs
Verify SCSI disk support has been activated (CONFIG_BLK_DEV_SD):

KERNEL Enabling SCSI disk support
Device Drivers --->
   SCSI device support  --->
      <*> SCSI disk support
现在进入File Systems并选择你使用的文件系统。不要作为模块来编译根文件系统所使用的文件系统，否则Gentoo系统将不能挂载这个分区。同时选择Virtual memory和/proc file system根据系统的需要选择一个或多个以下选项(CONFIG_EXT2_FS, CONFIG_EXT3_FS, CONFIG_EXT4_FS, CONFIG_MSDOS_FS, CONFIG_VFAT_FS, CONFIG_PROC_FS, and CONFIG_TMPFS):

KERNEL 选择所需要的文件系统
File systems --->
  <*> Second extended fs support
  <*> The Extended 3 (ext3) filesystem
  <*> The Extended 4 (ext4) filesystem
  <*> Reiserfs support
  <*> JFS filesystem support
  <*> XFS filesystem support
  <*> Btrfs filesystem support
  DOS/FAT/NT Filesystems  --->
    <*> MSDOS fs support
    <*> VFAT (Windows-95) fs support
 
Pseudo Filesystems --->
    [*] /proc file system support
    [*] Tmpfs virtual memory file system support (former shm fs)
如果使用PPPoE连接到互联网，或者是拨号调制解调器，则启用下面的选项(CONFIG_PPP, CONFIG_PPP_ASYNC, and CONFIG_PPP_SYNC_TTY)：

KERNEL 选择PPPoE所需要的驱动
Device Drivers --->
  Network device support --->
    <*> PPP (point-to-point protocol) support
    <*>   PPP support for async serial ports
    <*>   PPP support for sync tty ports
这两个压缩选项将是无害的，但是它们一定是不需要的，包括基于以太网的PPP选项也是一样，只有在配置内核模式PPPoE时才会需要。

不要忘记在内核中包括网（以太网或无线）卡。

大多数系统会有多核心处理，所以激活“Symmetric multi-processing support”是重要的' (CONFIG_SMP)：

KERNEL 激活SMP支持
Processor type and features  --->
  [*] Symmetric multi-processing support
 附注
在多核心系统中，每一个核心计作一个处理器。
如果使用USB输入设备（比如键盘和鼠标）或其他USB设备，不要忘记启用那些(CONFIG_HID_GENERIC and CONFIG_USB_HID, CONFIG_USB_SUPPORT, CONFIG_USB_XHCI_HCD, CONFIG_USB_EHCI_HCD, CONFIG_USB_OHCI_HCD):：

KERNEL 激活USB输入设备的支持
HID support  --->
    -*- HID bus support
    <*>   Generic HID driver
    [*]   Battery level reporting for HID devices
      USB HID support  --->
        <*> USB HID transport layer
  [*] USB support  --->
    <*>     xHCI HCD (USB 3.0) support
    <*>     EHCI HCD (USB 2.0) support
    <*>     OHCI HCD (USB 1.1) support


Architecture specific kernel configuration
Make sure to select IA32 Emulation if 32-bit programs should be supported (CONFIG_IA32_EMULATION). Gentoo installs a multilib system (mixed 32-bit/64-bit computing) by default, so unless a no-multilib profile is used, this option is required.

KERNEL Selecting processor types and features
Processor type and features  --->
   [ ] Machine Check / overheating reporting 
   [ ]   Intel MCE Features
   [ ]   AMD MCE Features
   Processor family (AMD-Opteron/Athlon64)  --->
      ( ) Opteron/Athlon64/Hammer/K8
      ( ) Intel P4 / older Netburst based Xeon
      ( ) Core 2/newer Xeon
      ( ) Intel Atom
      ( ) Generic-x86-64
Executable file formats / Emulations  --->
   [*] IA32 Emulation
Enable GPT partition label support if that was used previously when partitioning the disk (CONFIG_PARTITION_ADVANCED and CONFIG_EFI_PARTITION):

KERNEL Enable support for GPT
-*- Enable the block layer --->
   Partition Types --->
      [*] Advanced partition selection
      [*] EFI GUID Partition support
Enable EFI stub support and EFI variables in the Linux kernel if UEFI is used to boot the system (CONFIG_EFI, CONFIG_EFI_STUB, CONFIG_EFI_MIXED, and CONFIG_EFI_VARS):

KERNEL Enable support for UEFI
Processor type and features  --->
    [*] EFI runtime service support 
    [*]   EFI stub support
    [*]     EFI mixed-mode support
 
Firmware Drivers  --->
    EFI (Extensible Firmware Interface) Support  --->
        <*> EFI Variable Support via sysfs
Compiling and installing
With the configuration now done, it is time to compile and install the kernel. Exit the configuration and start the compilation process:

root #make && make modules_install
 Note
It is possible to enable parallel builds using make -jX with X being an integer number of parallel tasks that the build process is allowed to launch. This is similar to the instructions about /etc/portage/make.conf earlier, with the MAKEOPTS variable.
When the kernel has finished compiling, copy the kernel image to /boot/. This is handled by the make install command:

root #make install
This will copy the kernel image into /boot/ together with the System.map file and the kernel configuration file.



可选：生成一个initramfs
在某些情况中需要建立一个initramfs——一个基于内存的初始化文件系统。最觉的原因是当重要的文件系统位置（如/usr/或/var/）在分离的分区。通过一个initramfs，这些分区可以使用initramfs里面的工具来完成挂载。

如果没有initramfs的，存在着巨大的风险，系统将无法正常开机，因为这是负责安装的文件系统工具需要驻留在这些文件系统的信息。 initramfs中的一个将在必要的文件拉进它的内核启动之后使用的档案，但控制被移交前转移到初始化工具。在initramfs的脚本，然后将确保分区正确地安装在系统继续启动之前。

要安装一个initramfs，首先安装sys-kernel/genkernel，然后用它生成一个initramfs：

root #emerge --ask sys-kernel/genkernel
root #genkernel --install initramfs
为了在initramfs中启用特定的支持，比如LVM或RAID，要为genkernel添加一个合适的选项。查看genkernel --help以获得更多信息。在下面的示例中，我们启用LVM和软件RAID (mdadm) 的支持：

root #genkernel --lvm --mdadm --install initramfs
initramfs将存储在/boot/。结果文件可以简单的通过列出以initramfs开头的文件来找到：

root #ls /boot/initramfs*
现在继续到内核模块。

备选：使用genkernel
如果手动配置看起来太恐怖，建议使用genkernel。它将自动配置并编译内核。

genkernel配置内核的工作原理几乎和安装CD配置的内核完全一致。也就是说当使用genkernel建立内核，系统通常将在引导时检测全部硬件，就像安装CD所做的。因为genkernel不需要任何手动内核配置，它对于那些不能轻松的编译他们自动内核的用户来说是一个理想的解决方案。

现在，我们来看看如何使用genkernel。首先emerge sys-kernel/genkernel这个ebuild：

root #emerge --ask sys-kernel/genkernel
接下来，编辑/etc/fstab文件来使包含有第二个值为/boot/的那条的第一个值指向到正确的设备。如果是按照本手册的分区示例，则这个设备非常像使用ext2文件系统的/dev/sda2。这将使文件中的这一条目看起来像是：

root #nano -w /etc/fstab
FILE /etc/fstab配置 /boot 挂载点
/dev/sda2	/boot	ext2	defaults	0 2
 附注
在Gentoo将来的安装中，还要再配置一次/etc/fstab。现在只需要正确设置/boot来让genkernel应用程序读到相应的配置。
现在，运行genkernel all来编译内核源码。值得注意的是，使用genkernel编译一个内核将支持几乎全部的硬件，这将使编译过程需要一阵子来完成！

 附注
如果引导分区不是使用ext2或ext3作为文件系统，它可能需要使用genkernel --menuconfig all来手动配置内核，并在内核中添加对这个具体文件系统的支持（比如：不是作为一个模块）。LVM2用户可能要作为参数来添加--lvm。
root #genkernel all
一旦genkernel完成，将创建一个内核、全部的模块和初始化内存文件（initramfs）。我们将在文档后面配置引导器的时候使用这个内核和initrd。记下内核和initrd名字作为编辑引导器配置文件的信息。initrd将在后执行硬件检测之后、“真实”系统启动之前立即启动。

root #ls /boot/kernel* /boot/initramfs*