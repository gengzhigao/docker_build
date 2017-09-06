#!/bin/bash
ulimit -n 655350
source /etc/profile
source /data/env.conf

mkdir -p /data/log/haproxy
mkdir -p /data/log/tigase

if [[ $CONFIG_TIGASE_UPDATE -eq 1 && -f /data/configs/tigase.conf ]]; then
        \cp /data/configs/tigase.conf /data/tigase-server/etc/
fi
if [[ $CONFIG_TIGASE_UPDATE -eq 1 && -f /data/configs/init.properties ]]; then
        \cp /data/configs/init.properties /data/tigase-server/etc/
fi
if [[ $CONFIG_TIGASE_UPDATE -eq 1 && -f /data/configs/init-tigase-plugin.properties ]]; then
        \cp /data/configs/init-tigase-plugin.properties /data/tigase-server/etc/
fi
if [[ $CONFIG_HAPROXY_UPDATE -eq 1 && -f /data/configs/haproxy.cfg ]]; then
        \cp /data/configs/haproxy.cfg /etc/haproxy/haproxy.cfg
fi

service haproxy restart

/data/tigase-server/scripts/tigase.sh restart /data/tigase-server/etc/tigase.conf

echo "完成 IM 启动! 下面开始进入无限循环，请按ctrl + c 退出!"
while true; do
	sleep 3600
done
