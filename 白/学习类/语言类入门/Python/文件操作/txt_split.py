#!/usr/bin/python
# -*- coding: utf-8 -*-
 
import os
 
def split_file(filename,size):
	fp=open(filename,'rb')
	i=0
	n=0
	dir_put='split_dir/'
	if os.path.isdir(dir_put):
		pass
	else:
		os.mkdir(dir_put)
	filename_front=os.path.splitext(filename)[0]   #取到除去扩展名的文件名
	temp=open(dir_put+filename_front+'.part'+str(i)+'.txt','wb')
	buf=fp.read(1024)
	while 1:
		temp.write(buf)
		buf=fp.read(1024)
		if buf=='':
			print filename_front+'.part'+str(i)+'.txt'
			temp.close()
			fp.close()
			return
		n+=1
		if n==size:
			n=0
			print filename_front+'.part'+str(i)+'.txt'
			i+=1
			temp.close()
			temp=open(dir_put+filename_front+'.part'+str(i)+'.txt','wb')
	fp.close()
 
if __name__=='__main__':
	filename=raw_input("enter filename:")
	size=int(raw_input("enter size: (K)"))   #注意转换为int，否则无效
	split_file(filename,size)  #第二个参数的单位是k