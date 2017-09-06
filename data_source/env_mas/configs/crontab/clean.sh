#!/bin/bash
dir_current=$(cd `dirname $0`; pwd)
source ~/.bash_profile

function clean_outer()
{
	NAME=$1
	if [ "$NAME" == "" ]; then
	    NAME="BAASIN"
	fi
	docker exec -i $NAME /bin/bash <<EOF
	    rm -rf /core.*
EOF
}

function clean_inner()
{
	counter=`ls / |grep "core" |wc -l`
	if [ $counter -gt 0 ]; then
		echo "`date`---->clean $counter 个core file" >> $dir_current/crontab.log
    	rm -rf /core.*
	fi
}

clean_inner