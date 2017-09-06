#!/bin/sh

#installOAScript.sh $1 $2 $3 $4 $5 $6 $7 $8 $9
#$1:dbHostIp
#$2:dbUsername
#$3:dbPassword
#$4:tenantId
#$5:tenantDbUsername
#$6:tenantDbPassword


#######################DEL############################
#del
#$7:appId
#$8:baasImportUrl
#$9:emmMenuInitUrl

echo "================installOAScript.sh start======================"

#判断参数个数
if [ "$#" -ne 6 ];then
	echo "ERROR参数个数不正确，请输入6个参数"
	echo "par1:dbHostIp"
	echo "par2:dbUsername"
	echo "par3:dbPassword"
	echo "par4:tenantId"
	echo "par5:tenantDbUsername"
	echo "par6:tenantDbPassword"
	exit 1
fi

#参数设置
dbHostIp=$1
dbUsername=$2
dbPassword=$3
tenantId=$4
tenantDbUsername=$5
tenantDbPassword=$6
#appId=$7
#baasImportUrl=$8
#emmMenuInitUrl=$9

# 获取脚本绝对路径
DIR=$(cd $(dirname $0); pwd)/oa_sql

#临时文件
crm_database_tmp_file=${DIR}/crm_database_str_tenantId_tmp.sql
workflow_database_tmp_file=${DIR}/workflow_database_str_tenantId_tmp.sql
workflow_create_table_file_tmp=${DIR}/workflow_create_table_tmp.sql

#创建CRM数据库文件
CRM_CREATE_DATABASE_FILE=${DIR}/CRM_CREATE_DATABASE.sql
#创建WORKFLOW数据库文件
WORKFLOW_CREATE_DATABASE_FILE=${DIR}/WORKFLOW_CREATE_DATABASE.sql
#创建CRM数据表文件
CRM_CREATE_TABLE_FILE=${DIR}/CRM_CREATE_TABLE.sql
#创建WORKFLOW数据表文件
WORKFLOW_CREATE_TABLE_FILE=${DIR}/WORKFLOW_CREATE_TABLE.sql

#数据库初始名称
DB_DATABASE_CRM="crm_db"
DB_DATABASE_WORKFLOW="workflow_db"

#执行动作初始化,默认为N不执行
#创建CRM数据库
CRM_CREATE_DATABASE_FLG="N"
#创建WORKFLOW数据库
WORKFLOW_CREATE_DATABASE_FLG="N"
#创建CRM数据表
CRM_CREATE_TABLE_FLG="N"
#创建WORKFLOW数据表
WORKFLOW_CREATE_TABLE_FLG="N"

#判断创建CRM数据库文件是否存在
if [ -f "$CRM_CREATE_DATABASE_FILE" ]; then
	echo "创建CRM数据库文件"$CRM_CREATE_DATABASE_FILE"存在"
	CRM_CREATE_DATABASE_FLG="Y"
fi

#判断创建WORKFLOW数据库文件是否存在
if [ -f "$WORKFLOW_CREATE_DATABASE_FILE" ]; then
	echo "创建WORKFLOW数据库文件"$WORKFLOW_CREATE_DATABASE_FILE"存在"
	WORKFLOW_CREATE_DATABASE_FLG="Y"
fi

#判断创建CRM数据表文件是否存在
if [ -f "$CRM_CREATE_TABLE_FILE" ]; then
	echo "创建CRM数据表文件"$CRM_CREATE_TABLE_FILE"存在"
	CRM_CREATE_TABLE_FLG="Y"
fi

#判断创建WORKFLOW数据表文件是否存在
if [ -f "$WORKFLOW_CREATE_TABLE_FILE" ]; then
	echo "创建WORKFLOW数据表文件"$WORKFLOW_CREATE_TABLE_FILE"存在"
	WORKFLOW_CREATE_TABLE_FLG="Y"
fi

#数据库初始化特殊操作
if [[ $0 =~ "installOAScript.sh" ]];then
	if [ "$CRM_CREATE_DATABASE_FLG" = "N" ];then
		echo "ERROR创建CRM数据库文件"$CRM_CREATE_DATABASE_FILE"不存在"
		exit 1
	fi

	if [ "$WORKFLOW_CREATE_DATABASE_FLG" = "N" ];then
		echo "ERROR创建WORKFLOW数据库文件"$WORKFLOW_CREATE_DATABASE_FILE"不存在"
		exit 1
	fi
fi

#处理租户的database
crm_database_str=`cat $CRM_CREATE_DATABASE_FILE`
crm_database_str_tenantId=${crm_database_str/${DB_DATABASE_CRM}/${DB_DATABASE_CRM}_$tenantId};
echo $crm_database_str_tenantId > $crm_database_tmp_file

workflow_database_str=`cat $WORKFLOW_CREATE_DATABASE_FILE`
workflow_database_str_tenantId=${workflow_database_str/${DB_DATABASE_WORKFLOW}/${DB_DATABASE_WORKFLOW}_$tenantId};
echo $workflow_database_str_tenantId > $workflow_database_tmp_file

#mysql连接
CMD_CREATE_USER_MYSQL="mysql -h"$dbHostIp" -u"$dbUsername" -p"$dbPassword" -s -e "
CMD_MYSQL="mysql -h "$dbHostIp" -u"$tenantDbUsername" -p"$tenantDbPassword" "
CMD_ROOT_MYSQL="mysql -h"$dbHostIp" -u"$dbUsername" -p"$dbPassword" "

#创建CRM数据库
if [[ "$CRM_CREATE_DATABASE_FLG" = "Y" ]];then
	echo "创建CRM数据库"
	$CMD_ROOT_MYSQL < $crm_database_tmp_file
	if [ "$?" -ne 0 ];then
		echo "创建CRM数据库失败"
		exit 1
	fi
	echo "删除临时文件"$crm_database_tmp_file
	rm -f $crm_database_tmp_file
fi

#创建WORKFLOW数据库
if [[ "$WORKFLOW_CREATE_DATABASE_FLG" = "Y" ]];then
	echo "创建WORKFLOW数据库"
	$CMD_ROOT_MYSQL < $workflow_database_tmp_file
	if [ "$?" -ne 0 ];then
		echo "创建WORKFLOW数据库失败"
		exit 1
	fi
	echo "删除临时文件"$workflow_database_tmp_file
	rm -f $workflow_database_tmp_file
fi

#创建CRM数据表
if [ "$CRM_CREATE_TABLE_FLG" = "Y" ];then
	echo "创建CRM数据表"
	$CMD_ROOT_MYSQL${DB_DATABASE_CRM}_$tenantId < $CRM_CREATE_TABLE_FILE
	if [ "$?" -ne 0 ];then
		echo "创建CRM数据表失败"
		exit 1
	fi
fi

#创建WORKFLOW数据表
if [ "$WORKFLOW_CREATE_TABLE_FLG" = "Y" ];then
	echo "创建WORKFLOW数据表"
	cp -p $WORKFLOW_CREATE_TABLE_FILE $workflow_create_table_file_tmp
	sed -i "s/tenantId_xxxx/$tenantId/g" $workflow_create_table_file_tmp
	$CMD_ROOT_MYSQL${DB_DATABASE_WORKFLOW}_$tenantId < $workflow_create_table_file_tmp
	echo "删除临时文件"$workflow_create_table_file_tmp
	rm -f $workflow_create_table_file_tmp
fi

echo "--->CRM、WORKFLOW 数据库初始化完成"

#数据库初始化特殊操作
if [[ $0 =~ "installOAScript.sh" ]];then
	#创建用户
	#CREATE_USER_SQL="CREATE USER '${tenantDbUsername}'@'%' IDENTIFIED BY '${tenantDbPassword}';"
	GRANT_ALL_SQL="GRANT ALL PRIVILEGES ON ${DB_DATABASE_CRM}_${tenantId}.* TO '${tenantDbUsername}'@'%' IDENTIFIED BY 'ydyypass'; GRANT ALL PRIVILEGES ON ${DB_DATABASE_CRM}_${tenantId}.* TO '${tenantDbUsername}'@'localhost' IDENTIFIED BY 'ydyypass'; GRANT ALL PRIVILEGES ON ${DB_DATABASE_WORKFLOW}_${tenantId}.* TO '${tenantDbUsername}'@'%' IDENTIFIED BY 'ydyypass'; GRANT ALL PRIVILEGES ON ${DB_DATABASE_WORKFLOW}_${tenantId}.* TO '${tenantDbUsername}'@'localhost' IDENTIFIED BY 'ydyypass';"
	#$CMD_CREATE_USER_MYSQL"${CREATE_USER_SQL}"
	#if [ "$?" -ne 0 ];then
		#echo "创建用户失败"
		#exit 1
	#fi
	#echo "创建用户${tenantDbUsername}"
	$CMD_CREATE_USER_MYSQL"${GRANT_ALL_SQL}"
	if [ "$?" -ne 0 ];then
		echo "用户授权失败"
		exit 1
	fi
	$CMD_CREATE_USER_MYSQL"flush privileges;"
	echo "为用户${tenantDbUsername}授权"
fi

echo "--->CRM、WORKFLOW 数据库授权完成"

#初始化baas数据
#curl -H "x-mas-app-id:${tenantId}:${appId}" -F "oa_init.json=@${DIR}/oa_init.json" ${baasImportUrl}

#echo "--->BAAS初始化完成"

echo "================installOAScript.sh end======================"

###end
exit 0
###