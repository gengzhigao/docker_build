#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
docker run -itd --privileged=true -v ${basepath}:/data --restart=always --net=host --name=JOURNAL appcan/hadoop:2.5 /bin/start.sh /bin/bash
sleep 10s
docker logs JOURNAL 
