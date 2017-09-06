#!/bin/bash
dir_images=./images
function docker_check()
{
    while :
    do
        echo -e "***************************************************************************"
        echo -e "*接下来将要加载docker镜像，请在运行容器之前，\033[31;1m请确保docker已配置为LVM模式，\033[0m*"
        echo -e "*配置文件为/etc/sysconfig/docker*"
        echo -e "***************************************************************************"
        read -p "是否确定docker已配置成LVM模式:(Y/n)" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            systemctl restart docker
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}

function load_images()
{
    while :
    do
        echo -e "***************************************************************************"
        echo -e "*接下来将要加载docker镜像*"
        echo -e "***************************************************************************"
        read -p "是否确定加载docker镜像:(Y/n)" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			#判断镜像是否使用gzip压缩，如果是的话，先解压
			#if [ `find ${dir_images}/ -name "*.gz" | wc -l` -gt 0 ]; then
			#	echo -e "**********开始使用 gunzip 解压 docker 镜像**********"
			#	ls ${dir_images}/*.gz |xargs gunzip
			#fi
			echo -e "**********开始导入 docker 镜像**********"
			cat ${dir_images}/appcan.gfs.0.7.tar.gz | docker import - appcan/gfs:0.7
			cat ${dir_images}/appcan.hadoop.2.5.tar.gz | docker import - appcan/hadoop:2.5
			cat ${dir_images}/appcan.im.1.7.tar.gz | docker import - appcan/im:1.7
			cat ${dir_images}/appcan.mas.baas.1.5.tar.gz | docker import - appcan/mas/baas:1.5
			cat ${dir_images}/appcan.mongo.0.8.tar.gz | docker import - appcan/mongo:0.8
			cat ${dir_images}/appcan.mysql.3.0.tar.gz | docker import - appcan/mysql:3.0
			cat ${dir_images}/appcan.nginx.1.2.tar.gz | docker import - appcan/nginx:1.2
			cat ${dir_images}/appcan.redis.2.0.tar.gz | docker import - appcan/redis:2.0
			cat ${dir_images}/appcan.tomcat7.openoffice.2.2.tar.gz | docker import - appcan/tomcat7/openoffice:2.2
			cat ${dir_images}/appcan.zookeeper.0.7.tar.gz | docker import - appcan/zookeeper:0.7
            docker load < ${dir_images}/appcan.saasoa.00.36.tar.gz
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}
docker_check
load_images
