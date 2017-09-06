#!/bin/sh

#param password
password=$1
CN=$2
DIR_CA=$3

mkdir -p /opt/emm/ca
cd /opt/emm/ca

openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj /C=CN/ST=Beijing/L=Beijing/O=3G2WIN/OU=AppCan/CN=${CN}
openssl x509 -req -days 3650 -in server.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out server.crt -extfile ${DIR_CA}/ca/server.cnf -extensions ssl_server 
openssl pkcs12 -inkey server.key -in server.crt -export -out server.p12  -passout pass:${password}
keytool -importcert -v -trustcacerts  -alias ca_root -file ca.crt  -keystore server.keystore -storepass ${password}
