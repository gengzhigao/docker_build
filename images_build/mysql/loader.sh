#!/bin/bash
ulimit -n 100000
source /data/env.conf

if [ ! -d /data/log ]; then
        mkdir -p /data/log
        chown -R mysql:mysql /data/log
fi
if [ ! -f /data/log/mysqld.log ]; then
	touch /data/log/mysqld.log
fi

function initReplication()
{
        echo "START INIT REPLICTION SLAVE"
        mysql -uroot -p${MYSQL_ROOT_PASS} -e "grant replication slave on *.* to dbsync@'%' identified by '${MYSQL_ROOT_PASS}';flush privileges;"
        mysql -uroot -p${MYSQL_ROOT_PASS} -e "grant REPLICATION CLIENT on *.* to temp@'%' identified by '${MYSQL_ROOT_PASS}';flush privileges;"
}

function initMysql(){
        if [ ${MYSQL_IS_FIRST} == 1 ]; then
                \cp /data/configs/mysql/master.cnf /etc/my.cnf
        elif [ ${MYSQL_IS_SECOND} == 1 ]; then
                \cp /data/configs/mysql/slave.cnf /etc/my.cnf
        fi
        service mysqld restart
        mysqladmin -u root password ${MYSQL_ROOT_PASS}
        mysql -uroot -p${MYSQL_ROOT_PASS} -e "grant usage on *.* to haproxy@'%';flush privileges;"
        if [ ${IS_SINGLE} != 1 ]; then
                initReplication
        fi
}

if [ ! -d /data/mysql ]; then
        mkdir -p /data/mysql
        initMysql
else
        echo -e "\n因/data/mysql/MYSQL/mysql目录(操作系统目录)已经存在，系统认为MySQL已经存在，无需初始化，下面启动MySQL"
        service mysqld restart
        echo "MySQL启动成功!"
fi

echo "完成 MySQL 启动! 下面开始进入无限循环，请按ctrl + c 退出!"
while true; do
	sleep 3600
done
