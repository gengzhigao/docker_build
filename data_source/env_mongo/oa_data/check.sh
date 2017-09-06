#!/bin/bash
source /etc/profile
mongo baas << EOF1
    db.getCollection("_AppInfo").find({"selfKey.appId":"1846:MOBILEOA"});
EOF1
