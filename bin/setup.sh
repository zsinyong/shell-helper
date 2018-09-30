#!/bin/bash

echo "          ___  ________  ___  __       "
echo "         |\\  \\|\\   ___ \\|\\  \\|\\  \\     "
echo "         \\ \\  \\ \\  \\_|\\ \\ \\  \\//_   "
echo "       __ \\ \\  \\ \\  \\ \\ \\ \\   ___  \\  "
echo "      |\\  \\_\\  \\ \\  \\_\\ \\ \\  \\ \\  \\ "
echo "      \\ \\________\\ \\_______\\ \\__\\ \\__\\"
echo "       \\|________|\\|_______|\\|__| \\|__|"
echo ""
echo ""
echo ""


TEMP_VERSION=`java -version 2>&1 | awk 'NR==1{ gsub(/"/,"");print $3}'`

if [ `java -version 2>&1 | awk 'NR==1{ gsub(/"/,"");print $1}'` = "java"  ];then
	echo "java envirment is install in $JAVA_HOME"
	return 0
fi

echo "Temp java version is $TEMP_VERSION"

JDK_TAR_LOCATION=`sed '/TAR_FILE_LOCATION/!d;s/.*=//' ../conf/env.properties | tr -d '\\r'`
echo $JDK_TAR_LOCATION

SETUP_LOCATION=`sed '/ENV_INSTALL_PATH=/!d;s/.*=//' ../conf/env.properties | tr -d '\\r'`
echo $SETUP_LOCATION

[ ! -d "$SETUP_LOCATION" ] && mkdir $SETUP_LOCATION

echo "Depress $JDK_TAR_LOCATION ...... wati a while!"
for line in $(tar -zxvf $JDK_TAR_LOCATION -C $SETUP_LOCATION)
do
        SETUP_LOCATION=$SETUP_LOCATION$line
        break
done

echo "Script is going to setup the envirment in below path\\n"

echo $SETUP_LOCATION

printf "JAVA_HOME=$SETUP_LOCATION\\n" >> /etc/profile

printf "CLASSPATH=.:$JAVA_HOME/lib.tools.jar\\n" >> /etc/profile

printf "PATH=$JAVA_HOME/bin:$PATH\\n" >> /etc/profile

printf "export JAVA_HOME CLASSPATH PATH\\n" >> /etc/profile

source /etc/profile

`java -version`
