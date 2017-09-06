#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
emm_home=/opt/emm
dir_gluster_cli=/opt/emm
dir_source_mam=${basepath}/resource
IPaddress=''

function update_mam()
{
	echo -e "**************************************************"
	echo -e "*tomcat的网络配置与本机IP相关，请选择实际提供服务的"
	echo -e "*网卡，使安装程序可以获取到正确的IP"
	echo -e "**************************************************"
	while : 
	do
		read -p "是否需要修改mam.properties(Y/n):" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始修改mam.properties文件"
			input="enp0s3"
			IPaddress=`LANG=C ifconfig ${input} | awk '/inet /{ print $2 }'`
			if [ "$IPaddress" == "" ]; then
				read -p "获取不到网址IP，请手工输入对外服务IP地址或域名:" input
				if [ "$input" == "" ]; then
					echo "您没有输入任何IP，请重新开始"
					continue
				fi
			else
				read -p "配置访问EMMWEB对应的IP地址或域名${IPaddress}:" input
			fi
			if [ "$input" == "" ]; then
				input=$IPaddress
			fi
			if [[ ! -f ${emm_home}/mam.properties && -f ${dir_source_mam}/mam.properties ]]; then
				echo "${emm_home}/mam.properties文件目前不存在，故在设置前会自动拷贝一份mam.properties"
				cp -p ${dir_source_mam}/mam.properties ${emm_home}/mam.properties
				chmod 755 ${emm_home}/mam.properties
			fi
			if [[ ! -f ${emm_home}/url.properties && -f ${dir_source_mam}/url.properties ]]; then
				\cp ${dir_source_mam}/url.properties ${emm_home}/url.properties
				\cp ${dir_source_mam}/common-config.jar ${emm_home}/common-config.jar
			fi

			echo "下面开始设置mam.properties，将127.0.0.1更换为实际IP${input}"
			sed -i "s/zymobi-outerNginxServer/$input/g" ${dir_gluster_cli}/*.properties
			sed -i "s/zymobi-consoleServer/$input/g" ${dir_gluster_cli}/*.properties
			if [ -f ${emm_home}/url.properties ]; then
				cd ${emm_home}
				jar uf common-config.jar url.properties
			fi
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
		echo ""
	done
}

function cover_mam()
{
	echo -e "**************************************************"
	echo -e "*接下来开始将共享目录下的/opt/emm/common-config.jar或者"
	echo -e "*mam.properties文件同步到所有tomcat工程下"
	echo -e "**************************************************"
	tomcat_home=${basepath}/tomcat/emm
	properties_path=/opt/emm
	chmod 755 $properties_path/mam.properties
	# for filename in `ls -l $path | awk '/^d/{print $NF}'`
	for filename in `ls -d $tomcat_home/*/`
	do
		if [[ -d "${filename}WEB-INF/classes" && -f $properties_path/mam.properties ]]; then
			\cp -p $properties_path/mam.properties ${filename}WEB-INF/classes/
			echo "复制 $properties_path/mam.properties到 ${filename}WEB-INF/classes/"
		elif [[ -d "${filename}WEB-INF/classes" && -f $properties_path/common-config.jar ]]; then
			cd ${emm_home}
			jar uf common-config.jar url.properties
			if [ -f ${filename}WEB-INF/lib/common-config.jar ]; then
				rm -rf ${filename}WEB-INF/lib/common-config.jar
				#\cp $properties_path/common-config.jar ${filename}WEB-INF/lib/common-config.jar
			fi
			unzip -qo $properties_path/common-config.jar -d ${filename}WEB-INF/classes/
			echo "解压缩 $properties_path/common-config.jar到 ${filename}WEB-INF/classes/"
		else
			echo "${filename}WEB-INF/lib 不存在"
		fi
	done
}

update_mam
cover_mam
