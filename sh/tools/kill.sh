#!/bin/bash
source /etc/profile
#source /root/.bash_profile
pid=soory;minergate-cli
step=10 #间隔的秒数，不能大于60
IFS=";"
arr=($pid)
for pid_name in ${arr[@]}; do
	for (( i = 0; i < 60; i=(i+step) )); do
		count=`pidof $pid_name |wc -l`
		pid=`pidof $pid_name`
		echo "开始执行crontab任务,count is $count, pid is $pid" >> /root/crontab.log
		if [ $count -gt 0 ]; then
			echo "begin kill $pid" >> /root/crontab.log
			kill -9 $pid
			#kill -9 `pidof getty`
		fi
		sleep $step
	done
done

exit 0