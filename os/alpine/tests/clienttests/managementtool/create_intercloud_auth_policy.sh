#!/bin/sh

CLOUD_ID="${1}"

providerId="$(jq '.provider.id' register_service.response)"

serviceDefinitionId="$(jq '.serviceDefinition.id' register_service.response)"
serviceInterfaceId="$(jq '.interfaces | .[0].id' register_service.response)"


jq ".cloudId  = $CLOUD_ID | .providerIdList = [$providerId] | .serviceDefinitionIdList = [$serviceDefinitionId] | .interfaceIdList = [$serviceInterfaceId] " inter_auth.request.template > inter_auth.request 
cat inter_auth.request 

curl -v -s --insecure --cert-type P12 --cert sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @inter_auth.request https://127.0.0.1:18445/authorization/mgmt/intercloud > inter_auth.response
