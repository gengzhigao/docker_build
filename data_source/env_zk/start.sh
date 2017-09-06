#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="ZK"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --restart=always --net=host --name=$NAME appcan/zookeeper:0.7 /bin/start.sh /bin/bash
sleep 10s
docker logs $NAME
