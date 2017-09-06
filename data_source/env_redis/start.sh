#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="REDIS6379"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data -m 2g --restart=always --net=host --name=$NAME appcan/redis:0.1
sleep 5s
docker logs $NAME