#!/bin/sh

SYSTEM_NAME="${1}"
AUTH_INFO="${2}"
port="8888"

## FILL IN REQUEST TEMPLATE FIELDS WITH PARAMS
jq ".authenticationInfo  = \"${AUTH_INFO}\" | .systemName = \"$SYSTEM_NAME\" | .port = $port "  $PWD/templates/create_system.request.template > create_system.request 

out_file="create_system.response"
starttime=$(date)
echo "started system create request at :"$starttime  > $out_file.metadata

## SEND REGISTER SYSTEM REQUEST TO SERVICE REGISTRY CORE SYSTEM
## AS SYSTEM OPERATOR
curl -v -s --insecure --cert-type P12 --cert sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @create_system.request https://127.0.0.1:8443/serviceregistry/mgmt/systems > $out_file

endtime=$(date)
echo "finished system create request at : $endtime"  >> $out_file.metadata

## MOVE RESULTS TO CONSUMER DIRECTORY
mv $out_file ../$SYSTEM_NAME/
mv $out_file.metadata ../$SYSTEM_NAME/

## REMOVE TEMPORAL REQUEST
rm create_system.request
