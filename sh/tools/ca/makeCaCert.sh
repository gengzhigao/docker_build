#!/bin/sh

#first param addr: ip or dns

addr=$1

mkdir -p /opt/emm/ca
cd /opt/emm/ca

openssl genrsa -out ca.key 2048 
openssl req -new -out ca.csr -key ca.key -subj /C=CN/ST=Beijing/L=Beijing/O=3G2WIN/OU=AppCan/CN=${addr}
openssl x509 -req -in ca.csr -out ca.crt -signkey ca.key -days 7300
