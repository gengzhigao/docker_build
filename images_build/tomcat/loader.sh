#!/bin/bash
ulimit -n 100000
source /data/env.conf
basepath="/data"
TOMCAT_HOME=/usr/share/apache-tomcat-7.0.70

# 创建目录
mkdir -p /data/log/glusterfs/
mkdir -p /data/log/haproxy
mkdir -p /data/log/tomcat
mkdir -p $TOMCAT_HOME/.dubbo
chmod a+w /data/log
mkdir -p /data/logs
chown -R tomcat:tomcat /data/log/tomcat
chown -R tomcat:tomcat /data/logs

# 开始挂载 GFS 存储
mkdir -p /opt/emm
if [ -f "/data/check_gfs.sh" ]; then
	\cp /data/check_gfs.sh /opt/
	/opt/check_gfs.sh
elif [ -f "/opt/check_gfs.sh" ]; then
	/opt/check_gfs.sh
fi

# 配置/opt/emm共享存储
if [ ! -f /opt/emm/mam.properties ]; then
	cp /data/resource/mam.properties /opt/emm
fi
mkdir -p /opt/emm/uploads/license
chown -R tomcat:tomcat /opt/emm

# 拷贝配置文件到tomcat目录下
mkdir -p ${TOMCAT_HOME}/conf/Catalina/localhost/
rm -rf ${TOMCAT_HOME}/conf/Catalina/localhost/*
if [[ ${EMM_WEB_SERVER} == 1 && -d ${basepath}/configs/projects/emmweb && `ls ${basepath}/configs/projects/emmweb |wc -l` -gt 0 ]]; then
	cp ${basepath}/configs/projects/emmweb/* ${TOMCAT_HOME}/conf/Catalina/localhost
	#cd /opt/openoffice.org3/program
	#soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard &
fi

if [[ ${EMM_IN_SERVER} == 1 && -d ${basepath}/configs/projects/emmin && `ls ${basepath}/configs/projects/emmin |wc -l` -gt 0 ]]; then
	cp ${basepath}/configs/projects/emmin/* ${TOMCAT_HOME}/conf/Catalina/localhost
fi

if [[ ${EMM_ANALYWEB_SERVER} == 1 && -d ${basepath}/configs/projects/analyWeb && `ls ${basepath}/configs/projects/analyWeb |wc -l` -gt 0 ]]; then
	cp ${basepath}/configs/projects/analyWeb/* ${TOMCAT_HOME}/conf/Catalina/localhost
fi

if [[ ${EMM_ANALYIN_SERVER} == 1 && -d ${basepath}/configs/projects/analyIn && `ls ${basepath}/configs/projects/analyIn |wc -l` -gt 0 ]]; then
	cp ${basepath}/configs/projects/analyIn/* ${TOMCAT_HOME}/conf/Catalina/localhost
fi

if [[ ${OTHER} == 1 && -d ${basepath}/configs/projects/other && `ls ${basepath}/configs/projects/other |wc -l` -gt 0 ]]; then
	cp ${basepath}/configs/projects/other/* ${TOMCAT_HOME}/conf/Catalina/localhost
fi

# 覆盖 TOMCAT 配置文件
if [[ -d ${basepath}/configs/tomcat/ && `ls ${basepath}/configs/tomcat |wc -l` -gt 0 ]]; then
	\cp ${basepath}/configs/tomcat/* ${TOMCAT_HOME}/conf/
fi

# 覆盖 HAPROXY 配置文件
if [[ ${IS_SINGLE} == 1 && -d ${basepath}/configs/haproxy/ && `ls ${basepath}/configs/haproxy |wc -l` -gt 0 ]]; then
	\cp ${basepath}/configs/haproxy/haproxy-single.cfg /etc/haproxy/haproxy.cfg
elif [[ ${IS_SINGLE} == 1 ]]; then
	\cp /etc/haproxy/haproxy-single.cfg /etc/haproxy/haproxy.cfg
elif [[ -d ${basepath}/configs/haproxy/ && `ls ${basepath}/configs/haproxy |wc -l` -gt 0 ]]; then
	\cp ${basepath}/configs/haproxy/haproxy-cluster.cfg /etc/haproxy/haproxy.cfg
else
	\cp /etc/haproxy/haproxy-cluster.cfg /etc/haproxy/haproxy.cfg
fi

# Start Haproxy
service haproxy restart

# Start Tomcat7
service tomcat7 restart
echo "完成 Tomcat 启动! 下面开始进入无限循环，请按ctrl + c 退出!"

while true; do
    sleep 3600
done
