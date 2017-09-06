#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
CHECK_TIME=100
GFS_COUNT=1

if [ -f "/data/env.conf" ]; then
	source /data/env.conf	
else
	source ${basepath}/env.conf
fi

if [ ! -d "/opt/emm" ]; then
	mkdir -p /opt/emm
fi

function check_gfs_helth() 
{
	GFS_COUNT=`df -m |grep datastore |wc -l`
	return $GFS_COUNT
}

while [ $CHECK_TIME -ne 0 ]
do
	let "CHECK_TIME -= 1"
	echo -e "开始倒数第 $CHECK_TIME 次进行检查，挂载量为 \c"
	check_gfs_helth
	echo "$GFS_COUNT"
	if [ $GFS_COUNT -eq 0 ]; then
		if [ ${IS_SINGLE} == 1 ]; then
			mount -t glusterfs gfs-master:datastore  /opt/emm
		else
			glusterfs -f /etc/glusterfs/datastore.vol --log-file=/data/log/glusterfs/glusterfs.log /opt/emm
		fi
		sleep 10s
		#exit 1
	fi
	if [ $GFS_COUNT -eq 1 ]; then
		# echo "$CHECK_TIME"
		echo "GFS已经正常挂载"
		exit 1
	fi
done

