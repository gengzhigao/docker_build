#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
emmweb_path=${basepath}/nginx/conf.d/emmweb_18443.conf

function update_nginx_conf()
{
    echo -e "**************************************************"
    echo -e "*接下来将要更新nginx的emmweb.conf文件，配置emmweb访问IP"
    echo -e "**************************************************"
    while : 
    do
        read -p "是否需要修改更新nginx下emmweb.conf配置文件(Y/n):" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            input="enp0s3"
            IPaddress=`LANG=C ifconfig ${input} | awk '/inet /{ print $2 }'`
            if [ "$IPaddress" == "" ]; then
                read -p "获取不到网址IP，请手工输入EMMWEB对应的IP地址或域名:" input
                if [ "$input" == "" ]; then
                    echo "您没有输入任何IP，请重新开始"
                    continue 
                fi
            else
                read -p "配置访问EMMWEB对应的IP地址或域名(${IPaddress}):" input
            fi
            if [ "$input" == "" ]; then
                input=$IPaddress
            fi
            echo "您输入的网卡IP是"$input"，下面将emm控制台的访问地址修改为$input"
            sed -i -c "s/t.appcan.cn/${input}/g" ${emmweb_path}
            break
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}
update_nginx_conf
