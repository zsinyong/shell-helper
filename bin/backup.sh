#!/bin/bash
echo "Backup profile"
if [ ! -f /etc/profile.jdk.backup ];then
   echo "backup the file /etc/profile as /etc/profile.jdk.profile"
   cp /etc/profile{,.jdk.backup}
fi

echo "Backup time `date`" >> profile.jdk.profile