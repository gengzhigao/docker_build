#!/bin/bash

###################################### 配置区开始 ######################################
# MYSQL 配置信息
mysql_user_root=root
mysql_pass_root=3g2win.com
mysql_user_emm=emm_user
mysql_pass_emm=emmpass
mysql_user_im=tigase_user
mysql_pass_im=tigase_pass
mysql_user_oa=ydyy_user
mysql_pass_oa=ydyypass
mysql_db_emm=emm_db
mysql_db_im=tigasedb7
# 租户信息
tenant_id=1846
# 初始化文件信息
#oa_tenant_file=/data/sql/oa_sql/emm_init_tenant.sql
oa_menu_file=/data/sql/oa_sql/menubtnConfig.sql
oa_menu_file_outer=/data/mysql/MYSQL/sql/oa_sql/menubtnConfig.sql
oa_im_file=/data/sql/oa_sql/im_init_tenant.sql
sql_path_outer=/data/mysql/MYSQL/sql
##################################### 配置区结束 ######################################

# 初始化 MYSQL 基础数据
function mysql_init_data_bak()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要初始化 MYSQL 数据"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要初始化 MYSQL 数据:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始初始化 MYSQL 数据-------------------"
			#sleep 60s
			source ~/.bashrc
			docker exec -i MYSQL /bin/bash <<EOF
				/bin/initemm.sh
				/bin/inithive.sh
				/bin/initim.sh
EOF
			echo "-----------------初始化 MYSQL 数据启动完毕-------------------"
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

# 初始化 MYSQL 基础数据
function mysql_init_data()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要初始化 MYSQL 数据"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要初始化 MYSQL 数据:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始初始化 MYSQL 数据-------------------"
			#sleep 60s
		
			# 初始化 emm_db
			EPUUID="`cat /proc/sys/kernel/random/uuid`"
			echo "${EPUUID}"
			sed -i "s/EPortal_key/$EPUUID/g" ${sql_path_outer}/emm_db_init.sql
			mysql -h127.0.0.1 -uroot -p${mysql_pass_root} < ${sql_path_outer}/emm_db_create.sql
			mysql -h127.0.0.1 -uroot -p${mysql_pass_root} -D emm_db < ${sql_path_outer}/emm_db_init.sql

			# 初始化 hive_db
			mysql -h127.0.0.1 -uroot -p${mysql_pass_root} < ${sql_path_outer}/inithive.sql

			# 初始化 im_db
			mysql -h127.0.0.1 -uroot -p${mysql_pass_root} < ${sql_path_outer}/tigase7-server-mysql-init.sql
			mysql -h127.0.0.1 -uroot -p${mysql_pass_root} -D ${mysql_db_im} < ${sql_path_outer}/tigase7-server-mysql-install.sql
			mysql -h127.0.0.1 -uroot -p${mysql_pass_root} -D ${mysql_db_im} < ${sql_path_outer}/tigase7-server-mysql-update.sql
			echo "-----------------初始化 MYSQL 数据启动完毕-------------------"
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

#更新 OA 菜单 SQL 文件，替换域名
function config_memu_domain()
{
	#OA配置文件
	s1="$1"

	sarray="$s1"
	echo -e "**************************************************"
	echo -e "*接下来将要更新 OA 菜单 SQL 文件，替换域名"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要更新 OA 菜单 SQL 文件，替换域名:(Y/n)" input
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
			A1=`cat "$s1" |grep "t.appcan.cn" |wc -l`
			A2=`cat "$s1" |grep "${input}" |wc -l`
			#echo "A1----->"$A1";A2---->"$A2
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

# 初始化 MYSQL OA 相关数据
function mysql_init_oa_data()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要初始化 OA 数据"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要初始化 OA 数据:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "******************************************下面开始初始化 OA 数据******************************************"
			source ~/.bashrc
			# 调用 config_memu_domain 方法，替换SQL语句中EMM访问URL的域名
			config_memu_domain $oa_menu_file_outer
			docker exec -i MYSQL /bin/bash <<EOF
				cd /data/sql
				# 创建 CRM、流程引擎 相关数据库
				./installOAScript.sh 127.0.0.1 $mysql_user_root $mysql_pass_root $tenant_id $mysql_user_oa $mysql_pass_oa

				#echo "-----------------开始初始化 OA 租户信息-----------------"
				#mysql -h 127.0.0.1 -u$mysql_user_emm -p$mysql_pass_emm -D $mysql_db_emm < $oa_tenant_file
				#if [ "$?" -ne 0 ];then
				#	echo "-----------------初始化 OA 租户信息失败-----------------"
				#	exit 1
				#else
				#	echo "-----------------初始化 OA 租户信息成功-----------------"
				#fi

				echo "-----------------开始初始化 OA 菜单-----------------"
				# 调用 config_memu_domain 方法，替换SQL语句中EMM访问URL的域名
				# config_memu_domain $oa_menu_file
				mysql -h 127.0.0.1 -u$mysql_user_emm -p$mysql_pass_emm -D $mysql_db_emm < $oa_menu_file
				if [ "$?" -ne 0 ];then
					echo "-----------------初始化 OA 菜单失败-----------------"
					exit 1
				else
					echo "-----------------初始化 OA 菜单成功-----------------"
				fi

				echo "-----------------开始初始化 IM OA 数据-----------------"
				mysql -h 127.0.0.1 -u$mysql_user_im -p$mysql_pass_im -D $mysql_db_im < $oa_im_file
				if [ "$?" -ne 0 ];then
					echo "-----------------初始化 IM OA 数据失败-----------------"
					exit 1
				else
					echo "-----------------初始化 IM OA 数据成功-----------------"
				fi
EOF
			echo "******************************************初始化 OA 数据启动完毕******************************************"
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}


#config_memu_domain $oa_menu_file_outer
mysql_init_data
mysql_init_oa_data
