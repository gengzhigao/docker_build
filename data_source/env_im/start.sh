#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="IM"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --net=host --restart=always --name=$NAME  appcan/im:0.1
sleep 10s
docker logs $NAME
