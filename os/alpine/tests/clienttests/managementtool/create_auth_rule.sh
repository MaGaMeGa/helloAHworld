#!/bin/sh


providerId="$(jq '.provider.id' register_service.response)"

#serviceDefinition="$(jq '.serviceDefinition.id' register_service.response)"
serviceDefinitionId="$(jq '.serviceDefinition.id' register_service.response)"
serviceInterfaceId="$(jq '.interfaces | .[0].id' register_service.response)"
consumerId="$(jq '.id' create_system.response)"

jq ".consumerId  = $consumerId | .providerIds = [$providerId] | .serviceDefinitionIds = [$serviceDefinitionId] | .interfaceIds = [$serviceInterfaceId] " intra_auth.request.template > intra_auth.request 
#cat intra_auth.request 

curl -v -s --insecure --cert-type P12 --cert sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @intra_auth.request https://127.0.0.1:8445/authorization/mgmt/intracloud > intra_auth.response
