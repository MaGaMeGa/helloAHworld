#!/bin/sh


systemName="${1}"
serviceDefinition="${2}"

start_file="start_ah_${systemName}_${serviceDefinition}_service.sh"
start_path="$PWD/services/$serviceDefinition"

service_file="ah_${systemName}_${serviceDefinition}_service"

## CREATE DIRECTORY TO SERVE CONTENT
mkdir services
mkdir services/$serviceDefinition

## CREATE CONTENT
jq . $serviceDefinition.content.template > $start_path/$serviceDefinition


## INIT START SERVER SCRIPT 
sed "s/SYSTEM_NAME=\"...\"/SYSTEM_NAME=\"$systemName\"/" server.template > $start_file 
mv $start_file $start_path

## INIT SERVER SERVICE FILE
sed "s/start_file=\"...\"/start_file=\"$start_path/$start_file\"/" provider.service.template > $service_file 


mv $service_file /etc/init.d/ 
rc-update add $service_file
rc -s $service_file start
