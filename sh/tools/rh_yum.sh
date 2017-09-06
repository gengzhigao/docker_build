#!/bin/bash

function mount_iso()
{
	mount /dev/cdrom /mnt
	if [ -d /mnt/Packages ]; then		
		echo -e "Disk is mount normal! begin install or update wget now!"
		rpm -Uvh /mnt/Packages/wget-1.12-1.8.el6.x86_64.rpm
	else
		echo -e "Disk is not mount normal!"
		exit
	fi
}

function make_yum()
{
	#1、删除rhel自带的yum源
	rpm -aq | grep yum|xargs rpm -e --nodeps

	#2、下载新的yum安装包
	wget http://mirrors.163.com/centos/6/os/x86_64/Packages/yum-metadata-parser-1.1.2-16.el6.x86_64.rpm
	wget http://mirrors.163.com/centos/6/os/x86_64/Packages/yum-3.2.29-81.el6.centos.noarch.rpm
	wget http://mirrors.163.com/centos/6/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.30-40.el6.noarch.rpm
	wget http://mirrors.163.com/centos/6/os/x86_64/Packages/python-urlgrabber-3.9.1-11.el6.noarch.rpm

	#3、安装yum包，注意的是标红的必须一起装，有依赖关系
	rpm -Uvh python-urlgrabber*.rpm
	rpm -ivh yum*

	#4、更改成163的yum源
	cd /etc/yum.repos.d/
	wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
	ls CentOS6-Base-163.repo

	# 把文件里面的$releasever全部替换为版本号，即6
	sed -i 's#$releasever#6#g' CentOS6-Base-163.repo

	#5、清除yum缓存
	yum clean all
	yum makecache
	#将服务器上的软件包信息缓存到本地,以提高搜索安装软件的速度
}

mount_iso
make_yum