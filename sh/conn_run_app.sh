#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
config_file=${basepath}/../config.conf

function cont_run()
{
	host=$1
	docker_host=`grep ${host}.CONTAINER ${config_file} | awk -F= '{print $2}'`
	images_app=`grep IMAGES_APP ${config_file} | awk -F= '{print $2}'`
	IFS=";"
	arr=($docker_host)
	for container_name in ${arr[@]}
	do
		# images_name 容器对应的镜像名，对应config.conf文件中的 ${container_name}.IMAGES
		images_name=`grep ${container_name}.IMAGES ${config_file} | awk -F= '{print $2}'`
		# container_role 容器对应的角色名，例如，MySQL容器有mysql-1角色和mysql-2角色，不同角色对应conf目录中不同的env_${container_role}.conf文件
		container_role=`grep ${host}.${container_name}.ROLE ${config_file} | awk -F= '{print $2}'`
		# container_path 容器对应的启动目录，标准为"/data/容器对应的镜像名/容器名称"
		container_path="/data"/`echo ${images_name}| tr "[:upper:]" "[:lower:]"`/${container_name}
	
		# 判断容器是否是基础组件，如果不是则跳过
		if [[ ${images_app} != *${images_name}* ]]; then
			continue
		fi 
		read -p "是否解压缩 ${container_name} 容器 data 目录:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			mkdir -p ${container_path}
			tar -xzf ${basepath}/../data/env_`echo ${images_name}| tr "[:upper:]" "[:lower:]"`*.tar.gz -C ${container_path}
			chown -R root:root ${container_path}/../
		fi
		# 针对主机存在 mas 或者 tomcat 或者 nginx 等需要使用到 GFS 镜像的容器，拷贝一份 check_gfs 到本地
		#if [ ${images_name} == "MAS" ] || [ ${images_name} == "TOMCAT" ] ||[ ${images_name} == "NGINX" ]; then
		#	\cp ${basepath}/tools/check_gfs.sh ${container_path}/
		#fi
		# 针对主机存在 tomcat 镜像的机器，在操作系统安装共享文件夹，一边调整mam.properties和创建ca证书等
		#if [ ${images_name} == "TOMCAT" ]; then
		#	${basepath}/tools/os_client.sh
		#fi
		# 启动容器
		tools/cont_run.sh ${container_name} ${container_path} ${container_role}
		# 针对主机存在 IM 镜像的机器，在操作系统执行数据库更新脚本
		#if [ ${images_name} == "IM" ]; then
		#	${container_path}/mysql_update.sh
		#fi
	done
}

function app_install()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要运行应用容器，APPCAN产品将依赖这些容器对外提供"
	echo -e "服务"
	echo -e "**************************************************"
	while :
	do
		read -p "请输入需要安装的机器角色名，通常为ENV1、ENV2等等，输入的名称需与config.conf文件一致:" input
		if [ "$input" = "" ]; then
			echo "抱歉,您没有输入任何主机角色"
			continue
		else
			host=`echo $input | tr "[:lower:]" "[:upper:]"`
			echo "您输入的主机角色为:$host"
			cont_run $host
			break 
		fi        
	done
}
app_install
