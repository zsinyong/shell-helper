#!/bin/bash
for line in $(tar -zxvf jdk-8u161-linux-x64.tar.gz)
do
	echo $line
	break
done
