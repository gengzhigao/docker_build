#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)
dir_ca="/opt/emm"
path=`pwd`

function getIP()
{
    echo -e "**************************************************"
    echo -e "*EMM使用CA做为认证基础，因此需要创建自签名证书来保证"
    echo -e "*服务器安全，接下来将开始配置生成证书。"
    echo -e "**************************************************"
    while :
    do
        chmod a+x ${dir_current}/ca/*.sh
        echo -e "**************************************************"
        echo -e "*证书与本机IP相关，请选择实际提供服务的网卡，使安装"
        echo -e "*程序可以获取到正确的IP"
        echo -e "**************************************************"
        read -p "选择工作的网卡(eno16777736):" input
        if [ "$input" == "" ]; then
            input="eno16777736"
        fi
        IPaddress=`LANG=C ifconfig ${input} | awk '/inet /{ print $2 }'`
        if [ "$IPaddress" == "" ]; then
            read -p "获取不到网址IP，请手工输入对外服务IP地址或域名:" input
            if [ "$input" == "" ]; then
                echo "您没有输入任何IP，请重新开始"
                continue
            fi
			IPaddress=$input
        fi
        echo "网卡IP为${IPaddress}"
        break
    done
}

function initservercert()
{
	echo -e "**************************************************"
	echo -e "*设定服务器证书对应的外部访问主机IP，如果本机IP即为"
	echo -e "*外网访问IP，直接回车继续"
	echo -e "**************************************************"
	deleteServerCert
	
	read -p "设定服务器外部访问IP:(${IPaddress})" input
	if [ "$input" = "" ]; then
		IPaddress=$IPaddress
	else
		IPaddress=${input}
	fi
	
	read -p "设定服务器外部访问域名:(${IPaddress})" input
	if [ "$input" = "" ]; then
		domainName=$IPaddress
        else
                domainName=${input}
	fi

    sed -i '/subjectAltName/d' ${dir_current}/ca/server.cnf
	echo "subjectAltName = IP:${IPaddress},DNS:${domainName},URI:https://${domainName}:8443/" >> ${dir_current}/ca/emmin.cnf

	cd ${dir_current}
	ca/makeEMMINServerCert.sh 123456 ${domainName} ${dir_current}
	cd ${workdir}
	
	echo ""
}


#查看/opt/emm/ca/文件夹下是否已经存在服务器证书，如果存在，删除之，重新生成
function deleteServerCert()
{
        ls /opt/emm/ca/emmin* > /dev/null 2>&1
        if [ $? == 0 ]; then
                echo "/opt/emm/ca目录下已经包含别名为emm_ca的服务器证书，先删除，下面脚本会生成新的emmin server证书"
                rm -rf /opt/emm/ca/emmin*
        fi
}


function addJdkCert()
{ 
	echo "----------------下面开始添加JDK的Java证书库------------------"
	cd /usr/java/default/jre/lib/security
        echo "Clear Old CA "
	/usr/java/default/bin/keytool -delete -alias emm_ca -keystore cacerts -storepass changeit
        echo "Add New CA"
	/usr/java/default/bin/keytool -import -alias emm_ca -file ${dir_current}/ca/ca.crt -keystore cacerts -trustcacerts -storepass changeit -noprompt
}


#getIP
initservercert
cd $path

