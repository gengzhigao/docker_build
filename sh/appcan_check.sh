#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
config_file="${basepath}/check.conf"
#echo $basepath

function checkService()
{
	service=`grep CHECK.SERVICE ${config_file} |awk -F= '{print $2}'`
	IFS=";"
	arr=($service)
	for service_name in ${arr[@]}
	do		
		project=`grep PROJECT.${service_name} ${config_file} |awk -F= '{print $2}'`
		#if [ $project -eq "" ]; then
		#	continue
		#fi
		echo -e "\n下面开始检测:\033[33m $3 $service_name \033[0m" 
		arr2=($project)
		for project_name in ${arr2[@]}
		#for chkurl in $(`grep URL.$service_name ${config_file} |awk -F '=' '{print $2}'`)    # ${}忽略空格
		do
			chkurl=(`grep URL.${service_name}.${project_name} ${config_file} |awk -F '=' '{print $2}' `)
			logfile=(`grep LOGFILE.${service_name}.${project_name} ${config_file} |awk -F '=' '{print $2}' `)
			checkURL ${chkurl} ${logfile} ${project_name}
			#echo "chkurl------>:"   $chkurl 
			#echo "logfile_url------>:"   $logfile
		done
	done
}

function checkURL()
{
	chkurl=$1
	# -o 输出内容到/dev/null; -s 静默方式 ；-w 定义显示输出格式；"%{http_code}" 在最后被检索的 HTTP(S) 页中被找到的数字的代码
	HTTP_CODE=`curl -o /dev/null -s -w "%{http_code}" "${chkurl}"` 
	if [ ${HTTP_CODE} -ne 200 ]; then
		echo -e "\n\033[31m$3 检测失败! \033[0m 其检测路径为： $chkurl";
		echo -e "该工程日志文件的路径为 $2\n"
	else
		echo -e "\033[32m$3 检测成功!\033[0m 其检测路径为： $chkurl";
	fi
}

checkService
