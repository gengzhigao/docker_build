#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="MONGO"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --restart=always --net=host --name=$NAME appcan/mongo:0.1
sleep 10s
docker logs $NAME
