#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="NGINX"
fi
basepath=$(cd `dirname $0`; pwd)
docker run --privileged=true -itd -v ${basepath}:/data --net=host --restart=always --name=$NAME appcan/nginx:0.1
sleep 5s
docker logs $NAME
