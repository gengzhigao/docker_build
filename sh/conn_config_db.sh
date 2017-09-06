#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
config_file=${basepath}/../config.conf

# 配置mysql集群，导入MySQL数据
function cont_mysql()
{
	source ~/.bashrc
	container_name=$1
	container_role=$2
	echo "${container_name} -->  ${container_role}"
	read -p "是否需要配置 MYSQL 容器:(Y/n)" input
	if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
		if [ ${container_name} = "MYSQL" ] && [ ${container_role} = "mysql-1" ]; then
			docker exec -i ${container_name} /bin/bash <<EOF
				/bin/mysqlcluster.sh
EOF
		elif [ ${container_name} = "MYSQL" ] && [ ${container_role} = "mysql-2" ]; then
			docker exec -i ${container_name} /bin/bash <<EOF
				/bin/mysqlcluster.sh
EOF
			tools/mysql_init_data.sh 
		elif [[ ${container_name} = "MYSQL" && ${container_role} = "single" ]]; then
			tools/mysql_init_data.sh 
		fi
	fi
}

# 配置mongo副本集，导入mongo数据
function cont_mongo()
{

	source ~/.bashrc
	container_name=$1
	container_role=$2
	if [ ${container_name} = "MONGO" ] && [ ${container_role} = "mongo-master" ]; then
		read -p "是否需要配置 MONGO 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			docker exec -i ${container_name} /bin/bash <<EOF
				mongo < /opt/mongoha.script
EOF
		fi
		sleep 30s
        tools/mongo_init_data.sh
    elif [[ ${container_name} = "MONGO" && ${container_role} = "single"  ]]; then
        tools/mongo_init_data.sh
	fi
}

# Hadoop节点3容器启动时，需要连接MySQL数据库，故此处延迟启动，等待MySQL初始化完毕
function cont_hadoop()
{
	source ~/.bashrc
	container_name=$1
	container_role=$2
	container_path=$3
	if [[ ${container_name} = "HADOOP" ]]; then
		tools/cont_run.sh ${container_name} ${container_path} ${container_role}
	fi
}

# 配置容器启动
function cont_config()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要配置docker容器，初始化数据等"
	echo -e "**************************************************"
	while :
	do
		read -p "请输入需要安装的机器角色名，通常为ENV1、ENV2等等，输入的名称需与config.conf文件一致:" input
		if [ "$input" = "" ]; then
			echo "抱歉,您没有输入任何主机角色"
			continue
		else
			i=0
			host=`echo $input | tr "[:lower:]" "[:upper:]"`
			echo "您输入的主机角色为:$host"
			docker_host=`grep ${host}.CONTAINER ${config_file} | awk -F= '{print $2}'`
			IFS=";"
			arr=($docker_host)
			for container_name in ${arr[@]}
			do
				images_name=`grep ${container_name}.IMAGES ${config_file} | awk -F= '{print $2}'`
				container_role=`grep ${host}.${container_name}.ROLE ${config_file} | awk -F= '{print $2}'`
				container_path="/data"/`echo ${images_name}| tr "[:upper:]" "[:lower:]"`/${container_name}

				if [ ${container_name} = "MYSQL" ]; then
					cont_mysql ${container_name} ${container_role}
					let i+=1;
				elif [ ${container_name} = "MONGO" ]; then
					cont_mongo ${container_name} ${container_role}
					let i+=1;
				elif [[ ${container_name} = "HADOOP" ]]; then
					cont_hadoop ${container_name} ${container_role} ${container_path}
					let i+=1;
				fi
			done
			if [ $i -eq 0 ]; then
				echo "该主机没有任何需要配置的基础组件容器"
			fi
			break 
		fi      
	done
}

cont_config
