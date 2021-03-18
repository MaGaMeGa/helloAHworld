#!/bin/sh
./create_test_client_cert.sh testclient
./curl_create_system.sh
./create_service.sh
./create_auth_rule.sh
#edit service ...
#rc-update add .._service
#start provider service ... rc -s ...
./start_orchestration.sh
./consume_service.sh
#cat service...response  
