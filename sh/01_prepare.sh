#!/bin/bash
# basepath 当前脚本所在目录
basepath=$(cd `dirname $0`; pwd)

function build_yum()
{
	echo -e "**************************************************"
	echo -e "*接下来将要构建 docker 本地 yum 源，构建 docker 本地"
	echo -e "*yum 源之前，请确保 docker 安装文件夹为 /opt/docker"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要构建 docker 本地 yum 源:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始构建 docker 本地 yum 源"
			mkdir -p ${basepath}/../docker_yum
			if [[ `find ${basepath}/../ -name "docker_yum_*.tar.gz" |wc -l` -gt 0 ]]; then
				echo "docker_yum tar包已存在，无需拷贝"
			elif [[ `find ${basepath}/../docker_yum -name "docker_yum_*.tar.gz" |wc -l` -gt 0  ]]; then
				\cp ${basepath}/../docker_yum/docker_yum_*.tar.gz ${basepath}/../
			fi			
			if [[ `tar -tvf ${basepath}/../docker_yum*.tar.gz |grep "docker_yum" |wc -l` -eq 0 ]]; then
				tar -xzvf ${basepath}/../docker_yum*.tar.gz -C ${basepath}/../docker_yum
				rm -rf ${basepath}/../docker_yum/docker_yum*.tar.gz
			else
				tar -xzvf ${basepath}/../docker_yum*.tar.gz -C ${basepath}/../
			fi
			\cp env/docker.repo /etc/yum.repos.d/
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function docker_install()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要安装docker，APPCAN产品将允许在docker之中"
	echo -e "**************************************************"
	while :
	do
		read -p "是否安装 docker:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始安装 docker"
			#yum -y update lvm2
			yum -y install yum-utils device-mapper-persistent-data lvm2 docker
			systemctl start docker
			systemctl enable docker
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function docker_tools()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要配置 docker 环境变量，增加docker-enter功能"
	echo -e "**************************************************"
	while :
	do
		read -p "是否配置 docker 环境变量:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始配置 docker环境变量"
			\cp env/.bashrc_docker ~/.bashrc_docker
			echo "[ -f ~/.bashrc_docker ] && . ~/.bashrc_docker" >> ~/.bashrc
			source ~/.bashrc
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function configVim()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要配置vim"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要配置vim格式缩进:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			yum -y install vim
			if [ `cat /etc/vimrc |grep -c "sw=4"` -eq 0 ]; then
				echo "set sw=4" >> /etc/vimrc
				echo "set ts=4" >> /etc/vimrc
				echo "filetype indent on" >> /etc/vimrc
				echo "autocmd FileType python setlocal et sta sw=4 sts=4" >> /etc/vimrc
				echo "******************************Vim配置完毕****************************"
				break
			else
				echo "**********************Vim已经配置，无需再次配置************************"
				break
			fi
			break
		fi
		
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ]; then
			break
		fi
	done
}

function rename_hostname()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要更改hostname"
	echo -e "**************************************************"
	while :
	do
		read -p "是否更改 hostname:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			read -p "请输入主机名(默认为env1.emm，若无需更改直接回车即可):" input
			if [ "$input" == "" ]; then
				input="env1.emm"
			fi
			echo "$input" > /etc/hostname
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function update_hosts()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要更新hosts文件中的IP"
	echo -e "**************************************************"
	while :
	do
		read -p "是否更新 hosts 文件:(Y/n)" input
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
			echo "下面开始设置hosts，将127.0.0.1更换为实际IP${input}"
			sed -i -c "s/127.0.0.1/$IPaddress/g" /etc/hosts
			break
			fi
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function update_hosts_single()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要更新hosts文件中的IP"
	echo -e "**************************************************"
	while :
	do
		read -p "是否更新 hosts 文件:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			\cp ${basepath}/env/hosts-single /etc/hosts
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function config_iptables()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要安装、配置iptables，并关闭SELinux"
	echo -e "**************************************************"
	while :
	do
		read -p "是否安装 iptables ，并关闭SELinux:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始安装并配置 iptables 服务"
			yum -y install iptables-services iptables 
			systemctl stop firewalld.service
			systemctl disable firewalld.service
			systemctl disable iptables
			#systemctl start iptables.service
			\cp ${basepath}/env/iptables /etc/sysconfig/iptables
			#systemctl restart iptables.service
			setenforce 0
			sed -i -c "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/sysconfig/selinux
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function tools_install()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要安装并配置基础工具包，包括net-tools"
	echo -e "*telnet、sysstat、openssl、ntpdate、unzip、MySQL"
	echo -e "*tcpdump  iftop nethogs mongodb 客户端"
	echo -e "**************************************************"
	while :
	do
		read -p "是否安装并配置基础工具包:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始安装并配置基础工具包"
			yum -y install net-tools telnet sysstat openssl ntpdate unzip svn tcpdump iftop nethogs mysql mongodb
			break
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}


function java_install()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将要安装JDK, AppCan 产品中EMM、MAS、IM都需要"
	echo -e "*JDK进行支持。"
	echo -e "**************************************************"
	while :
	do
		read -p "是否安装JDK:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			echo "开始安装JAVA JDK"
			#yum -y install jdk --enablerepo=docker
			yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel
			source /etc/profile
			echo "初始化JAVA 环境变量完成,Java的环境变量如下:"
			java -version
			echo "${JAVA_HOME}"
			echo "${JRE_HOME}"
			echo "${PATH}"			
			echo "安装JDK结束"
			source /etc/profile
			break
		fi
		source /etc/profile
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function config_env()
{
	echo -e "\n"
	echo -e "**************************************************"
	echo -e "*接下来将配置 APPCAN 环境变量，这些环境变量主要是针"
	echo -e "*对系统进行一些优化工作"
	echo -e "**************************************************"
	while :
	do
		read -p "是否需要配置 APPCAN 环境变量:(Y/n)" input
		if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			config_env_limits
			config_env_sysctl
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
			break
		fi
	done
}

function config_env_limits()
{
	grep "APPCAN LIMITS ENV" /etc/security/limits.conf >/dev/null
	if [ $? -eq 0 ]; then
		echo -e "APPCAN LIMITS 环境变量已经初始化\n\n"
	else
		echo "****************开始初始化 APPCAN LIMITS 环境变量****************"
		echo "#**************APPCAN LIMITS ENV********************" >> /etc/security/limits.conf
		echo -e "*\tsoft\tnofile\t655350" >> /etc/security/limits.conf
		echo -e "*\thard\tnofile\t655350" >> /etc/security/limits.conf
		echo -e "*\tsoft\tnproc\t655350" >> /etc/security/limits.conf
		echo -e "*\thard\tnproc\t655350" >> /etc/security/limits.conf
		echo -e "*\tsoft\tnofile\t655350" >> /etc/security/limits.d/20-nproc.conf
		echo -e "*\thard\tnofile\t655350" >> /etc/security/limits.d/20-nproc.conf
		echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.d/rc.local
		echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >> /etc/rc.d/rc.local
		chmod +x /etc/rc.d/rc.local
		echo "初始化 APPCAN LIMITS 环境变量结束****************"
	fi
}

function config_env_sysctl()
{
	grep "APPCAN SYSCTL ENV" /etc/sysctl.conf >/dev/null
	if [ $? -eq 0 ]; then
		echo -e "APPCAN SYSCTL 环境变量已经初始化\n\n"
	else
		echo "****************开始初始化 APPCAN SYSCTL 环境变量****************"
		echo "#**************APPCAN SYSCTL ENV********************" >> /etc/sysctl.conf
		echo "fs.file-max = 655536" >> /etc/sysctl.conf
		echo "vm.overcommit_memory = 1" >> /etc/sysctl.conf
		echo "net.core.somaxconn = 10240" >> /etc/sysctl.conf
		echo "net.ipv4.tcp_fin_timeout = 30" >> /etc/sysctl.conf
		echo "net.netfilter.nf_conntrack_max = 655350" >> /etc/sysctl.conf
		echo "net.netfilter.nf_conntrack_tcp_timeout_established = 1200" >> /etc/sysctl.conf
		#echo "net.core.netdev_max_backlog = 32768" >> /etc/sysctl.conf
		#echo "net.core.rmem_default = 8388608" >> /etc/sysctl.conf
		#echo "net.core.rmem_max = 16777216" >> /etc/sysctl.conf
		#echo "net.core.somaxconn = 32768" >> /etc/sysctl.conf
		#echo "net.core.wmem_default = 8388608" >> /etc/sysctl.conf
		#echo "net.core.wmem_max = 16777216" >> /etc/sysctl.conf
		#echo "net.ipv4.ip_local_port_range = 5000    65000" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_fin_timeout = 30" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_keepalive_time = 300" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_max_orphans = 3276800" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_max_syn_backlog = 65536" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_max_tw_buckets = 5000" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_mem = 94500000 915000000 927000000" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_syn_retries = 2" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_synack_retries = 2" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_timestamps = 0" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
		#echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
		echo "****************初始化 APPCAN SYSCTL 环境变量结束****************"
	fi
	echo "目前sysctl设置如下："
	sysctl -p
}

function create_lvm()
{
	tools/lvm_create.sh
}

build_yum
docker_install
docker_tools
configVim
rename_hostname
update_hosts_single
config_iptables
tools_install
java_install
config_env
create_lvm
