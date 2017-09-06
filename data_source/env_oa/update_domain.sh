#!/bin/bash
basepath=$(cd `dirname $0`; pwd)


#添加租户，添加emm应用appId及appKey
function add_user()
{
	echo -e "**************************************************"
	echo -e "*接下来将要在emm_db里创建租户，并添加emm应用appId及appKey"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要在emm_db里创建租户，并添加emm应用appId及appKey:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始在emm_db里创建租户"
			CMD_CONN_MYSQL="mysql -h127.0.1.1 -uemm_user -pemmpass -d emm_db -s -e "
			SQL_ADD_USER="insert into TenantInfo(id,createdAt,tenantId,tenantName,tenantFullName,tenantLogo,tenantInternetAddr,tenantAddr,tenantTel) values(1,now(),'1846','ydyy','','','','','');"
			$CMD_CONN_MYSQL "${SQL_ADD_USER}"

			if [ "$?" -ne 0 ];then
				echo "创建租户失败，退出！"
				break
			fi
				echo "创建租户成功"
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

#IM初始化
function config_im()
{
	echo -e "**************************************************"
	echo -e "*接下来将要初始化 IM SQL"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要初始化 IM SQL:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始初始化 IM SQL"
			CMD_CONN_MYSQL="mysql -h127.0.1.1 -utigase_user -ptigase_pass -d tigase7db -s -e "
			SQL_ADD_USER="update tig_pairs set pval = concat('<vhost anon=\"true\" owner=\"admin@localhost\" register=\"true\" enabled=\"true\" tls-required=\"false\" max-users=\"0\" hostname=\"1846:eportal\" domain-filter=\"ALL\"><comps/><other/></vhost>',pval) where pkey = 'vhosts-lists';"
			$CMD_CONN_MYSQL "${SQL_ADD_USER}"

			if [ "$?" -ne 0 ];then
				echo "IM SQL初始化失败，退出！"
				break
			fi
				echo "IM SQL初始化成功"
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

#IM初始化
function config_oa()
{
	echo -e "**************************************************"
	echo -e "*接下来将要初始化 IM SQL"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要初始化 IM SQL:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始初始化 IM SQL"
			dbHostIp=""                      #数据库host
			dbUsername=""                #root用户
			dbPassword=""                #root用户密码
			tenantId=""                  #租户id
			tenantDbUsername=""          #要创建的用户
			tenantDbPassword=""          #要创建的用户密码
			installScript.sh $dbHostIp $dbUsername $dbPassword $tenantId $tenantDbUsername $tenantDbPassword

			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

#添加baas应用，并创建emoa数据库
function init_mongo()
{
	echo -e "**************************************************"
	echo -e "*接下来将要添加baas应用"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要添加baas应用:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始添加baas应用"
			mongoimport -d baas -c _AppInfo ./baasAppInfo/AppInfo.json  
			mongorestore -d appcan_mobileoa ./appcan_mobileoa/
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

#更新OA配置文件，替换域名
function config_oa_domain()
{
	dir_oa="/data/oa/OA"
	#OA配置文件
	s1="$dir_oa/configs/mas/EMOA_APP_SERVICE/interface/emoa/00.0001/config.js"
	s2="$dir_oa/configs/mas/EMOA_APP_SERVICE/interface/attachment/00.0001/config.js"
	s3="$dir_oa/configs/mas/EMOA_CONSOLE/interface/manage/00.0001/config.js"
	#crm配置文件
	s4="$dir_oa/configs/tomcat/webapps/crm/WEB-INF/classes/config.properties"

	sarray="$s1;$s2;$s3;$s4"
	echo -e "**************************************************"
	echo -e "*接下来将要更新 OA 访问域名"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要更新 OA 访问域名:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			read -p "配置访问EMMWEB对应的域名(t.appcan.cn):" input
			if [ "$input" == "" ]; then
				echo "您没有输入任何域名，将使用默认域名t.appcan.cn"
				break
			fi
			IFS=";"
			for s in ${sarray[@]}
			do
				sed -i -c "s/t.appcan.cn/${input}/g" $s
			done
            A1=`find ${basepath}/configs -name "*config.*" |xargs cat |grep "t.appcan.cn" |wc -l`
            A2=`find ${basepath}/configs -name "*config.*" |xargs cat |grep "${input}" |wc -l`
			if [[ $input != "t.appcan.cn" && $A1 -eq 0 && $A2 -gt 0 ]]; then
				echo -e "\e[32m\e[1m域名替换成功!\e[0m"
			else
				echo -e "\033[31m域名替换失败!\033[0m"
			fi
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

config_oa_domain

























