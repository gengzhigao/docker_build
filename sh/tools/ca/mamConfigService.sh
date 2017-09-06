#!/bin/bash

java -jar lib/appdo-jetty-mc-server-1.0.0.jar -p 8090 -t mc/mam-configure-server-webapp-3.2.0-SNAPSHOT.war -zk localhost
