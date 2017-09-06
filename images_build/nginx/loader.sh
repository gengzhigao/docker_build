#!/bin/bash
ulimit -n 655350
source /data/env.conf

mkdir -p /data/nginx/conf.d
mkdir -p /data/log/nginx
mkdir -p /data/log/glusterfs

if [ -f /data/nginx/nginx.conf ]; then
	\cp /data/nginx/nginx.conf /etc/nginx/nginx.conf
fi

# 开始挂载 GFS 存储
if [ -f "/data/check_gfs.sh" ]; then
        \cp /data/check_gfs.sh /opt/
        /opt/check_gfs.sh
elif [ -f "/opt/check_gfs.sh" ]; then
        /opt/check_gfs.sh
fi

service nginx restart

echo "完成 nginx 启动! 下面开始进入无限循环，请按ctrl + c 退出!"
while true; do
	sleep 3600
done
