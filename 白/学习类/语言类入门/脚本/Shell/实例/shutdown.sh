#!/bin/bash

for i in {130..225} {227..250}
do
	{
		ip=10.226.41.$i	
		set timeout 10
		ssh root@$ip 'init 0'
	}&
done

echo "finish...."
