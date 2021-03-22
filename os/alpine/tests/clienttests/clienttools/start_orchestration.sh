#!/bin/ash


systemName="${1}"
serviceDefinition="${2}"
authinfo="$(cat $systemName.pub.authinfo)"
address="127.0.0.1"
port="8888"
interface="HTTP-SECURE-JSON"

CORE_SYSTEM_SERVICE_NAME="orchestration-service"

orchestrator_address="$( jq -r '.serviceQueryData | .[].provider.address' )" sr_${CORE_SYSTEM_SERVICE_NAME}_query.reply
orchestrator_port="$( jq -r '.serviceQueryData | .[].provider.port' )" sr_${CORE_SYSTEM_SERVICE_NAME}_query.reply
orchestrator_uri="$( jq -r '.serviceQueryData | .[].serviceUri' )" sr_${CORE_SYSTEM_SERVICE_NAME}_query.reply

jq " .requestedService.interfaceRequirements = [\"$interface\"] | .requestedService.serviceDefinitionRequirement = \"$serviceDefinition\" | .requesterSystem.systemName = \"$systemName\" | .requesterSystem.port = $port | .requesterSystem.address = \"$address\" | .requesterSystem.authenticationInfo = \"$authinfo\" " orchestration.request.template > orchestration.request 
cat orchestration.request

out_file="orchestration.response"
starttime=$(date)
echo "started system create request at :"$starttime  > $out_file.metadata

curl -v -s --insecure --cert-type P12 --cert alpine1consumer.p12:123456 -X POST -H "Content-Type: application/json" -d @orchestration.request https://${orchestrator_address}:${orchestrator_port}/${orchestrator_uri} > $out_file


endtime=$(date)
