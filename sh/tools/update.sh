#/bin/bash
TOMCAT_CONN_NAME=EMMIN
IM_CONN_NAME=IM
IM_CONN_PATH=/data/im/${IM_CONN_NAME}
update_source=/opt/update_source
update_source_im=${update_source}/IM
update_sourec_im_bak=${update_source}/bak/IM
update_source_emm=${update_source}/EMM
update_sourec_emm_bak=${update_source}/bak/EMM
projects_tomcat_source=/data/tomcat/${TOMCAT_CONN_NAME}/resource
SQL_UPDATE_IM="mysql -h127.0.1.1 -P43306 -utigase_user -ptigase_pass -Dtigasedb7 "
# 如果需要从SVN更新代码，此处在此处进行配置
SVN_URL_EMM=http://192.168.1.152:8080/svn/项目过程资产/07-普华项目/03-普华移动营销/puhuayingxiao-安装包/20170814
USERNAME=gengzhi.gao
PASSWORD=gaogengzhi
DIR_DEST_EMM=/opt/update_source/EMM
#更新目录
mkdir -p ${update_sourec_im_bak}
mkdir -p ${update_sourec_emm_bak}



function snv_co_emm()
{
	echo -e "**************************************************"
	echo -e "*接下来将要从 SVN 更新 EMM 工程包"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要从 SVN 更新 EMM 工程包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始从 SVN 更新 EMM 工程包-------------------"
		    svn_count=`whereis svn |grep "usr" |wc -l`
		    if [ $svn_count -eq 0 ]; then
		        yum -y install svn
		    fi
			rm -rf $DIR_DEST_EMM
			mkdir -p $DIR_DEST_EMM
			svn co $SVN_URL_EMM --username $USERNAME --password $PASSWORD $DIR_DEST_EMM
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}


function update_im_java()
{	
	echo -e "**************************************************"
	echo -e "*接下来将要更新 IM Java 工程包"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要更新 IM Java 工程包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始更新 IM Java 工程包-------------------"
			if [[ `find ${update_source_im} -name "tigase*.war" | wc -l` -eq 1 ]]; then
				if [ `find ${projects_tomcat_source} -name "tigase*.war" |wc -l` -gt 0 ]; then
					mv ${projects_tomcat_source}/tigase*.war ${update_sourec_im_bak}/
				fi
				cp ${update_source_im}/tigase*.war ${projects_tomcat_source}/ 
				echo "IM Java 工程包，覆盖成功!"
			elif [[ `find ${update_source_im} -name "tigase*.war" | wc -l` -gt 1 ]]; then
				echo "含多个 tigase Java 工程包，请只保留最新的工程包之后，再次更新"
			else
				echo "无 IM Java 工程包，不进行 Java 工程更新"
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function update_im_tigase()
{
	echo -e "**************************************************"
	echo -e "*接下来将要更新 tigase-server 工程包"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要更新 tigase-server 工程包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始更新 tigase-server 工程包-------------------"
			if [[ `find ${update_source_im} -name "tigase-server*.zip" | wc -l` -eq 1 ]]; then
				if [ -d ${IM_CONN_PATH}/tigase-server ]; then
					mv ${IM_CONN_PATH}/tigase-server ${update_sourec_im_bak}/tigase-server_`date "+%G%m%d_%H%M%S"`
				fi
				if [[ `find ${update_source_im}/ -name "tigase-server*.zip" |wc -l` > 0 ]]; then
					# 判断压缩包是否包含 tigase-server，包含则解压到对应的目录下
					echo "------------>tigase.zip------->"
					if [[ `unzip -v ${update_source_im}/tigase-server*.zip |grep "tigase-server" |wc -l` -eq 0 ]]; then
						mkdir -p ${IM_CONN_PATH}/tigase-server
						unzip ${update_source_im}/tigase-server*.zip -d ${IM_CONN_PATH}/tigase-server
					else
						unzip ${update_source_im}/tigase-server*.zip -d ${IM_CONN_PATH}
					fi
				fi
				chown -R root:root ${IM_CONN_PATH}
				find ${IM_CONN_PATH} -name "*.sh" |xargs chmod +x		
				echo "tigase-server 工程包，覆盖成功!"
				docker restart ${IM_CONN_NAME}
			elif [[ `find ${update_source_im} -name "tigase-server*.zip" | wc -l` -gt 1 ]]; then
				echo "含多个 tigase-server 工程包，请只保留最新的工程包之后，再次更新"
			else
				echo "无 tigase-server 工程包，不进行 tigase-server 工程更新"
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function update_im_sql()
{	
	echo -e "**************************************************"
	echo -e "*接下来将要执行 IM SQL 更新语句"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要执行 IM SQL 更新语句:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始执行 IM SQL 更新语句-------------------"
			if [[ `find ${IM_CONN_PATH} -name "tigase*update.sql" | wc -l` -eq 1 ]]; then
				$SQL_UPDATE_IM < ${IM_CONN_PATH}/tigase-server/sql/tigase*update.sql
				if [ "$?" -ne 0 ];then
					echo "IM SQL 更新语句执行失败"
					exit 1
				else					
					echo "IM SQL 更新语句执行成功"
				fi
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function update_emm_java()
{
	echo -e "**************************************************"
	echo -e "*接下来将要更新 EMM Java 工程包"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要更新 EMM Java 工程包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始更新 EMM Java 工程包-------------------"
			if [[ `find ${update_source_emm} -name "*.war" | wc -l` -gt 1 ]]; then
				if [ `find ${projects_tomcat_source} -name "*.war" |wc -l` -gt 0 ]; then
					ls ${projects_tomcat_source}/*.war |grep -v "tigase-im*" |grep -v "analy*" |xargs -ti mv {}  ${update_sourec_emm_bak}/
					#mv ${projects_tomcat_source}/*.war ${update_sourec_emm_bak}/
				fi
				cp ${update_source_emm}/*.war ${projects_tomcat_source}/ 
				echo "EMM Java 工程包，覆盖成功!"
			else
				echo "无 EMM Java 工程包，不进行 Java 工程更新"
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function tomcat_restart()
{
	echo -e "**************************************************"
	echo -e "*接下来将要更新 mam.properties 文件，并重启 TOMCAT 容器"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要重新安装 Java 工程 war 包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始重启 TOMCAT 容器-------------------"
			cd ${projects_tomcat_source}/../
			./install_war.sh
		fi
		read -p "是否需要同步 mam.properties 文件到编译后的工程包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始同步 mam.properties 文件，同步之前请根据实际情况判断是否需要修改mam.properties文件-------------------"
			cd ${projects_tomcat_source}/../
			./updatemam.sh
		fi
		read -p "是否需要重启 Tomcat 服务:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "-----------------下面开始重启 TOMCAT 容器-------------------"
			docker exec -it ${TOMCAT_CONN_NAME} service tomcat7 restart
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == ""  ]; then
			break
		fi
	done
}

snv_co_emm
update_im_java
update_emm_java
tomcat_restart
update_im_tigase