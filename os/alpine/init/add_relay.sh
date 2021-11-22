#!/bin/sh

#curl -v -s --insecure --cert-type P12 --cert /usr/share/arrowhead/certificates/testcloud2/sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @/home/sysop/utils/add_relay.template https://127.0.0.1:8449/gatekeeper/mgmt/relays > /home/sysop/utils/add_relay_to_tc2_cloud.response
curl -v -s --insecure --cert-type P12 --cert /usr/share/arrowhead/certificates/testcloud1/sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @/home/sysop/utils/add_relay.template https://127.0.0.1:18449/gatekeeper/mgmt/relays > /home/sysop/utils/add_relay_to_tc1_cloud.response
