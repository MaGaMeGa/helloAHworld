curl -s -v --insecure --cert-type P12 --cert sysop.p12:123456 -X GET https://127.0.0.1:8443/serviceregistry/echo > sr_echo_test.result
