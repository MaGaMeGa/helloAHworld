#!/bin/ash


authinfo="$(cat alpine1consumer.pub.authinfo)"
systemName="alpine1consumer"
port="8888"

jq ".authenticationInfo  = \"${authinfo}\" | .systemName = \"$systemName\" | .port = $port " create_system.request.template > create_system.request 
#echo $auth_request

out_file="create_system.response"
starttime=$(date)
echo "started system create request at :"$starttime  > $out_file.metadata

curl -v -s --insecure --cert-type P12 --cert /home/ah/tests/sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @create_system.request https://127.0.0.1:8443/serviceregistry/mgmt/systems > $out_file

endtime=$(date)
echo "finished system create request at :"endtime  > $out_file.metadata
