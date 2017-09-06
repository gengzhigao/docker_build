#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)

function create_lvm_data()
{
    read -p "是否需要为data目录创建LVM:(Y/n)" input
    if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
        # create LV
        lvcreate --wipesignatures y -n data docker -l 100%FREE

        if [ -L /dev/docker/data ]; then
            echo -e "\n\n********** 接下来将要初始化data lv并绑定到/data目录 **********"
            mkfs.ext4 /dev/docker/data
            mkdir -p /data
            mount /dev/docker/data /data
            grep "APPCAN LVM ENV" /etc/fstab >/dev/null
            if [ $? -eq 0 ]; then
                echo -e "LVM 环境变量已经初始化\n\n\n"
            else
                echo "**************** 开始初始化 LVM 环境变量****************"
                echo "#**************APPCAN LVM ENV********************" >> /etc/fstab
                cp /etc/fstab /etc/fstab_bak_ggz_`date "+%Y%m%d"`
                echo "/dev/docker/data /data ext4 defaults 1 1" >> /etc/fstab
            fi
            echo -e "\n\n******************** 磁盘信息如下 ********************"
            df -Th
        else
            echo -e "\n\n \033[31m *********** data LVM 创建失败，请手工核实原因，谢谢！ ************ \033[0m"
        fi
    fi
}

function create_lvm()
{
    echo -e "\n"
    dir_docker="/var/lib/docker"
    echo -e "**************************************************"
    echo -e "*接下来将要为docker创建LVM，docker将使用dockerdata"
    echo -e "*的元数据"
    echo -e "**************************************************"
    while :
    do
        read -p "是否需要为docker创建LVM:(Y/n)" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            read -p "请输入需要创建LVM的磁盘或者分区名称(默认为/dev/sdb):" input
            if [ "$input" == "" ]; then
                input="/dev/sdb"
            fi
            # 删除现有docker目录
            systemctl stop docker
            rm -rf ${dir_docker}

            # create VG
            diskpath=${input}
            A=`pvcreate ${diskpath}`
            if [ "${A}" == "" ]; then
                echo "${diskpath}该磁盘(分区)不存在，请使用fdisk -l命令检查后，重新输入："
                continue
            else
                # create VG
                echo -e "\n**************** 开始创建 docker VG ****************"
                vgcreate docker ${diskpath}

                # create LV
                echo -e "\n**************** 开始在 docker VG 下创建 thinpool LV ****************"
                lvcreate --wipesignatures y -n thinpool docker -L 50G

                # create LV
                echo -e "\n**************** 开始在 docker VG 下创建 thinpoolmeta LV ****************"
                lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG

                # Convert the volumes to a thin pool and a storage location for metadata for the thin pool
                echo -e "\n**************** Convert the volumes to a thin pool ****************"
                lvconvert -y --zero n -c 512K --thinpool docker/thinpool --poolmetadata docker/thinpoolmeta

                # Configure autoextension of thin pools via an lvm profile.
                if [ -f ${dir_current}/../env/docker-thinpool.profile ]; then
                    \cp ${dir_current}/../env/docker-thinpool.profile /etc/lvm/profile/docker-thinpool.profile
                elif [ -f ${dir_current}/docker-thinpool.profile ]; then
                    \cp ${dir_current}/docker-thinpool.profile /etc/lvm/profile/docker-thinpool.profile
                fi

                # Apply the LVM profile, using the lvchange command.
                echo -e "\n**************** Apply the LVM profile ****************"
                lvchange --metadataprofile docker-thinpool docker/thinpool

                # Enable monitoring for logical volumes on your host. 
                echo -e "\n**************** Enable monitoring for logical volumes on your host ****************"
                lvs -o+seg_monitor
                
                # 同步docker配置文件
                if [ -f ${dir_current}/../env/daemon.json ]; then
                    \cp ${dir_current}/../env/daemon.json /etc/docker/daemon.json
                elif [ -f ${dir_current}/daemon.json ]; then
                    \cp ${dir_current}/daemon.json /etc/docker/daemon.json
                fi

                create_lvm_data
                echo -e "\n\n******************** LVM信息如下 ********************:"
                lsblk

                systemctl restart docker
                echo -e "\n\n******************** docker 运行信息如下********************:"
                docker info
                echo -e "\n"
                break
            fi
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
    done
}

create_lvm