#!/bin/sh


SYSTEM_NAME="${1}"
serviceDefinition="${2}"
SYSTEM_PORT=${3}

start_file="start_ah_${SYSTEM_NAME}_${serviceDefinition}_service.sh"
start_path="$PWD/services/$serviceDefinition"

service_file="ah_${SYSTEM_NAME}_${serviceDefinition}_service"
cert_file="${PWD}/${SYSTEM_NAME}.p12"


## CREATE DIRECTORY TO SERVE CONTENT
mkdir services
mkdir services/$serviceDefinition

## CREATE CONTENT
jq . $serviceDefinition.content.template > $start_path/$serviceDefinition

##COVERT AND COPY CERTS FOR OPENSSL S_SERVER
openssl pkcs12 -nocerts -out $SYSTEM_NAME-key.pem -in $cert_file
openssl pkcs12 -clcerts -nokeys -out $SYSTEM_NAME.pem -in $cert_file

chmod 777 $SYSTEM_NAME-key.pem
chmod 777 $SYSTEM_NAME.pem 

mv $SYSTEM_NAME-key.pem $start_path/$SYSTEM_NAME-key.pem 
mv $SYSTEM_NAME.pem $start_path/$SYSTEM_NAME.pem 

## INIT START SERVER SCRIPT 
sed "s/SYSTEM_NAME=\"...\"/SYSTEM_NAME=\"${SYSTEM_NAME}\"/" server.template > $start_file 
sed -i "s%SYSTEM_PORT=...%SYSTEM_PORT=${SYSTEM_PORT}%" $start_file 
sed -i "s%SERVER_PATH=\"...\"%SERVER_PATH=\"${start_path}\"%" $start_file 

chmod +x $start_file
mv $start_file $start_path

## INIT SERVER SERVICE FILE
sed "s%start_file=\"...\"%start_file=\"${start_path}/${start_file}\"%" provider.service.template > $service_file 

chmod +x $service_file
mv $service_file /etc/init.d/ 
rc-update add $service_file
rc -s $service_file start
