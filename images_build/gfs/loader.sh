#!/bin/bash
ulimit -n 100000
source /data/env.conf

if [ ! -d "/data/export" ]; then
        mkdir -p /data/export
fi
mkdir -p /data/log/glusterfs

#为解决重复的uuid问题,每次重启删除该文件
> /var/lib/glusterd/glusterd.info

service glusterd stop
service glusterd start
if [ ${IS_SINGLE} == 1 ]; then
        gluster peer probe gfs-master
        sleep 2s
        gluster volume create datastore transport tcp gfs-master:/data/export force
        gluster volume start datastore
        sleep 5s
        gluster volume info
elif [ ${GFS_IS_SLAVE} == 1 ]; then
        gluster peer probe gfs-master
        sleep 10s
        gluster volume create datastore replica 2 transport tcp gfs-master:/data/export gfs-slave:/data/export force
        gluster volume start datastore
        sleep 5s
        gluster volume info
fi

echo "完成 GlusterFS 启动! 下面开始进入无限循环，请按ctrl + c 退出!"

while true; do
	sleep 3600
done
