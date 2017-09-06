#/bin/bash
basepath=$(cd `dirname $0`; pwd)
update_source=$basepath/update_source
today=`date +%F`

# 更新补丁
function update
{
    cp -r $basepath/tigase-server $basepath/tigase-server_$today
    \cp -r $update_source/tigase-server/* $basepath/tigase-server/
}

update