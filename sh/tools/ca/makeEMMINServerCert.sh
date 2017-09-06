#!/bin/sh

#param password
password=$1
CN=$2
DIR_CA=$3

mkdir -p /opt/emm/ca
cd /opt/emm/ca

openssl genrsa -out emmin.key 2048
openssl req -new -key emmin.key -out emmin.csr -subj /C=CN/ST=Beijing/L=Beijing/O=3G2WIN/OU=AppCan/CN=${CN}
openssl x509 -req -days 3650 -in emmin.csr -CA ca.crt -CAkey ca.key  -CAcreateserial -out emmin.crt -extfile ${DIR_CA}/ca/emmin.cnf -extensions ssl_server 
openssl pkcs12 -inkey emmin.key -in emmin.crt -export -out emmin.p12  -passout pass:${password}
keytool -importcert -v -trustcacerts  -alias ca_root -file ca.crt  -keystore emmin.keystore -storepass ${password}
