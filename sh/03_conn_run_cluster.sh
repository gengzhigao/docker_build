#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)
dir_data=/data
cont_run_path=${dir_current}/tools
config_file=${dir_current}/../config.conf

function config_conver()
{
	read -p "是否覆盖env目录下的config.conf-cluster-6文件到当前目录下的config文件(Y/n)" input
	if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
		\cp env/config.conf-cluster-6 $config_file
	fi
}
config_conver

${dir_current}/conn_run_db.sh
${dir_current}/conn_config_db.sh
${dir_current}/conn_run_app.sh
