#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="BAASADMIN"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --net=host --restart=always --name=$NAME appcan/mas/baas:1.5 /bin/start.sh /bin/bash
sleep 10s
docker logs $NAME
