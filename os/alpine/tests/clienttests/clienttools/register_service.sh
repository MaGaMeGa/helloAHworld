#!/bin/sh

systemName="${1}"
serviceDefinition="${2}"
authinfo="$(cat $systemName.pub.authinfo)"
secure="CERTIFICATE"
port=9998
serviceUri="/$serviceDefinition"

out_file_request="register_${serviceDefinition}_service.request"
out_file_response="register_${serviceDefinition}_service.response"

## CREATE DIRECTORY TO SERVE CONTENT
mkdir services
mkdir services/$serviceDefinition

## CREATE CONTENT TO SERVE 
echo "{\"hello\":\"world\"}" > services/$serviceDefinition/$serviceDefinition

jq ".interfaces = [\"HTTP-SECURE-JSON\"] | del ( .metadata ) | del ( .version ) | .providerSystem.port = $port | .providerSystem.authenticationInfo  = \"${authinfo}\" | .providerSystem.systemName = \"$systemName\" | .secure = \"$secure\" | .serviceDefinition = \"$serviceDefinition\" | .serviceUri = \"$serviceUri\" " register_service.request.template > $out_file_request 

curl -v -s --insecure --cert-type P12 --cert $systemName.p12:123456 -X POST -H "Content-Type: application/json" -d @$out_file_request https://127.0.0.1:8443/serviceregistry/register > $out_file_response
