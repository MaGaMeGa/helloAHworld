!#/bin/sh

mysql -h 172.17.0.2 -uroot -p -e "use arrowhead; select authentication_info from system_ where system_name = 'gatekeeper' ;" > /tmp/tc1_gk_auth.info 
mysql -h 172.17.0.3 -uroot -p -e "use arrowhead; select authentication_info from system_ where system_name = 'gatekeeper' ;" > /tmp/tc2_gk_auth.info 

TC1_GK_AUTH="$( sed -n 2p /tmp/tc1_gk_auth.info)"
TC2_GK_AUTH="$( sed -n 2p /tmp/tc2_gk_auth.info)"

sed 's/n_cloud_name/testcloud1/' /home/sysop/utils/add_neighbor_cloud.template | sed "s%n_gk_auth_info%$TC1_GK_AUTH%" > /tmp/add_neighbor_to_tc2.request
sed 's/n_cloud_name/testcloud2/' /home/sysop/utils/add_neighbor_cloud.template | sed "s%n_gk_auth_info%$TC2_GK_AUTH%" > /tmp/add_neighbor_to_tc1.request

curl -v -s --insecure --cert-type P12 --cert /usr/share/arrowhead/certificates/testcloud2/sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @/tmp/add_neighbor_to_tc2.request https://127.0.0.1:8449/gatekeeper/mgmt/clouds > /home/sysop/utils/add_neighbor_to_tc2_cloud.response
curl -v -s --insecure --cert-type P12 --cert /usr/share/arrowhead/certificates/testcloud1/sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @/tmp/add_neighbor_to_tc1.request https://127.0.0.1:18449/gatekeeper/mgmt/clouds > /home/sysop/utils/add_neighbor_to_tc1_cloud.response
