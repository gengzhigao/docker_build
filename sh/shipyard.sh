#!/bin/bash
dir_current=`pwd`

#二、加载镜像
function load_images()
{
    while : 
    do
		echo -e "**************************************************"
		echo -e "*shipyard servert 提供docker监控和运维功能*"
		echo -e "**************************************************"
        read -p "是否需要运行 shipyard 相关镜像(Y/n):" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			docker load < ${dir_current}/images/docker.io.microbox.etcd.latest.tar.gz
			docker load < ${dir_current}/images/docker.io.rethinkdb.latest.tar.gz
			docker load < ${dir_current}/images/docker.io.swarm.latest.tar.gz
			docker load < ${dir_current}/images/docker.io.shipyard.appcan.tar.gz
		fi
		if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
        echo ""
    done
}

#三、宿主机执行如下命令，运行服务端容器
function run_server()
{
    while : 
    do
		echo -e "**************************************************"
		echo -e "*shipyard servert 提供docker监控和运维功能*"
		echo -e "**************************************************"
        read -p "是否需要运行 shipyard server 端容器(Y/n):" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
			#运行rethinkdb数据库
			docker run -ti -d --net=host --restart=always --name shipyard-rethinkdb rethinkdb rethinkdb --bind all --http-port 9090
			#运行etcd容器
			docker run -ti -d --net=host --restart=always --name shipyard-discovery microbox/etcd -name discovery
			#运行swarm agent
			docker run -ti -d --net=host --restart=always --name shipyard-swarm-manager swarm:latest manage --host tcp://0.0.0.0:3375 etcd://0.0.0.0:4001
			#运行shipyard controller
			docker run -ti -d --net=host --restart=always --name shipyard-controller registry.service.consul:5000/shipyard:0.1 server -d tcp://0.0.0.0:3375 -l :8081 --rethinkdb-addr 0.0.0.0:28015        
		fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
        echo ""
    done
}

#四、在本机或者其他机器运行swarm agent
function run_agent()
{
    while : 
    do
        read -p "是否需要运行 swarm agent 容器(Y/n):" input
        if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]; then
            echo -e "**************************************************"
            echo -e "*swarm agent收集docker客户端信息*"
            echo -e "**************************************************"
            echo "开始启动swarm agent"
            read -p "选择工作的网卡(eno16777736):" input
            if [ "$input" == "" ]; then
                input="eno16777736"
            fi
            IPaddress=`LANG=C ifconfig ${input} | awk '/inet /{ print $2 }'`
            if [ "$IPaddress" == "" ]; then
                echo "获取不到网址IP，请手工输入："
            else
                echo "网卡IP为${IPaddress}"
                if [ "$input" == "" ]; then
                    input=$IPaddress
                fi
				docker run -ti -d --net=host --restart=always --name shipyard-swarm-agent swarm:latest join --addr ${IPaddress}:2375 etcd://${IPaddress}:4001
                break
            fi
        fi
        if [ "$input" == "y" ] || [ "$input" == "n" ] || [ "$input" == "Y" ] || [ "$input" == "N" ] || [ "$input" == "" ]; then
            break
        fi
        echo ""
    done
}
load_images
run_server
run_agent
