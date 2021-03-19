#!/bin/ash


authinfo="$(cat alpine1consumer.pub.authinfo)"
systemName="alpine1consumer"
address="127.0.0.1"
port="8888"
serviceDefinition="helloword"
interface="HTTP-SECURE-JSON"

jq " .requestedService.interfaceRequirements = [\"$interface\"] | .requestedService.serviceDefinitionRequirement = \"$serviceDefinition\" | .requesterSystem.systemName = \"$systemName\" | .requesterSystem.port = $port | .requesterSystem.address = \"$address\" | .requesterSystem.authenticationInfo = \"$authinfo\" " orchestration.request.template > orchestration.request 
cat orchestration.request

out_file="orchestration.response"
starttime=$(date)
echo "started system create request at :"$starttime  > $out_file.metadata

curl -v -s --insecure --cert-type P12 --cert alpine1consumer.p12:123456 -X POST -H "Content-Type: application/json" -d @orchestration.request https://127.0.0.1:8441/orchestrator/orchestration > $out_file


endtime=$(date)
