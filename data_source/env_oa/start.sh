#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="OA"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true --net=host --restart=always --name $NAME -m 1024m -v ${basepath}:/data registry.service.consul:5000/saasoa:00.36 
sleep 5s
docker logs -f $NAME
