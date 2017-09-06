#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
emm_home=/opt/emm
dir_gluster_cli=/opt/emm
dir_source_mam=${basepath}/resource
nowtime=`date +%m%d_%k%m`
IPaddress=''

function update_mam()
{
    echo -e "**************************************************"
    echo -e "*tomcat的网络配置与本机IP相关，请选择实际提供服务的"
    echo -e "*网卡，使安装程序可以获取到正确的IP"
    echo -e "**************************************************"
    while : 
    do
        read -p "是否需要修改mam.properties(Y/n):" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            echo "开始修改mam.properties文件"
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
            else
                read -p "配置访问EMMWEB对应的IP地址或域名${IPaddress}:" input
            fi
            if [ "$input" == "" ]; then
                input=$IPaddress
            fi
            if [ ! -f ${emm_home}/mam.properties ]; then
                echo "${emm_home}/mam.properties文件目前不存在，故在设置前会自动拷贝一份mam.properties"
                cp ${dir_source_mam}/mam.properties ${emm_home}/mam.properties
            fi
            echo "下面开始设置mam.properties，将127.0.0.1更换为实际IP${input}"
            sed -i "s/192.168.1.100/$input/g" ${dir_gluster_cli}/mam.properties
            sed -i "s/www-ip/$input/g" ${dir_gluster_cli}/mam.properties
            break
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
        echo ""
    done
}

function cover_mam()
{
    echo -e "**************************************************"
    echo -e "*接下来开始将共享目录下的/opt/emm/mam.properties"
    echo -e "*文件同步到所有tomcat工程下"
    echo -e "**************************************************"
    tomcat_home=${basepath}/tomcat/emm
    properties_path=/opt/emm
    # for filename in `ls -l $path | awk '/^d/{print $NF}'`
    for filename in `ls -d $tomcat_home/*/`
    do
        if [ -d "${filename}WEB-INF/classes" ]; then
			echo "在覆盖配置文件之前会生成一个备份文件 mam.properties_$nowtime"
			\cp ${filename}WEB-INF/classes/mam.properties    ${filename}WEB-INF/classes/mam.properties_$nowtime
            \cp $properties_path/mam.properties ${filename}WEB-INF/classes/
            echo "复制 $properties_path/mam.properties到 ${filename}WEB-INF/classes/"
        else
            echo "${filename}WEB-INF/classes 不存在"
        fi
    done
}

function update_nginx_conf()
{
    echo -e "**************************************************"
    echo -e "*接下来将要更新nginx的emmweb.conf文件，配置emmweb访问IP"
    #echo -e "*emmweb访问IP"
    echo -e "**************************************************"
    emmweb_path=${basepath}/nginx/conf.d/emmweb_18443.conf
    while : 
    do
        read -p "是否需要修改更新nginx下emmweb.conf配置文件(Y/n):" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            read -p "选择工作的网卡(eno16777736):" input
            if [ "$input" == "" ]; then
                input="eno16777736"
            fi
            IPaddress=`LANG=C ifconfig ${input} | awk '/inet /{ print $2 }'`
            if [ "$IPaddress" == "" ]; then
                echo "获取不到网址IP，请手工输入："
            else
                echo "网卡IP为${IPaddress}"
                read -p "配置对外服务IP地址或域名${IPaddress}:" input
                if [ "$input" == "" ]; then
                    input=$IPaddress
                fi
                sed -i -c "s/192.168.1.100/${IPaddress}/g" ${emmweb_path}
            fi
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}

update_mam
#cover_mam
#update_nginx_conf
