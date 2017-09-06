#!/bin/sh

#first param addr: ip or dns
#second param password
password=$1

cd ca

#openssl genrsa -out ca.key 1024
#openssl req -new -out ca.csr -key ca.key -subj /C=CN/ST=Beijing/L=Beijing/O=3G2WIN/OU=AppCan/CN=${addr}
#openssl x509 -req -in ca.csr -out ca.crt -signkey ca.key -days 7300

keytool -genkey -alias wlserver_cert -keyalg RSA -keysize 2048 -dname cn=EMM,ou=AppCan,o=3G2WIN,l=Beijing,st=Beijing,c=CN -keypass ${password} -keystore wlserver.jks -storepass ${password} -validity 7300
keytool -certreq -alias wlserver_cert -file wlserver.csr -keypass ${password} -keystore wlserver.jks -storepass ${password}
openssl x509 -req -in wlserver.csr -out wlserver.crt -CA ca.crt -CAkey ca.key -days 7300 -CAcreateserial -extfile /opt/emm/sbin/server.cnf  -extensions ssl_server
keytool -import -alias rootca -trustcacerts -file ca.crt -keystore wlserver.jks -storepass ${password}
keytool -import -alias wlserver_cert -trustcacerts -file wlserver.crt -keypass ${password} -keystore wlserver.jks -storepass ${password}