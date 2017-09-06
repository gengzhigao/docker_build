#!/bin/sh
#first param-- cn
#secend param -- password
#third param -- cert file name
#fouth param -- serial no
#fifth param -- output file location
#sixth param -- valid days
cn=$1
password=$2
certFileName=$3
serNo=$4
targetLoc=$5
days=$6

mkdir -p ${targetLoc}
cd ${targetLoc}

openssl genrsa -out ${certFileName}.key 2048 
openssl req -new -key ${certFileName}.key -out ${certFileName}.csr -subj /C=CN/ST=Beijing/L=Beijing/O=3G2WIN/OU=AppCan/CN=${cn}
openssl x509 -req -days ${days} -in ${certFileName}.csr -CA /opt/emm/ca/ca.crt -CAkey /opt/emm/ca/ca.key -out ${certFileName}.crt -set_serial ${serNo}
openssl pkcs12 -export -inkey ${certFileName}.key -in ${certFileName}.crt -out ${certFileName}.p12 -CAfile /opt/emm/ca/ca.crt -chain -passout pass:${password}
openssl x509 -fingerprint -in ${certFileName}.crt -noout

#delete extra file
rm -rf ${certFileName}.crt ${certFileName}.key ${certFileName}.csr
