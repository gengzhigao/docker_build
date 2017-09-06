#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)
dir_data=/data
mdm_path=/opt/emm/mdmIn
pushcert_path=$dir_current
config_file=${dir_current}/../config.conf

function mdm_config()
{
	while :
	do
		echo -e "***************************************************************************"
		echo -e "*接下来将要配置mdm pushcert"
		echo -e "***************************************************************************"
		read -p "是否确定配置配置mdm pushcert:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ]; then
			mkdir -p ${mdm_path}
			cd ${mdm_path}
			unzip ${pushcert_path}/pushcert.zip
			cd pushcert
			chmod +x *.sh
			./makepush.sh 123456
			chmod -R 777 ${mdm_path}
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function httpclient_config()
{
	while :
	do
		echo -e "***************************************************************************"
		echo -e "*接下来将要配置https双向认证客户端证书，以便校验MDM证书是否正常"
		echo -e "***************************************************************************"
		read -p "是否确定配置https双向认证客户端证书:(y/N)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ]; then
			read -p "请输入需要配置https双向认证的域名:" input
			if [ "$input" = "" ]; then
				echo "域名不存在，请重新输入！"
				#echo $input
				continue
			fi
			domain_name=$input
			cd /opt/emm/ca
			./makeHttpsCert.sh $domain_name 123456 httpclient 123 /opt/emm/ca 1000
			echo -e "\n\n生成的https双向证书路径为/opt/emm/ca/httpclient.p12，请下载之后导入到浏览器，然后通过浏览器检测mdmIn接口！"
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

mdm_config
httpclient_config