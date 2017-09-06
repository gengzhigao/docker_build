#待检查的进程组和其对应的启动进程名称
process_hbase=("HMaster" "HRegionServer")
process_hadoop=("NameNode DataNode" "namenode datanode")
process_zookeeper=("QuorumPeerMain")
root_path="/opt/emm_installer"

function checkMySQL()
{	
	name=$1
	if [ ! $name ]; then
		name="MYSQL"
	fi
	echo **************************下面开始检查MySQL进程******************************
	process_count=`ps -C mysqld --noheader |wc -l`
	if [ $process_count != 1 ]; then
		echo -e "\n抱歉的通知您，MySQL运行状态不正常，如下图所示:"
		docker-enter $name << EOF
			service MySQL status
EOF
	else
		echo -e "\n恭喜您, MySQL运行状态正常!"
	fi
}

# 检查Redis的运行状态
function checkRedis6379()
{	
	name=$1
	if [ ! $name ]; then
		name="REDIS6379"
	fi
	echo **************************下面开始检查Redis进程******************************
	count=`ps -ef |grep redis |grep 6379 |wc -l`
	if [ $count != 2 || $count != 1 ]; then
		echo -e "\n抱歉的通知您，redis_6379运行状态不正常，如下图所示:"
		docker-enter $name << EOF
			ps -ef |grep redis
EOF
	else
		echo -e "\n恭喜您, redis_6379运行状态正常!"
	fi

}

# 检查的Tomcat运行状态
function checkTomcat()
{	
	name=$1
	if [ ! $name ]; then
		name="EMMWEB"
	fi
	echo **************************下面开始检查Tomcat进程*****************************
	count=`ps -efu tomcat |grep tomcat6 |grep java |wc -l`
	if [ $count != 1 ]; then
		echo -e "\n抱歉的通知您，tomcat6运行状态不正常，如下图所示:"
		docker-enter $name << EOF
			service tomcat7 status		
EOF
	else
		echo -e "\n恭喜您, tomcat6运行状态正常!"
	fi

}

# 检查nginx的运行状态
function checkNginx()
{	
	name=$1
	if [ ! $name ]; then
		name="NGINX"
	fi
	echo **************************下面开始检查Nginx进程******************************
	count=`ps -C nginx --no-header |wc -l`
	if [ $count != 2 ]; then
		echo -e "\n抱歉的通知您，nginx运行状态不正常，如下图所示:"
		docker-enter $name << EOF
			service nginx status
EOF
	else
		echo -e "\n恭喜您, nginx运行状态正常!"
	fi

}

# 检查ZooKeeper的运行状态
function checkZooKeeper()
{
	name=$1
	if [ ! $name ]; then
		name="ZK"
	fi
	echo **************************下面开始检查ZooKeeper进程**************************

	count=`ps -ef |grep zoo.cfg |grep java |wc -l`
	if [ $count != 1 ]; then
		echo -e "\n抱歉的通知您，ZooKeeper工作进程不存在，可能进程已被关闭，请手动查找原因:"
		docker-enter $name << EOF
			service zookeeper status
EOF
	else
		echo -e "\n恭喜您, ZooKeeper运行状态正常!"
	fi

}

# 检查hadoop的运行状态
function checkHadoop()
{
	echo **************************下面开始检查Hadoop进程*****************************
	su - hadoop -s /bin/bash ${root_path}/check_hadoop.sh
}

# 检查hbase的运行状态
function checkHBase()
{
	echo **************************下面开始检查Hbase进程******************************
	su - hadoop -s /bin/bash ${root_path}/check_hbase.sh
}






checkRedis6379
checkTomcat
checkNginx
checkMySQL
#checkZooKeeper
#checkHadoop
#checkHBase

echo ""
