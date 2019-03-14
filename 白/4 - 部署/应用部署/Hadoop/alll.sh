#!/bin/bash

JDKLINK='http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm'
HADOOPLINK='https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz'
localIP=$(ip a | grep ens33 | awk '$1~/^inet.*/{print $2}' | awk -F '/' '{print $1}')
ip_arrays=()

#初始化环境
installWget(){
	echo '初始化安装环境....'
	wget
	if [ $? -ne 1 ]; then
		echo '开始下载wget'
		yum -y install wget
	fi
}

#wget下载JDK进行安装
installJDK(){
	ls /usr/local | grep 'jdk.*[rpm]$'
	if [ $? -ne 0 ]; then
		echo '开始下载JDK.......'
		wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $JDKLINK
		mv $(ls | grep 'jdk.*[rpm]$') /usr/local
	fi
	chmod 751 /usr/local/$(ls /usr/local | grep 'jdk.*[rpm]$')
	rpm -ivh /usr/local/$(ls /usr/local | grep 'jdk.*[rpm]$')
}

#JDK环境变量配置
pathJDK(){
	#PATH设置
	grep -q "export PATH=" /etc/profile
	if [ $? -ne 0 ]; then
		#末行插入
		echo 'export PATH=$PATH:$JAVA_HOME/bin'>>/etc/profile
	else
		#行尾添加
		sed -i '/^export PATH=.*/s/$/:\$JAVA_HOME\/bin/' /etc/profile
	fi
	
	grep -q "export JAVA_HOME=" /etc/profile
	if [ $? -ne 0 ]; then
		#导入配置
		filename="$(ls /usr/java | grep '^jdk.*[^rpm | gz]$' | sed -n '1p')"
		sed -i "/^export PATH=.*/i\export JAVA_HOME=\/usr\/java\/$filename" /etc/profile
		sed -i '/^export PATH=.*/i\export JRE_HOME=$JAVA_HOME/jre' /etc/profile
		sed -i '/^export PATH=.*/i\export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' /etc/profile
		#echo "export JAVA_HOME=/usr/java/$filename">>/etc/profile
		#echo 'export JRE_HOME=$JAVA_HOME/jre'>>/etc/profile
		#echo 'export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar'>>/etc/profile
	else
		#替换原有配置
		filename="$(ls /usr/java | grep '^jdk.*[^rpm | gz]$' | sed -n '1p')"
		sed -i "s/^export JAVA_HOME=.*/export JAVA_HOME=\/usr\/java\/$filename/" /etc/profile
	fi
	source /etc/profile
}

#wget下载Hadoop进行解压(单机版)
wgetHadoop(){
	ls /usr/local | grep 'hadoop.*[gz]$'
	if [ $? -ne 0 ]; then
		echo '开始下载hadoop安装包...'
		wget $HADOOPLINK
		mv $(ls | grep 'hadoop.*gz$') /usr/local
	fi
	tar -zxvf /usr/local/$(ls | grep 'hadoop.*[gz]$')
	mv /usr/local/$(ls | grep 'hadoop.*[^gz]$') /usr/local/hadoop
}

#hadoop环境变量配置
pathHadoop(){
	#PATH设置
	grep -q "export PATH=" /etc/profile
	if [ $? -ne 0 ]; then
		#末行插入
		echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin'>>/etc/profile
	else
		#行尾添加
		sed -i '/^export PATH=.*/s/$/:\$HADOOP_HOME\/bin:\$HADOOP_HOME\/sbin/' /etc/profile
	fi
	#HADOOP_HOME设置
	grep -q "export HADOOP_HOME=" /etc/profile
	if [ $? -ne 0 ]; then
		#在PATH前面一行插入HADOOP_HOME
		sed -i '/^export PATH=.*/i\export HADOOP_HOME=\/usr\/local\/hadoop' /etc/profile
	else
		#修改文件内的HADOOP_HOME
		sed -i 's/^export HADOOP_HOME=.*/export HADOOP_HOME=\/usr\/local\/hadoop/' /etc/profile
	fi
	source /etc/profile
}

#添加hadoop用户并设置权限
hadoopUserAdd(){
	echo '正在创建hadoop用户....'
	useradd hadoop
	echo '请设置hadoop用户密码....'
	passwd hadoop
	gpasswd -a hadoop root
	chmod 771 /usr
	chmod 771 /usr/local
	chown -R hadoop:hadoop /usr/local/hadoop
}

#单机版hadoop配置
installHadoop(){
	installWget
	wgetHadoop
	pathHadoop
	hadoopUserAdd
}

#伪分布式设置
setHadoop(){
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
 
<!-- Put site-specific property overrides in this file. -->
 
<configuration>
 
	<property>
		<name>hadoop.tmp.dir</name>
		<value>file:/usr/local/hadoop/tmp</value>
		<description>指定hadoop运行时产生文件的存储路径</description>
	</property>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://localhost:9000</value>
		<description>hdfs namenode的通信地址,通信端口</description>
	</property>
 
</configuration>'>$HADOOP_HOME/etc/hadoop/core-site.xml


echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
 
<!-- Put site-specific property overrides in this file. -->
<!-- 该文件指定与HDFS相关的配置信息。
需要修改HDFS默认的块的副本属性，因为HDFS默认情况下每个数据块保存3个副本，
而在伪分布式模式下运行时，由于只有一个数据节点，
所以需要将副本个数改为1；否则Hadoop程序会报错。 -->
 
<configuration>
 
	<property>
		<name>dfs.replication</name>
		<value>1</value>
		<description>指定HDFS存储数据的副本数目，默认情况下是3份</description>
	</property>
	<property>
		<name>dfs.namenode.name.dir</name>
		<value>file:/usr/local/hadoop/hadoopdata/namenode</value>
		<description>namenode存放数据的目录</description>
	</property>
	<property>
		<name>dfs.datanode.data.dir</name>
		<value>file:/usr/local/hadoop/hadoopdata/datanode</value>
		<description>datanode存放block块的目录</description>
	</property>
	<property>
		<name>dfs.permissions.enabled</name>
		<value>false</value>
		<description>关闭权限验证</description>
	</property>
 
</configuration>'>$HADOOP_HOME/etc/hadoop/hdfs-site.xml
	
echo '<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
 
<!-- Put site-specific property overrides in this file. -->
<!-- 在该配置文件中指定与MapReduce作业相关的配置属性，需要指定JobTracker运行的主机地址-->
 
<configuration>
 
	<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
		<description>指定mapreduce运行在yarn上</description>
	</property>
	
</configuration>'>$HADOOP_HOME/etc/hadoop/mapred-site.xml

echo '<?xml version="1.0"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
<configuration>
 
<!-- Site specific YARN configuration properties -->
 
	<property>
		<name>yarn.nodemanager.aux-services</name>
		<value>mapreduce_shuffle</value>
		<description>mapreduce执行shuffle时获取数据的方式</description>
	</property>
 
</configuration>'>$HADOOP_HOME/etc/hadoop/yarn-site.xml

	echo 'localhost'>$HADOOP_HOME/etc/hadoop/slaves
	sed -i 's/export JAVA_HOME=.*/\#&/' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
	sed -i "/#export JAVA_HOME=.*/a export JAVA_HOME=$JAVA_HOME" $HADOOP_HOME/etc/hadoop/hadoop-env.sh
	chown -R hadoop:hadoop $HADOOP_HOME
}

#完全分布式设置
setHadoop2(){
echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
 
<!-- Put site-specific property overrides in this file. -->
 
<configuration>
 
	<property>
		<name>hadoop.tmp.dir</name>
		<value>file:/usr/local/hadoop/tmp</value>
		<description>指定hadoop运行时产生文件的存储路径</description>
	</property>
	<property>
		<name>fs.defaultFS</name>
		<value>hdfs://'$1':9000</value>
		<description>hdfs namenode的通信地址,通信端口</description>
	</property>
 
</configuration>'>$HADOOP_HOME/etc/hadoop/core-site.xml

echo '<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
 
<!-- Put site-specific property overrides in this file. -->
<!-- 该文件指定与HDFS相关的配置信息。
需要修改HDFS默认的块的副本属性，因为HDFS默认情况下每个数据块保存3个副本，
而在伪分布式模式下运行时，由于只有一个数据节点，
所以需要将副本个数改为1；否则Hadoop程序会报错。 -->
 
<configuration>
 
	<property>
		<name>dfs.replication</name>
		<value>3</value>
		<description>指定HDFS存储数据的副本数目，默认情况下是3份</description>
	</property>
	<property>
		<name>dfs.namenode.name.dir</name>
		<value>file:/usr/local/hadoop/hadoopdata/namenode</value>
		<description>namenode存放数据的目录</description>
	</property>
	<property>
		<name>dfs.datanode.data.dir</name>
		<value>file:/usr/local/hadoop/hadoopdata/datanode</value>
		<description>datanode存放block块的目录</description>
	</property>
	<property>
		<name>dfs.secondary.http.address</name>
		<value>'$2':50090</value>
		<description>secondarynamenode 运行节点的信息，和 namenode 不同节点</description>
	</property>
	<property>
		<name>dfs.permissions.enabled</name>
		<value>false</value>
		<description>关闭权限验证</description>
	</property>
 
</configuration>'>$HADOOP_HOME/etc/hadoop/hdfs-site.xml

echo '<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
 
<!-- Put site-specific property overrides in this file. -->
<!-- 在该配置文件中指定与MapReduce作业相关的配置属性，需要指定JobTracker运行的主机地址-->
 
<configuration>
 
	<property>
		<name>mapreduce.framework.name</name>
		<value>yarn</value>
		<description>指定mapreduce运行在yarn上</description>
	</property>
	
</configuration>'>$HADOOP_HOME/etc/hadoop/mapred-site.xml

echo '<?xml version="1.0"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->
<configuration>
 
<!-- Site specific YARN configuration properties -->
	<property>
		<name>yarn.resourcemanager.hostname</name>
		<value>'$1'</value>
		<description>yarn总管理器的IPC通讯地址</description>
	</property>
	<property>
		<name>yarn.nodemanager.aux-services</name>
		<value>mapreduce_shuffle</value>
		<description>mapreduce执行shuffle时获取数据的方式</description>
	</property>
 
</configuration>'>$HADOOP_HOME/etc/hadoop/yarn-site.xml
	rm -rf $HADOOP_HOME/etc/hadoop/slaves
	touch $HADOOP_HOME/etc/hadoop/slaves
	int=0
	while(( ${int}<${#ip_arrays[*]} ))
	do
		#echo "while is run"
		echo "${ip_arrays[$int]}">>$HADOOP_HOME/etc/hadoop/slaves
		if [ $? -ne 0 ]
		then
			echo '写入slaves配置失败'
			break
		fi
		let "int++"
	done
	sed -i 's/export JAVA_HOME=.*/\#&/' $HADOOP_HOME/etc/hadoop/hadoop-env.sh
	sed -i "/#export JAVA_HOME=.*/a export JAVA_HOME=$JAVA_HOME" $HADOOP_HOME/etc/hadoop/hadoop-env.sh
	chown -R hadoop:hadoop $HADOOP_HOME
}

#关闭防火墙
stopFirewalld(){
	systemctl stop firewalld
	systemctl disable firewalld
}

#IP校验,返回值0校验合法，1不合法。
checkIPAddr(){
	echo $1|grep "^[0-9]\{1,3\}\.\([0-9]\{1,3\}\.\)\{2\}[0-9]\{1,3\}$" > /dev/null; 
	#IP地址必须为全数字 
	if [ $? -ne 0 ] 
	then 
		return 1 
	fi 
	ipaddr=$1 
	a=`echo $ipaddr|awk -F . '{print $1}'`  #以"."分隔，取出每个列的值 
	b=`echo $ipaddr|awk -F . '{print $2}'` 
	c=`echo $ipaddr|awk -F . '{print $3}'` 
	d=`echo $ipaddr|awk -F . '{print $4}'` 
	for num in $a $b $c $d 
	do 
		if [ $num -gt 255 ] || [ $num -lt 0 ]    #每个数值必须在0-255之间 
		then 
			return 1 
		fi 
	done 
		return 0 
}

#控制台输入集群IP
ipInput(){
	echo "本机IP地址为：$localIP"
	int=0
	echo '输入完成后，输入ip值为0可退出'
	while read -p "输入第`expr ${int} + 1`台的IP:" ip
	do		
		if [ "$ip" == "0" ]
		then
			break
		fi
		checkIPAddr $ip
		if [ $? -eq 0 ]
		then		
			ip_arrays[$int]=$ip
			#echo $int
		else
			echo '输入的IP不合法,重新进行配置....'
			ipInput
		fi
		let "int++"
	done

}

#scp设置免密登录
scpOutput(){
	int=0
	while(( ${int}<${#ip_arrays[*]} ))
	do
		scp -r ~/.ssh ${ip_arrays[$int]}:~/
	let "int++"
	done
}

#SSH免密登录
setSSH(){
	echo '---------------配置ssh免密登录----------------------'
	echo '------------一路回车即可生成秘钥--------------------'
	ssh-keygen -t rsa
	echo '----------秘钥生成完成，开始生成公钥----------------'
	echo '根据提示输入相应的信息'
	echo '----------------------------------------------------'
	echo 'Are you sure you want to continue connecting (yes/no)?'
	echo '------------------输入"yes"-------------------------'
	echo 'hadoop@localhost s password:'
	echo '--------------输入hadoop用户密码--------------------'	
	ssh-copy-id localhost
}

#控制台选择本机角色
nameOrData(){
	echo '--------------------------'
	echo '1、namenode'
	echo '2、datanode'
	read -p '请选择本机的角色[1-2]:' n
	case $n in
		1)	return 0
		;;
		2)	return 1
		;;
		*)	echo '输入错误！！！'
			nameOrData
		;;
	esac
}

#配置hosts文件
setHosts(){
	echo '开始配置/etc/hosts文件'
	echo '本机IP地址为：'$localIP''
	read -p '请输入本机主机名(hostname):' hostname
	echo -e ''$localIP'\t'$hostname''>>/etc/hosts
	echo '根据提示输入其他主机名(hostname)'
	echo '-----------------------------------'
	int=0
	while(( ${int}<${#ip_arrays[*]} ))
	do
		echo 'IP：'${ip_arrays[$int]}''
		read -p "请输入主机名：" hostname
		echo -e ''${ip_arrays[$int]}'\t'$hostname''>>/etc/hosts
		echo '-----------------------------------'
		let "int++"
	done
}

#1、Java环境一键配置
javaInstall(){
	echo '开始检查本机环境'
	java -version
	if [ $? -ne 0 ]; then
		installWget			
		echo '开始配置JDK，请耐心等待......'
		installJDK
		pathJDK
		java -version
		if [ $? -eq 0 ]; then
			echo 'JDK配置完成'
		else
			echo '安装失败，请重新尝试或手动安装'
		fi
	else
		echo '已经配置该环境'
	fi
}
#2、Hadoop单机版一键安装
hadoopInstall(){
	javaInstall
	echo '开始检查本机环境'
	hadoop
	if [ $? -ne 0 ]; then
		installHadoop
		hadoop
		if [ $? -eq 0 ]; then
			echo 'hadoop单机版配置完成'
		else
			echo '安装失败，请重新尝试或手动安装'
		fi
	else
		echo '已经配置该环境'
	fi
}
#3、Hadoop伪分布式一键安装
hadoopInstall2(){
	javaInstall
	echo '开始检查本机环境'
	hadoop
	if [ $? -ne 0 ]; then
		installHadoop
		hadoop
		if [ $? -eq 0 ]; then
			echo 'hadoop单机版配置完成，开始配置伪分布式'
			setHadoop
			stopFirewalld
			echo '配置完成....使用hadoop用户初始化'
			su hadoop
		else
			echo '安装失败，请重新尝试或手动安装'
		fi
	else
		echo 'hadoop单机版已经安装，开始配置伪分布式'
		setHadoop
		stopFirewalld
		echo '配置完成....使用hadoop用户初始化'
		su hadoop
	fi
}
#4、Hadoop集群部署
hadoopInstall3(){
	nameOrData
	if [ $? -eq 0 ]
	then
		#记录IP
		echo '输入datanode的IP'
		ipInput
		#namenode配置
		#1安装单机版hadoop
		hadoopInstall
		#2导入集群配置文件
		echo '开始导入配置文件'
		setHadoop2 ${localIP} ${ip_arrays[0]}
		echo '配置导入完成'
		#3关闭防火墙
		stopFirewalld
		echo '防火墙已关闭'
		#上传主机配置到datanode
		int=0
		while(( ${int}<${#ip_arrays[*]} ))
		do		
			echo "开始给第`expr ${int} + 1`台datanode传送配置文件和安装包"
			echo "IP为：${ip_arrays[${int}]}"
			echo "传送过程需手动输入远程主机root密码"
			#scp传送安装包
			scp $(pwd)/install.sh ${ip_arrays[$int]}:/usr/local
			scp /usr/local/$(ls | grep 'jdk.*[rpm]$') ${ip_arrays[$int]}:/usr/local
			scp -r /usr/local/hadoop ${ip_arrays[$int]}:/usr/local
			echo "${ip_arrays[$int]}文件上传完成....."
			let "int++"
		done
		setHosts
		echo '请登录datanode主机执行该脚本继续完成datanode配置，脚本存储目录/usr/local'
	elif [ $? -eq 1 ]
	then
		#安装Java
		javaInstall
		#配置Hadoop环境变量
		echo '配置环境变量'
		pathHadoop
		echo '环境变量配置完成'
		#添加用户
		hadoopUserAdd
		#关闭防火墙
		stopFirewalld
		echo '防火墙已关闭'
		source /etc/profile
		echo '测试安装情况.....'
		java -version
		if [ $? -ne 0 ]; then
			echo '请手动执行source /etc/profile'
			echo '执行java -version确认JDK安装情况'
		fi
		hadoop version
		if [ $? -ne 0 ]; then
			echo '请手动执行source /etc/profile'
			echo '执行hadoop version确认hadoop安装情况'
		fi
		echo 'datanode配置完成'
	else
		echo '发生错误！！！'
	fi
}
#6、集群设置SSH免密登录（使用hadoop用户操作）
setSSHS(){
	#本机设置免密
	echo '开始设置本机免密....'
	setSSH
	#输入其他电脑IP
	echo '开始设置其他主机....'
	echo '输入其他主机ip'
	ipInput
	#用scp将秘钥发到其他主机
	echo '开始发送秘钥到其他主机...'
	scpOutput
}
#控制台输入选项
consoleInput(){
	echo '请输入选项[1-4]'
	echo '1、Java环境一键配置'
	echo '2、Hadoop单机版一键安装'
	echo '3、Hadoop伪分布式一键安装'
	echo '4、Hadoop集群部署'
	echo '5、hadoop初始化（在namenode主机上执行）'
	echo '6、集群设置SSH免密登录（使用hadoop用户操作）'
	echo '请输入选项[1-6]'
	read aNum
	case $aNum in
		1)  javaInstall
		;;
		2)  hadoopInstall
		;;
		3)  hadoopInstall2
		;;
		4)  hadoopInstall3
		;;
		5)  echo 'Hadoop初始化'
			hdfs namenode -format
		;;
		6)  setSSHS
		;;
		*)  echo '没有该选项，请重新输入!!!退出请按Ctrl+c'
			consoleInput
		;;
	esac
}
echo '------------------欢迎使用一键安装------------------'
echo '为保证安装过程顺利进行，请使用root用户执行该脚本'
echo '该脚本增加了本地安装包自动安装'
echo '如果需要脚本安装本地安装包，请将安装包放在/usr/local下'
echo 'hadoop安装包要求以hadoop开头的.tar.gz包'
echo 'JDK安装包要求以jdk开头的.rpm包'
echo '----------------------------------------------------'
consoleInput