#!/bin/bash
# basepath 当前脚本所在目录
basepath=$(cd `dirname $0`; pwd)
dir_data=/data
config_file=${basepath}/../../config.conf

function check_docker()
{
	echo -e "***************************************************************************"
	echo -e "*接下来将要运行docker容器，请在运行容器之前，\033[31;1m请确保docker已配置为LVM模式，\033[0m*"
	echo -e "*配置文件为/etc/sysconfig/docker*"
	echo -e "***************************************************************************"
	while :
	do
		read -p "是否确定docker已配置成LVM模式:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			#systemctl restart docker
			echo "下面开始启动docker容器："
		fi  
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi  
	done
} 

function cont_mas()
{
    name=$1
    if [ ! $name ]; then
        name="BAASADMIN"
    fi
    echo -e "**************************************************"
    echo -e "*接下来将要运行 $name 容器"
    echo -e "**************************************************"
    while :
    do
        read -p "是否需要运行 $name 容器:(Y/n)" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            echo "-----------------下面开始运行 $name 容器-------------------"
            cont_path="/data/mas/BAASADMIN"
            if [ $2 ]; then
                cont_path=$2
            fi
            role=$3
            if [ ! $3 ]; then
                role="single"
            fi
            # 针对主机存在 mas 或者 tomcat 或者 nginx 等需要使用到 GFS 镜像的容器，拷贝一份 check_gfs 到本地
			\cp ${basepath}/check_gfs.sh ${cont_path}/
            echo "role------------->$role"
            # 根据角色是否存在，判断是单机还是集群，分别解压不同的文件
            if [ ! -d ${cont_path}/MASProjects ] || [ `ls ${cont_path}/MASProjects | wc -l` == 0 ]; then
                # 判断压缩包是否包含MASProjects，包含则解压到对应的目录下
                if [[ `tar -tvf ${basepath}/../../projects/MASProjects*$role*.tar.gz |grep "MASProjects" |wc -l` -eq 0 ]]; then
                    mkdir -p ${cont_path}/MASProjects
                    tar -xzf ${basepath}/../../projects/MASProjects*${role}*.tar.gz -C ${cont_path}/MASProjects
                else
                    tar -xzf ${basepath}/../../projects/MASProjects*${role}*.tar.gz -C ${cont_path}
                fi
                echo "---------------------解压后的目录如下---------------------:"
                ls ${cont_path}/MASProjects
            fi
            chown -R root:root ${cont_path}
            #根据角色为baasin-*或者baasadmin，拷贝对应的env文件
            if [ -f ${cont_path}/configs/env/env_$role.conf ]; then
                \cp ${cont_path}/configs/env/env_$role.conf ${cont_path}/env.conf
            fi
            echo "-----------------下面开始启动 $name 容器-------------------"
            ${cont_path}/start.sh $name
            echo "----------------- $name 容器启动完毕-------------------"
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}

function cont_im()
{
	name=$1
	if [ ! $name ]; then
		name="IM"
	fi
	echo -e "**************************************************"
	echo -e "*接下来将要运行 $name 容器"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要运行 $name 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            echo "-----------------下面开始运行 $name 容器-------------------"
            cont_path="/data/im/IM"
            if [ $2 ]; then
                cont_path=$2
            fi            
            role=$3
            if [ ! $3 ]; then
                role="single"
            fi
            if [ `find ${basepath}/../../projects/ -name "*tigase-server*.tar.gz" |wc -l` -gt 0 ]; then
                # 判断压缩包是否包含 tigase-server，包含则解压到对应的目录下
                echo "------------>tigase.tar------->"
                if [[ `tar -tvf ${basepath}/../../projects/tigase-server*.tar.gz |grep "tigase-server" |wc -l` -eq 0 ]]; then
                    mkdir -p ${cont_path}/tigase-server
                    tar -xzvf ${basepath}/../../projects/tigase-server*.tar.gz -C ${cont_path}/tigase-server
                else
                    tar -xzvf ${basepath}/../../projects/tigase-server*.tar.gz -C ${cont_path}
                fi
            elif [[ `find ${basepath}/../../projects/ -name "tigase-server*.zip" |wc -l` > 0 ]]; then
                # 判断压缩包是否包含 tigase-server，包含则解压到对应的目录下
                echo "------------>tigase.zip------->"
                if [[ `unzip -v ${basepath}/../../projects/tigase-server*.zip |grep "tigase-server" |wc -l` -eq 0 ]]; then
                    mkdir -p ${cont_path}/tigase-server
                    unzip ${basepath}/../../projects/tigase-server*.zip -d ${cont_path}/tigase-server
                else
                    unzip ${basepath}/../../projects/tigase-server*.zip -d ${cont_path}
                fi
            fi
            chown -R root:root ${cont_path}
            find ${cont_path} -name "*.sh" |xargs chmod +x
            ${cont_path}/start.sh $name
			# 针对主机存在 IM 镜像的机器，在操作系统执行数据库更新脚本
			${cont_path}/mysql_update.sh
            echo "----------------- $name 容器启动完毕-------------------"
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function cont_tomcat()
{
	name=$1
	if [ ! $name ]; then
		name="EMMWEB"
	fi
	echo -e "**************************************************"
	echo -e "*接下来将要运行 $name 容器"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要运行 $name 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始运行 $name 容器-------------------"
			cont_path="/data/tomcat/$name"
			if [ $2 ]; then
				cont_path=$2
			fi         
            role=$3
            if [ ! $3 ]; then
                role="single"
            fi
			# 针对主机存在 mas 或者 tomcat 或者 nginx 等需要使用到 GFS 镜像的容器，拷贝一份 check_gfs 到本地
			\cp ${basepath}/check_gfs.sh ${cont_path}/
			# 针对主机存在 tomcat 镜像的机器，在操作系统安装共享文件夹，一边调整mam.properties和创建ca证书等
			${basepath}/os_client.sh
			#根据角色为emmin-*或者emmweb，拷贝对应的env文件
			if [[ $role && $role == emmin* ]]; then
				\cp ${cont_path}/configs/env/env_emmin.conf ${cont_path}/env.conf
			elif [[ $role && $role == emmweb ]]; then
				\cp ${cont_path}/configs/env/env_emmweb.conf ${cont_path}/env.conf
			else
				\cp ${cont_path}/configs/env/env_single.conf ${cont_path}/env.conf
			fi			
			mkdir -p ${cont_path}/resource/
			if [ `ls "${cont_path}/resource/" |wc -l` == 0  ]; then
				echo "*******下面开始拷贝emmweb工程war包到/data/tomcat/EMMWEB/resource/目录******"	
				source ${cont_path}/env.conf
				if [[ ${EMM_WEB_SERVER} == 1 ]]; then
					# 3.4.0.6已删除该包
					if [ -f ${basepath}/../../projects/tomcat_resource/baas*.war ]; then
						cp ${basepath}/../../projects/tomcat_resource/baas*.war ${cont_path}/resource/
					fi
					cp ${basepath}/../../projects/tomcat_resource/emm-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mam-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mcm-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mdm-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mem-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mum-*.war ${cont_path}/resource/
					# 3.4.0.6已删除该包
					if [ -f ${basepath}/../../projects/tomcat_resource/pcstore-*.war ]; then
						cp ${basepath}/../../projects/tomcat_resource/pcstore-*.war ${cont_path}/resource/
					fi
					cp ${basepath}/../../projects/tomcat_resource/publish*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/*sso*.war ${cont_path}/resource/
				fi
				if [[ ${EMM_IN_SERVER} == 1 ]]; then
					cp ${basepath}/../../projects/tomcat_resource/appIn*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/tigase-im*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mcmIn-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/mdmIn-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/memIn-*.war ${cont_path}/resource/
					# 3.4.0.6已删除该包
					if [ -f ${basepath}/../../projects/tomcat_resource/mumIn-*.war ]; then
						cp ${basepath}/../../projects/tomcat_resource/mumIn-*.war ${cont_path}/resource/
					fi
					cp ${basepath}/../../projects/tomcat_resource/storeIn-*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/v4-*.war ${cont_path}/resource/
				fi
				if [[ ${EMM_ANALYWEB_SERVER} == 1 ]]; then
					cp ${basepath}/../../projects/tomcat_resource/analyWeb*.war ${cont_path}/resource/
					cp ${basepath}/../../projects/tomcat_resource/analyServer*.war ${cont_path}/resource/
				fi
				if [[ ${EMM_ANALYIN_SERVER} == 1 ]]; then
					cp ${basepath}/../../projects/tomcat_resource/analyIn*.war ${cont_path}/resource/
				fi
				cp ${basepath}/../../projects/tomcat_resource/*.properties ${cont_path}/resource/
				# cp ${basepath}/../../projects/tomcat_resource/common-config*.jar ${cont_path}/resource/common-config.jar
				echo "*****************************工程war包拷贝完毕*****************************"
			fi
			echo "******************************开始解压缩war包******************************"
			${cont_path}/install*.sh
			${cont_path}/updatemam.sh
			echo "******************************解压缩war包完毕******************************"

			${cont_path}/start.sh $name
			echo "----------------- $name 容器启动完毕-------------------"
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function cont_nginx()
{
    name=$1
    if [ ! $name ]; then
        name="NGINX"
    fi
	echo -e "**************************************************"
	echo -e "*接下来将要运行 $name 容器"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要运行 $name 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始运行 $name 容器-------------------"
			cont_path="/data/nginx/$name"
			if [ $2 ]; then
				cont_path=$2
			fi        
            role=$3
            if [ ! $3 ]; then
                role="single"
            fi
            # 针对主机存在 mas 或者 tomcat 或者 nginx 等需要使用到 GFS 镜像的容器，拷贝一份 check_gfs 到本地
			\cp ${basepath}/check_gfs.sh ${cont_path}/
			${cont_path}/updateconf.sh
			# 根据container_role，覆盖相关的配置文件到env.conf文件，单机直接拷贝env_single文件
            if [[ $role && $role != "single" && $role != "SINGLE" ]]; then
                if [ -f ${cont_path}/configs/env/env_$role.conf ]; then
                    \cp ${cont_path}/configs/env/env_$role.conf ${cont_path}/env.conf
                    # \cp ${cont_path}/nginx/init_bak/im.conf ${cont_path}/nginx/stream.d/im.conf
                    \cp ${cont_path}/nginx/init_bak/push.conf ${cont_path}/nginx/stream.d/push.conf
                fi
            elif [ -f  ${cont_path}/configs/env/env_single.conf ]; then
                \cp ${cont_path}/configs/env/env_single.conf ${cont_path}/env.conf
            fi
			${cont_path}/start.sh $name
			echo "----------------- $name 容器启动完毕-------------------"
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}


function cont_oa()
{    
	name=$1
    if [ ! $name ]; then
        name="OA"
    fi
	echo -e "**************************************************"
	echo -e "*接下来将要运行 $name 容器"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要运行 $name 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始运行 $name 容器-------------------"
			cont_path="/data/oa/$name"
			if [ $2 ]; then
				cont_path=$2
			fi
			${cont_path}/update_domain.sh
			${cont_path}/start.sh $name
			echo "----------------- $name 容器启动完毕-------------------"
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function cont_all()
{
	echo -e "**************************************************"
	echo -e "*接下来将要运行所有的 docker 容器"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要运行所有的 docker 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			check_docker
			cont_gfs
			${basepath}/os_client.sh 
			cont_mysql
			${basepath}/mysql_init_data.sh
			cont_zk
			cont_journal
			cont_hadoop
			cont_mongo
			cont_redis
			cont_mas
			cont_im
			cont_tomcat "EMMIN"
			cont_tomcat "EMMWEB"
			cont_nginx
			start_tomcat
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function cont_run()
{
	name=$1
	echo -e "**************************************************"
	echo -e "*接下来将要运行 $name 容器"
	echo -e "**************************************************"
	while :
	do
		if [ ! $name ]; then
			echo "您没有指定运行任何容器,请输入需要运行的容器名称:"
			continue
		fi
		read -p "是否需要运行 $name 容器:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始运行 $name 容器-------------------"
			# 获取容器data目录缺省路径，默认为/data/小写镜像名/容器名
			cont_path=${dir_data}/`grep "$name.IMAGES" ${config_file} | awk -F= '{print $2}' | tr "[:upper:]" "[:lower:]"`/$name
			if [ $2 ]; then
				cont_path=$2
			fi   
            role=$3
            if [ ! $3 ]; then
                role="single"
            fi
			if [ ! -f ${cont_path}/start.sh ]; then
				echo "您输入的目录不存在,或者该目录下无start.sh脚本,请核实后重新输入,谢谢!"
				break
			fi
            # 根据container_role，覆盖相关的配置文件到env.conf文件，单机直接拷贝env_single文件
            if [[ $role && $role != "single" && $role != "SINGLE" ]]; then
                if [ -f ${cont_path}/configs/env/env_$role.conf ]; then
                    \cp ${cont_path}/configs/env/env_$role.conf ${cont_path}/env.conf
                fi
            elif [ -f  ${cont_path}/configs/env/env_single.conf ]; then
                \cp ${cont_path}/configs/env/env_single.conf ${cont_path}/env.conf
            fi
			${cont_path}/start.sh $name
			echo "------------------- $name 容器启动完毕--------------------"      
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}


# $1为容器的name，$2为容器的path, $3为容器的role
case "$1" in
	"GFS"|"MYSQL"|"ZK"|"JOURNAL"|"HADOOP"|"MONGO"|"REDIS6379"|"REDIS6380"|"REDIS6381")
		cont_run $1 $2 $3
		;;
	"IM")
		cont_im $1 $2
		;;
	"BAASADMIN"|"BAASIN")
		cont_mas $1 $2 $3
		;;
	"EMMWEB" | "EMMIN")
		cont_tomcat $1 $2 $3
		;;
	"NGINX")
		cont_nginx $1 $2 $3
		;;   
	"OA")
		cont_oa $1 $2
		;;      
	*)
		cont_all
		RETVAL=2
esac

exit $RETVAL
