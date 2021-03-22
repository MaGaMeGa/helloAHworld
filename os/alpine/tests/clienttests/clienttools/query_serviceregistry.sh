#!/bin/sh

SYSTEM_NAME="${1}"
CORE_SYSTEM_SERVICE_NAME="${2}"

jq ".serviceDefinitionRequirement = ${CORE_SYSTEM_SERVICE_NAME} " sr_entry.request.templates > sr_${CORE_SYSTEM_SERVICE_NAME}_entry.request

curl -v -s --insecure --cert-type P12 --cert ${SYSTEM_NAME}.p12:123456 -X POST -H "Content-Type: application/json" -d @sr_${CORE_SYSTEM_SERVICE_NAME}_entry.request https://127.0.0.1:8443/serviceregistry/query > sr_${CORE_SYSTEM_SERVICE_NAME}_query.reply
