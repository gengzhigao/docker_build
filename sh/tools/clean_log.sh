#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)
today=`date "+%Y-%m-%d"`

function log_mongo()
{
	log_mongo="/data/mongo/MONGO/mongo/log"
	log_file=mongod.log
	if [ `find . -name ${log_file}_bak_${today}.tar.gz |wc -l` -eq 0 ]; then 
		tar -czvf ${log_file}_bak_`date "+%Y-%m-%d"`.tar.gz ${log_file}
		> ${log_file}
	fi
	find ${log_mongo} -mtime +10 -name "*.*" -exec rm -rf {} \;
}

function log_oa()
{
    log_oa_tomcat="/data/oa/OA/tomcat7/logs"
    log_oa_mas="/data/oa/OA/mas/logs"

    # 清理 OA Tomcat 日志
    cd ${log_oa_tomcat}
    log_file=catalina.out
    if [ `find . -name ${log_file}_bak_${today}.tar.gz |wc -l` -eq 0 ]; then
        tar -czvf ${log_file}_bak_`date "+%Y-%m-%d"`.tar.gz ${log_file}
        > ${log_file}
    fi
    find ${log_oa_tomcat} -mtime +10 -name "*.*" -exec rm -rf {} \;

    # 清理 OA MAS 日志
    cd ${log_oa_mas}
    log_file=EMOA_APP_SERVICE.log
    if [ `find . -name ${log_file}_bak_${today}.tar.gz |wc -l` -eq 0 ]; then
        tar -czvf ${log_file}_bak_`date "+%Y-%m-%d"`.tar.gz ${log_file}
        > ${log_file}
    fi
    log_file=EMOA_CONSOLE.log
    if [ `find . -name ${log_file}_bak_${today}.tar.gz |wc -l` -eq 0 ]; then
        tar -czvf ${log_file}_bak_`date "+%Y-%m-%d"`.tar.gz ${log_file}
        > ${log_file}
    fi
    find ${log_oa_mas} -mtime +10 -name "*.*" -exec rm -rf {} \;
}

function log_tomcat()
{
    log_tomcat_default="/data/tomcat/EMMWEB/log/tomcat"
    log_tomcat_emm="/data/tomcat/EMMWEB/logs"

    # 清理 EMM Tomcat 日志
    find ${log_tomcat_emm} -mtime +10 -name "*.*" -exec rm -rf {} \;

    # 清理标准 Tomcat 日志
    cd ${log_tomcat_default}
    log_file=catalina.out
    if [ `find . -name ${log_file}_bak_${today}.tar.gz |wc -l` -eq 0 ]; then
        tar -czvf ${log_file}_bak_`date "+%Y-%m-%d"`.tar.gz ${log_file}
        > ${log_file}
    fi
    find ${log_tomcat_default} -mtime +10 -name "*.*" -exec rm -rf {} \;
}

function log_nginx()
{
    log_nginx="/data/nginx/NGINX/log/nginx"

    # 清理 Nginx 日志
    cd ${log_nginx}
    for logfile in `ls $log_nginx/*.log`
    do
        log_file=`basename $logfile`
        if [ `find . -name ${log_file}_bak_${today}.tar.gz |wc -l` -eq 0 ]; then
            #echo "tar -czvf ${log_file}_bak_`date "+%Y-%m-%d"`.tar.gz ${log_file}"
            tar -czvf `basename ${log_file}`_bak_`date "+%Y-%m-%d"`.tar.gz `basename ${log_file}`
            > ${log_file}
        fi
    done

    find ${log_nginx} -mtime +10 -name "*.*" -exec rm -rf {} \;
}

function log_emmdback()
{
    log_emmdback="/opt/emm/uploads/emmdback"

    # 清理 SQL 备份文件
    find ${log_emmdback} -mtime +10 -name "*.sql" -exec rm -rf {} \;
}

log_oa
log_tomcat
log_nginx
log_emmdback
