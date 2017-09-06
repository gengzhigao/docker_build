#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)

function gluster_client_os()
{
	echo -e "**************************************************"
	echo -e "*接下来将要配置宿主机glusterfs客户端软件"
	echo -e "**************************************************"
	while :
	do

		read -p "是否需要配置宿主机glusterfs客户端软件:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			yum install -y glusterfs glusterfs-cli glusterfs-fuse
			if [ ! -d /opt/emm ]; then
				mkdir -p /opt/emm
			elif [ `df -m | grep /opt/emm |wc -l` -gt 0 ]; then
				umount /opt/emm
				#rm -rf /opt/emm
			fi
			mount -t glusterfs gfs-master:datastore /opt/emm
			echo "mount -t glusterfs gfs-master:datastore /opt/emm" >> /etc/rc.d/rc.local
			chmod +x /etc/rc.d/rc.local  
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function init_ca()
{
	echo -e "**************************************************"
	echo -e "*接下来将在宿主机配置ca证书，供EMM HTTPS使用"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要在宿主机配置ca证书:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			${dir_current}/initca.sh
			#${dir_current}/initca_emmin.sh
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}
gluster_client_os
init_ca
