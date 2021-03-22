#!/bin/sh

SYSTEM_NAME="${1}"
address="$(jq -r ' .response | .[0].provider.address' orchestration.response)"
port="$(jq -r ' .response | .[0].provider.port' orchestration.response)"
uri="$(jq -r ' .response | .[0].serviceUri ' orchestration.response)"

service="$(jq -r ' .response | .[0].service.serviceDefinition ' orchestration.response)"
out_file="$service.response"

callPath="https://$address:$port$uri"

echo $callPath


curl -v -s --insecure --cert-type P12 --cert "${SYSTEM_NAME}.p12":123456 $callPath  > $out_file
