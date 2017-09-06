#!/bin/bash
#sync_dir同步目录或者文件，用";"做分割
sync_dir="/root/.ssh;/etc/hosts;/opt/docker"
#sync_dir="/opt/docker/sh/tools/*.sh;/opt/docker/sh/*.sh;/opt/docker/sh/config.conf"
#sync_dir="/opt/docker/projects/tomcat_resource/"
#sync_dir同步服务器,注意,此处不能包含本机,切忌
sync_host="env2;env3;env4;env5;env6"
user=`whoami`

function ssh_keygen()
{
    mkdir -p ~/.ssh
    if [ ! -f "~/.ssh/authorized_keys" ];then
        ssh-keygen -t rsa -f ~/.ssh/id_rsa -P ""
	    cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
    fi
}

function file_sync()
{
    arr_file=($sync_dir)
    arr_host=($sync_host)
    IFS=";"
    for filename in ${arr_file[@]}
    do
        for hostname in ${arr_host[@]}
        do
            scp -r ${filename} $user@$hostname:`dirname ${filename}`/
        done
    done
}

ssh_keygen
file_sync
