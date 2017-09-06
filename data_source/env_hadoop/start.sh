#!/bin/bash
NAME=$1
if [ "$NAME" == "" ]; then
	NAME="HADOOP"
fi
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v $basepath:/data --restart=always --net=host --name=$NAME appcan/hadoop:2.5 /bin/start.sh /bin/bash
if [ "$NAME" == "JOURNAL" ]; then
	sleep 15s
	docker logs $NAME
elif [[ "$NAME" == "HADOOP" ]]; then
	docker logs -f $NAME
fi
