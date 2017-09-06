#!/bin/bash
ulimit -n 100000
source /data/env.conf

mkdir -p /data/log

OPTIONS=""

if [ -f /data/redis.conf ]; then
	\cp /data/redis.conf /etc/redis.conf
else
	\cp /etc/redis.conf_init /etc/redis.conf
fi

if [ ${REDIS_MAX_CLIENTS} ]; then
	OPTIONS="${OPTIONS} --maxclients ${REDIS_MAX_CLIENTS}"
fi

if [ ${REDIS_MAX_MEMORY} ]; then
	OPTIONS="${OPTIONS} --maxmemory ${REDIS_MAX_MEMORY}"
fi

if [ ${REDIS_PASS} ]; then
	OPTIONS="${OPTIONS} --requirepass ${REDIS_PASS} --masterauth ${REDIS_PASS}"
fi

if [ ${REDIS_IP} ]; then
	OPTIONS="${OPTIONS} --bind ${REDIS_IP}"
fi

if [ ${REDIS_PORT} ]; then
	OPTIONS="${OPTIONS} --port ${REDIS_PORT}"
fi

echo ${REDIS_SLAVE_OF_IP}  ${REDIS_SLAVE_OF_PORT}

if [ ${IS_SINGLE} != 1 ] && [ ${REDIS_SLAVE_OF_IP} ] && [ ${REDIS_SLAVE_OF_PORT} ]; then
	OPTIONS="${OPTIONS} --slaveof ${REDIS_SLAVE_OF_IP} ${REDIS_SLAVE_OF_PORT}"
fi

echo "redis-server /etc/redis.conf ${OPTIONS}"

redis-server /etc/redis.conf ${OPTIONS}

if [ ${IS_SINGLE} != 1 ]; then
	if [ ${REDIS_SLAVE_OF_IP} ] && [ ${REDIS_SLAVE_OF_PORT} ]; then
		echo "port 2${REDIS_PORT}" > /etc/sentinel.conf
		echo "daemonize yes" >> /etc/sentinel.conf
		echo "sentinel monitor mymaster ${REDIS_SLAVE_OF_IP} ${REDIS_SLAVE_OF_PORT} 2" >> /etc/sentinel.conf
		echo "sentinel down-after-milliseconds mymaster 5000" >> /etc/sentinel.conf
		echo "sentinel failover-timeout mymaster 5000" >> /etc/sentinel.conf
		echo "sentinel auth-pass mymaster ${REDIS_PASS}" >> /etc/sentinel.conf
		echo "logfile /data/log/sentinel.log" >> /etc/sentinel.conf
		redis-server /etc/sentinel.conf --sentinel
	else
		echo "port 2${REDIS_PORT}" > /etc/sentinel.conf
                echo "daemonize yes" >> /etc/sentinel.conf
		echo "sentinel monitor mymaster ${REDIS_IP} ${REDIS_PORT} 2" >> /etc/sentinel.conf
		echo "sentinel down-after-milliseconds mymaster 5000" >> /etc/sentinel.conf
		echo "sentinel failover-timeout mymaster 5000" >> /etc/sentinel.conf
		echo "sentinel auth-pass mymaster ${REDIS_PASS}" >> /etc/sentinel.conf
		echo "logfile /data/log/sentinel.log" >> /etc/sentinel.conf
		redis-server /etc/sentinel.conf --sentinel
	fi
fi

echo "完成 redis 启动! 下面开始进入无限循环，请按ctrl + c 退出!"
while true; do
	sleep 3600
done
