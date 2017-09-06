#!/bin/bash
source ~/.bashrc
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="MYSQL"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --net=host --restart=always --name=$NAME appcan/mysql:0.1
sleep 30s
docker logs $NAME
