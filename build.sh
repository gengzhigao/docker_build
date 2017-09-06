#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
cd ${basepath}/gfs
./build.sh
cd ${basepath}/redis
./build.sh
cd ${basepath}/mysql
./build.sh
cd ${basepath}/mongo
./build.sh
cd ${basepath}/tomcat
./build.sh
cd ${basepath}/nginx
./build.sh
#cd im
