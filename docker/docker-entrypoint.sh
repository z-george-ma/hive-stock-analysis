#!/bin/sh
source /root/.bashrc
hdfs namenode -format
/usr/sbin/sshd
start-dfs.sh
start-yarn.sh
#schematool -initSchema -dbType derby
exec /usr/bin/bash "$@"