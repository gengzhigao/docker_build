#!/bin/bash
source ~/.bash_profile
NAME=$1
if [ "$NAME" == "" ]; then
    NAME="BAASIN"
fi
docker exec -i $NAME /bin/bash <<EOF
    rm -rf /core.*
EOF