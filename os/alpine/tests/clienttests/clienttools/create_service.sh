

authinfo="$(cat alpine1provider.pub.authinfo)"
secure="CERTIFICATE"
systemName="alpine1provider"
port=9998
serviceDefinition="helloword"
serviceUri="/helloword"


jq ".interfaces = [\"HTTP-SECURE-JSON\"] | del ( .metadata ) | del ( .version ) | .providerSystem.port = $port | .providerSystem.authenticationInfo  = \"${authinfo}\" | .providerSystem.systemName = \"$systemName\" | .secure = \"$secure\" | .serviceDefinition = \"$serviceDefinition\" | .serviceUri = \"$serviceUri\" " register_service.request.template > register_service.request 
#echo $auth_request

curl -v -s --insecure --cert-type P12 --cert alpine1provider.p12:123456 -X POST -H "Content-Type: application/json" -d @register_service.request https://127.0.0.1:8443/serviceregistry/register > register_service.response
