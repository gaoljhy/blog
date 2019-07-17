#!/bin/bash
#kvm manager
#datetime 2017.5 dongwh
server_ip=10.226.41.226
os_name=`cat /etc/redhat-release | awk ' {print $1}'`
os_id=`cat /etc/redhat-release | awk ' {print $(NF-1)}' | awk -F"." '{print $1"."$2}'`
os_version=$os_name-$os_id
images_dir=/var/lib/libvirt/images
xml_dir=/etc/libvirt/qemu
red_col="\e[1;31m"
blue_col="\e[1;34m"
reset_col="\e[0m"
centos6_base_img=centos6.qcow2
rhel6_base_img=rhel6.qcow2
centos7_base_img=centos7.qcow2
centos7u4_base_img=centos7.4.qcow2
rhel7_base_img=rhel7.qcow2
win7_base_img=win7.qcow2
menu() {
cat <<-EOF
+------------------------------------------------+
|	使用前请阅读 Readme.txt 文档	by Abel	 |
|================================================|
|		 KVM 虚拟机管理系统		 |
|================================================|
|		1. 安装/重置CentOS6  		 |
|		2. 安装/重置CentOS7              |
|		3. 删除指定虚拟机  		 |
|		4. 安装/重置RHEL7 		 |
|		5. 安装/重置RHEL6		 |
|		6. 安装/重置Windows7     	 |
|		7. 删除所有虚拟机		 |
|		8. 安装/重置Centos7.4		 |
|		q. 退出管理程序			 | 
|						 |
+------------------------------------------------+	
EOF
}

download_kvm_script() {
	wget -O /root/Desktop/virt-manager.desktop ftp://$server_ip/virt-manager.desktop &>/dev/null
	wget -O /root/Desktop/Readme.txt ftp://$server_ip/vms/Readme.txt &>/dev/null
	wget -O /usr/local/sbin/kvm-manager ftp://$server_ip/kvm-manager &>/dev/null
	chmod a+x /usr/local/sbin/kvm-manager &>/dev/null
	chmod a+x /root/Desktop/virt-manager.desktop &>/dev/null
}
conn_test() {
	ping -c1 $server_ip &>/dev/null
	if [ $? -ne 0 ];then
		echo -e "${red_col}无法访问$server_ip, 请检查网络或稍后再试!${reset_col}"	
		echo
		exit
	fi
	
}
link_test() {
		conn_test
		download_kvm_script
}
kvm_xml() {
		sed -ri "s/vm_name/$vm_name/" ${xml_dir}/${vm_name}.xml
		sed -ri "s/vm_uuid/$vm_uuid/" ${xml_dir}/${vm_name}.xml
		sed -ri "s/vm_mac/$vm_mac/" ${xml_dir}/${vm_name}.xml
 		sed -ri "s#vm_img#$vm_img#" ${xml_dir}/${vm_name}.xml
		virsh define ${xml_dir}/${vm_name}.xml &>/dev/null
		echo "虚拟机${vm_name}重置完成..."
}
mac_uuid() {
			vm_uuid=$(uuidgen)
			vm_mac="52:54:$(dd if=/dev/urandom count=1 2>/dev/null | md5sum | sed -r 's/^(..)(..)(..)(..).*$/\1:\2:\3:\4/')"
			vm_img=$images_dir/${vm_name}.qcow2
}
rm_rf() {
			virsh destroy ${vm_name} &>/dev/null
			virsh undefine ${vm_name} &>/dev/null
			rm -rf ${xml_dir}/${vm_name}.xml
			rm -rf ${images_dir}/${vm_name}.*
}
rm_all() {
				virsh destroy $i &>/dev/null
				virsh undefine $i &>/dev/null
				rm -rf ${xml_dir}/*.xml
				rm -rf ${images_dir}/$i.qcow2
}
menu
while :
do
	echo -en "${blue_col}请选择相应的操作[1-7], 显示菜单[m]: ${reset_col}"
	read choose

	case $choose in 
	1)
		link_test	
		read -p "确认重置centos6 虚拟机吗?[y]: " rebuild_centos6
		if [ ! "${rebuild_centos6}" = "y" ];then
			echo -e "$red_col输入不正确! $reset_col"
			continue
		fi
		if [ ! -f ${images_dir}/${centos6_base_img} ];then
			echo "正在下载镜像文件，请稍候......"
			wget -O ${images_dir}/${centos6_base_img} ftp://$server_ip/vms/${centos6_base_img}
		fi
		for i in {1..3}
		do
			vm_name=centos6-${i}
			mac_uuid
			rm_rf
			qemu-img create -f qcow2 -b ${images_dir}/${centos6_base_img} ${images_dir}/${vm_name}.qcow2 &>/dev/null
			wget -q ftp://$server_ip/vms/xml/centos6.xml -O ${xml_dir}/${vm_name}.xml
			kvm_xml
		done
		;;
	2)
		link_test
		read -p "确认重置centos7 虚拟机吗?[y]: " rebuild_centos7
		if [ ! "${rebuild_centos7}" = "y" ];then
			echo -e "$red_col输入不正确! $reset_col"
			continue
		fi
		for i in {1..7}
		do
		if [ ! -f ${images_dir}/${centos7_base_img} ];then
			echo "正在下载镜像文件，请稍候......"
			wget -O ${images_dir}/${centos7_base_img} ftp://$server_ip/vms/${centos7_base_img}
		fi
			vm_name=centos7-${i}
			mac_uuid
			rm_rf
			qemu-img create -f qcow2 -b ${images_dir}/${centos7_base_img} ${images_dir}/${vm_name}.qcow2 &>/dev/null
			wget -q ftp://$server_ip/vms/xml/centos7.xml -O ${xml_dir}/${vm_name}.xml
			kvm_xml
		done
		;;
	3)
		virsh list --all |awk '/[0-9]/{print $2}'
		read -p "请输入要删除的虚拟机名:e.g centos6 : " delete_centos7
                echo -en "${red_col}确认删除${delete_centos7}虚拟机吗?[y]:${reset_col} " 
		all_vm=$(virsh list --all |awk '/[0-9]/{print $2}'|grep $delete_centos7)
                read delete_all
                if [ ! "${delete_all}" = "y" ];then
                        echo -e "$red_col放弃删除! $reset_col"
                        continue
                fi

                if [ $? -eq 0 ]; then
                        for i in ${all_vm}
                        do
			rm_all
                                echo "已删除虚拟机$i"
                        done
		fi
			;;

	4)
		link_test
		read -p "确认重置Rhel7.2 虚拟机吗?[y]: " rebuild_rhel7
		if [ ! "${rebuild_rhel7}" = "y" ];then
			echo -e "$red_col输入不正确! $reset_col"
			continue
		fi
		if [ ! -f ${images_dir}/${rhel7_base_img} ];then
			echo "正在下载镜像文件，请稍候......"
			wget -O ${images_dir}/${rhel7_base_img} ftp://$server_ip/vms/${rhel7_base_img}
		fi
		for i in {1..2}
		do
			vm_name=rhel7-${i}
			mac_uuid
			rm_rf
			qemu-img create -f qcow2 -b ${images_dir}/${rhel7_base_img} ${images_dir}/${vm_name}.qcow2 &>/dev/null
			wget -q ftp://$server_ip/vms/xml/rhel7.xml -O ${xml_dir}/${vm_name}.xml
			kvm_xml
		done
		;;
	5)
		link_test
		read -p "确认重置Rhel6.4 虚拟机吗?[y]: " rebuild_rhel6
		if [ ! "${rebuild_rhel6}" = "y" ];then
			echo -e "$red_col输入不正确! $reset_col"
			continue
		fi
		if [ ! -f ${images_dir}/${rhel6_base_img} ];then
			echo "正在下载镜像文件，请稍候......"
			wget -O ${images_dir}/${rhel6_base_img} ftp://$server_ip/vms/${rhel6_base_img}
		fi
		for i in {1..4}
		do
			vm_name=rhel6-${i}
			mac_uuid
			rm_rf
			qemu-img create -f qcow2 -b ${images_dir}/${rhel6_base_img} ${images_dir}/${vm_name}.qcow2 &>/dev/null
			wget -q ftp://$server_ip/vms/xml/rhel6.xml -O ${xml_dir}/${vm_name}.xml
			kvm_xml
		done
		;;


	6)
		link_test
		read -p "确认重置 windows 虚拟机吗?[y]: " rebuild_windows
		if [ ! "${rebuild_windows}" = "y" ];then
			echo -e "$red_col输入不正确! $reset_col"
			continue					
		fi
		if [ ! -f ${images_dir}/${win7_base_img} ];then
			echo "正在下载镜像文件，请稍候......"
			wget -O ${images_dir}/${win7_base_img} ftp://$server_ip/vms/${win7_base_img}
		fi
		vm_name=windows7
		virsh destroy ${vm_name} &>/dev/null
		virsh undefine ${vm_name} &>/dev/null
		rm -rf ${xml_dir}/${vm_name}.xml
		rm -rf ${images_dir}/${vm_name}.qcow2
		qemu-img create -f qcow2 -b ${images_dir}/${win7_base_img} ${images_dir}/${vm_name}.qcow2 &>/dev/null
		wget -q ftp://$server_ip/vms/xml/win7.xml -O ${xml_dir}/${vm_name}.xml
		sed -ri "s/vm_name/$vm_name/" ${xml_dir}/${vm_name}.xml
		virsh define ${xml_dir}/${vm_name}.xml &>/dev/null
		echo "虚拟机 ${vm_name} 重置完成..."
		;;
	7)
		link_test
		all_vm=$(virsh list --all |awk '/[0-9]/{print $2}')
		echo -en "${red_col}确认删除所有虚拟机吗?[y]:${reset_col} " 
		read delete_all
		if [ ! "${delete_all}" = "y" ];then
			echo -e "$red_col放弃删除! $reset_col"
			continue					
		fi
		if [ $? -eq 0 ]; then
			for i in ${all_vm}
			do
				rm_all
				echo "已删除虚拟机$i"
			done
		fi
		;;
	8)
		link_test
		read -p "确认重置centos7.4 虚拟机吗?[y]: " rebuild_centos7
		if [ ! "${rebuild_centos7}" = "y" ];then
			echo -e "$red_col输入不正确! $reset_col"
			continue
		fi
		for i in {1..3}
		do
		if [ ! -f ${images_dir}/${centos7u4_base_img} ];then
			echo "正在下载镜像文件，请稍候......"
			wget -O ${images_dir}/${centos7u4_base_img} ftp://$server_ip/vms/${centos7u4_base_img}
		fi
			vm_name=centos7.4-${i}
			mac_uuid
			rm_rf
			qemu-img create -f qcow2 -b ${images_dir}/${centos7u4_base_img} ${images_dir}/${vm_name}.qcow2 &>/dev/null
			wget -q ftp://$server_ip/vms/xml/centos7.4.xml -O ${xml_dir}/${vm_name}.xml
			kvm_xml
		done
		;;

	m)
		clear
		menu
		;;
	q)
		exit
		;;
	'')
		;;
	*)
		echo "输入错误！"
		
	esac

done
