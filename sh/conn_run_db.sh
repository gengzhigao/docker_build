#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
config_file=${basepath}/../config.conf
cont_run_path=${basepath}/tools

function config_conver()
{
	read -p "是否覆盖env目录下的config_single文件到当前目录下的config文件(Y/n)" input
	if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
		\cp env/config.conf-single $config_file
	fi
}

function cont_run()
{
	host=$1
	i=0
	docker_host=`grep ${host}.CONTAINER ${config_file} | awk -F= '{print $2}'`
	images_db=`grep IMAGES_DB ${config_file} | awk -F= '{print $2}'`
	IFS=";"
	arr=($docker_host)
	for container_name in ${arr[@]}
	do
		#images_name 容器对应的镜像名，对应config.conf文件中的 ${container_name}.IMAGES
		images_name=`grep ${container_name}.IMAGES ${config_file} | awk -F= '{print $2}'`
		#container_role 容器对应的角色名，例如，MySQL容器有mysql-1角色和mysql-2角色，不同角色对应conf目录中不同的env_${container_role}.conf文件
		container_role=`grep ${host}.${container_name}.ROLE ${config_file} | awk -F= '{print $2}'`
		#container_path 容器对应的启动目录，标准为"/data/容器对应的镜像名/容器名称"
		container_path="/data"/`echo ${images_name}| tr "[:upper:]" "[:lower:]"`/${container_name}
	
		# 判断容器是否是基础组件，如果不是则跳过
		if [[ ${images_db} != *${images_name}* ]]; then
			continue
		fi 
		read -p "是否解压缩 ${container_name} 容器 data 目录:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			mkdir -p ${container_path}
			tar -xzf ${basepath}/../data/env_`echo ${images_name}| tr "[:upper:]" "[:lower:]"`*.tar.gz -C ${container_path}
			chmod 755 ${container_path}
			chown -R root:root ${container_path}
		fi
		# HADOOP启动需要连接MySQL hive数据库，故延迟启动
		if [ ${container_name} = "HADOOP" ]; then
			\cp ${basepath}/../projects/analyApp-jar-with-dependencies*.jar ${container_path}/analyApp-jar-with-dependencies.jar 
			continue
		fi
		# 启动容器
		tools/cont_run.sh ${container_name} ${container_path} ${container_role}
		let i+=1;
	done
	if [ $i -eq 0 ]; then
		echo "该主机没有任何需要运行的基础组件容器"
	fi
}

function db_install()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要运行基础组件容器，APPCAN产品的运行依赖这些基础"
	echo -e "组件容器"
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

#config_conver
db_install
