#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
###################################### 配置区开始 ######################################
# MYSQL 配置信息
mysql_user_im=tigase_user
mysql_pass_im=tigase_pass
mysql_db_im=tigasedb7
sqlfile_update_im=${basepath}/tigase-server/sql/tigase7-server-mysql-update.sql
##################################### 配置区结束 ######################################
# 初始化 MYSQL 基础数据
function mysql_update_data()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要更新 IM SQL 脚本"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要更新 IM SQL 脚本:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------开始初始化 IM SQL脚本-----------------"
			mysql -h 127.0.1.3 -P43306 -u$mysql_user_im -p$mysql_pass_im -D $mysql_db_im < $sqlfile_update_im
			if [ "$?" -ne 0 ]; then
				echo "-----------------更新 IM SQL脚本失败-----------------"
				exit 1
			else
				echo "-----------------更新 IM SQL脚本成功-----------------"
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

mysql_update_data