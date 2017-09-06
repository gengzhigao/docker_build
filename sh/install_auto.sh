#!/bin/bash
domain="192.168.1.53"

function install_01_prepare()
{
		# 1、 build_yum
		# 2、 docker_install
		# 3、 docker_tools
		# 4、 configVim
		# 5、 rename_hostname
		# 6、 update_hosts_single
		# 7、 config_iptables
		# 8、 tools_install
		# 9、 java_install
		# 10、 config_env
		# 11、 create_lvm
	./01_prepare.sh <<@
		n
		y
		y
		y
		y
		y
		y
		y
		y
		y
		n
@
}

function install_02_load_images()
{	
	# 开始导入镜像，分别对应如下选项
	# 1、 docker_check
	# 2、 load_images
	./02_load_images.sh <<@
	y
	n
@
}

function install_run_db()
{		
	# begin install db on single machine，分别对应如下选项
	# 1、 db_install，要求输入主机名
	# 2、 开始进入cont_run：MYSQL ,是否解压缩
	# 3、 MYSQL ,是否运行容器
	# 4、 MONGO ,是否解压缩
	# 5、 MONGO ,是否运行容器
	# 6、 REDIS6379 ,是否解压缩
	# 7、 REDIS6379 ,是否运行容器
	# 8、 REDIS6380 ,是否解压缩
	# 9、 REDIS6380 ,是否运行容器
	# 10、 GFS ,是否解压缩
	# 11、 GFS ,是否运行容器

	./conn_run_db.sh <<@
env1
Y
Y
Y
Y
Y
Y
Y
Y
Y
Y
@
}

function install_config_db()
{
	# begin config db，分别对应如下选项
	# 1、 cont_config ,要求输入主机名
	# 2、 进入 cont_mysql ,是否选择配置集群,选Y才会进入 MySQL 初始化数据
	# 3、 进入 mysql_init_data ,是否初始化数据
	# 4、 是否初始化 OA 数据
	# 5、 是否需要替换域名，默认为 t.appcan.cn
	# 6、 输入 OA 域名，用变量替代
	# 7、 进入 cont_mongo ,单机直接进入 mongo_init_data ,是否初始化数据
	./conn_config_db.sh <<@
env1
Y
Y
Y
Y
${domain}
Y
@
}

function install_run_app()
{		
	# begin install app on single machine，分别对应如下选项
	# 1、 app_install ,要求输入主机名
	# 2、 开始进入cont_run: BAASADMIN ,是否解压缩
	# 3、 BAASADMIN ,是否运行容器
	# 4、 IM ,是否解压缩
	# 5、 IM ,是否运行容器
	# 6、 IM ,是否需要更新 IM 数据
	# 7、 EMMWEB ,是否解压缩
	# 8、 EMMWEB ,是否运行容器
	# 9、 是否配置 GlusterFS 客户端
	# 10、 是否配置 CA 证书
	# 11、 是否初始化根证书文件
	# 12、 输入服务器内部 IP
	# 13、 输入 domain 名称(或者IP)
	# 14、 是否信任此证书
	# 15、 是否需要修改mam.properties
	# 16、 输入 domain 名称(或者IP)，供mam.properties使用
	# 17、 NGINX ,是否解压缩
	# 18、 NGINX ,是否运行容器
	# 19、 是否更新nginx下emmweb.conf配置文件
	# 20、 输入 domain 名称(或者IP)，供emmweb_18443.conf文件使用
	# 21、 OA ,是否解压缩
	# 22、 OA ,是否运行容器
	# 23、 OA ,是否OA访问的域名
	# 24、 输入 domain 名称(或者IP)
	./conn_run_app.sh <<@
env1
Y
Y
Y
Y
Y
Y
Y
Y
Y
Y
${IP}
${domain}
Y
Y
${domain}
Y
Y
Y
${domain}
Y
Y
Y
${domain}
@
}

install_run_db
sleep 60s
install_config_db
install_run_app