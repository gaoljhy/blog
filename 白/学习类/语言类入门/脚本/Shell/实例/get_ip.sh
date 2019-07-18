#!/bin/bash
>ip.txt
>/root/.ssh/known_hosts

if [ ! -f ~/.ssh/id_rsa.pub ];then
        ssh-keygen -P "" -f ~/.ssh/id_rsa
        continue
fi
yum -y install expect &>/dev/null


for i in {130..225} {227..250}
do
	{
	ip=10.226.41.$i
	ping -c1 -W1 $ip &>/dev/null
	if [ $? -eq 0 ];then
		echo $ip >> ip.txt
		/usr/bin/expect <<-EOF
		set timeout 10
		spawn ssh-copy-id -i $ip
		expect {
			"*yes/no" { send "yes\r"; exp_continue}
			"*password:" { send "centos\r" }
		}

		expect "#"
		send "exit\r"
		expect eof
		EOF
	fi
	}&
done

wait 
echo "finish...."
