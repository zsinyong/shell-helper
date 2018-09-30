#!/bin/bash


TEMP_VERSION=`java -version 2>&1 | awk 'NR==1{ gsub(/"/,"");print $3}'`

if [ -z $TEMP_VERSION ]
  return 0
fi

echo "Temp java version is $TEMP_VERSION"

JDK_TAR_LOCATION=`sed '/TAR_FILE_LOCATION/!d;s/.*=//' conf/env.properties | tr -d '\r'`

SETUP_LOCATION=

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
