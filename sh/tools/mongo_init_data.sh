#!/bin/bash
source ~/.bash_profile
source /etc/profile
mongodb_home="/data"
mongodb_out_home="/data/mongo/MONGO"

function mongo_init_oa_data()
{
    echo -e "\n"
    echo -e "**************************************************"
    echo -e "*接下来将要初始化 OA MONGO 数据"
    echo -e "**************************************************"
    while :
    do
        read -p "是否需要初始化 OA MONGO 数据:(Y/n)" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            echo "-----------------下面开始初始化 OA MONGO 数据-------------------"
            # sleep 30s
            source ~/.bashrc
            # 解压缩导出文件
            tar -xzvf ${mongodb_out_home}/oa_data/appcan_mobileoa*.tar.gz -C ${mongodb_out_home}/oa_data/
            tar -xzvf ${mongodb_out_home}/oa_data/baasAppInfo*.tar.gz -C ${mongodb_out_home}/oa_data/
            docker exec -i MONGO /bin/bash <<EOF
                # 添加 baas 应用
                echo -e "\n\n **************************开始在mongodb数据库里添加 BAAS 应用**************************"
                mongoimport -d baas -c _AppInfo ${mongodb_home}/oa_data/baasAppInfo/AppInfo.json

                # 创建 emoa mongo 数据库
                echo -e "\n\n **************************开始在mongodb数据库里创建 emoa 数据库**************************"
                mongorestore -d appcan_mobileoa ${mongodb_home}/oa_data/appcan_mobileoa/

                # 检测 mongo 数据是否正常导入
                echo -e "\n\n **************************开始检测 mongo 数据是否正常导入**************************"
                ${mongodb_home}/oa_data/check.sh
EOF
            echo "-----------------初始化 OA MONGO 数据完毕-------------------"
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}
mongo_init_oa_data