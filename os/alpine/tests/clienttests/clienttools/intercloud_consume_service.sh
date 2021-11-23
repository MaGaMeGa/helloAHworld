#!/bin/sh

SYSTEM_NAME="${1}"
address="$(jq -r ' .response | .[0].provider.address' intercloud_orchestration.response)"
port="$(jq -r ' .response | .[0].provider.port' intercloud_orchestration.response)"
uri="$(jq -r ' .response | .[0].serviceUri ' intercloud_orchestration.response)"

service="$(jq -r ' .response | .[0].service.serviceDefinition ' intercloud_orchestration.response)"
out_file="intercloud_$service.response"

callPath="https://$address:$port$uri"

echo $callPath


curl -v -s --insecure --cert-type P12 --cert "${SYSTEM_NAME}.p12":123456 $callPath  > $out_file
