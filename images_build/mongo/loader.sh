#!/bin/bash
ulimit -n 100000
source /etc/profile
source /data/env.conf

if [ ! -d "/data/mongo" ]; then
        mkdir -p /data/mongo/log
        mkdir -p /data/mongo
        chown -R mongod:mongod /data/mongo
fi

if [ ${IS_SINGLE} == 1 ] && [ -f /data/configs/mongo/mongod_single.conf ]; then
        \cp /data/configs/mongo/mongod_single.conf /etc/mongod.conf
else
        \cp /data/configs/mongo/mongod.conf /etc/mongod.conf
fi

service mongod restart

echo "完成 mongo 启动! 下面开始进入无限循环，请按ctrl + c 退出!"
while true; do
	sleep 3600
done
