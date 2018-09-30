#!/bin/bash

TEMP_VERSION=`java -version 2>&1 | awk 'NR==1{ gsub(/"/,"");print $3}'`
#tar name
JDK_FILE_NAME=jdk1.8.0_161
#tar.gz file location
JDK_TAR_LOCATION=./jdk-8u161-linux-x64.tar.gz
#where to install the jdk
SETUP_LOCATION=/usr/local/jdk

tar -zvxf $JDK_TAR_LOCATION -C $SETUP_LOCATION

JAVA_HOME=$SETUP_LOCATION/$
printf "JAVA_HOME=$JAVA_HOME\n" >> /etc/profile
printf "CLASSPATH=.:$JAVA_HOME/lib.tools.jar\n" >> /etc/profile
printf "PATH=$JAVA_HOME/bin:$PATH\n" >> /etc/profile
printf "export JAVA_HOME CLASSPATH PATH\n" >> /etc/profile
printf "`date`:" | tee -a log.log
source /etc/profile
NEW_JAVA_VERSION=`java -version 2>&1 | awk 'NR==1{ gsub(/"/,"");print $3}'`
printf "$NEW_JAVA_VERSION\n" | tee -a log.log
printf "$OLD_JAVA_VERSION\n" | tee -a log.log
if [ $NEW_JAVA_VERSION = $OLD_JAVA_VERSION ]
then
	printf "JDK installed successfully\n"
else
	printf "Can not applied the jdk"
	return 1;
fi
source /etc/profile
