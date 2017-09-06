#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="GFS"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v $basepath:/data --net=host --restart=always --name=$NAME appcan/gfs:0.1
sleep 15s
docker logs $NAME
