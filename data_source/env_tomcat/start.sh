#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="EMMWEB"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --net=host --restart=always --name=$NAME appcan/tomcat7:0.1
docker logs $NAME

