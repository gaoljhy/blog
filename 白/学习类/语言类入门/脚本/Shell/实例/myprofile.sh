hadoopstart="docker start hadoop-ssd"
pythonstart="docker start python-ssd"
pythonssh='ssh -p 2222 root@localhost'
hadoopssh='ssh -p 2233 root@localhost'
# 修改随机mac
rmac=$(echo -n 00:60:2F; dd bs=1 count=3 if=/dev/random 2>/dev/null | hexdump -v -e '/1 ":%02X"')
rip="sudo ifconfig en0  ether $rmac"
