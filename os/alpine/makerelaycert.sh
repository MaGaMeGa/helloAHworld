#!/bin/sh

ROOT_CERT_PATH=${1} # root cert file path with extention (as .crt)
ROOT_CERT_FILE="${ROOT_CERT_PATH%.*}.crt"
ROOT_KEY_ALIAS=${2}
CLOUD_KEYSTORE=${3} # file extention (as .p12) is requered!!!
CLOUD_KEY_ALIAS=${4} # must be the same as in defined in keystore file
CLOUD_CERT_FILE="${CLOUD_KEYSTORE%.*}.crt"
CLOUD_PASS=${5}

SYSTEM_PATH=${6}
SYSTEM_KEY_ALIAS=${7}
SYSTEM_KEYSTORE="${SYSTEM_PATH}${SYSTEM_KEY_ALIAS}.p12"
SYSTEM_PASS=${8}
SYSTEM_PUB_FILE="${SYSTEM_KEYSTORE%.*}.pub"
SAN="dns:localhost,ip:127.0.0.1,ip:${9}"
DNAME="CN=${SYSTEM_KEY_ALIAS}.${CLOUD_KEY_ALIAS}.${ROOT_KEY_ALIAS}"

  if [ -f "${SYSTEM_KEYSTORE}" ] && [ "${CLOUD_KEYSTORE}" -nt "${SYSTEM_KEYSTORE}" ]; then
    rm -f "${SYSTEM_KEYSTORE}"
  fi

  if [ ! -f "${SYSTEM_KEYSTORE}" ]; then

    keytool -genkeypair -v \
      -keystore "${SYSTEM_KEYSTORE}" \
      -storepass "${SYSTEM_PASS}" \
      -keyalg "RSA" \
      -keysize "2048" \
      -validity "3650" \
      -alias "${SYSTEM_KEY_ALIAS}" \
      -keypass "${SYSTEM_PASS}" \
      -dname "${DNAME}" \
      -ext "SubjectAlternativeName=${SAN}"

    keytool -importcert -v \
      -keystore "${SYSTEM_KEYSTORE}" \
      -storepass "${SYSTEM_PASS}" \
      -alias "${ROOT_KEY_ALIAS}" \
      -file "${ROOT_CERT_FILE}" \
      -trustcacerts \
      -noprompt

    keytool -importcert -v \
      -keystore "${SYSTEM_KEYSTORE}" \
      -storepass "${SYSTEM_PASS}" \
      -alias "${CLOUD_KEY_ALIAS}" \
      -file "${CLOUD_CERT_FILE}" \
      -trustcacerts \
      -noprompt

    keytool -certreq -v \
      -keystore "${SYSTEM_KEYSTORE}" \
      -storepass "${SYSTEM_PASS}" \
      -alias "${SYSTEM_KEY_ALIAS}" \
      -keypass "${SYSTEM_PASS}" |
      keytool -gencert -v \
        -keystore "${CLOUD_KEYSTORE}" \
        -storepass "${CLOUD_PASS}" \
        -validity "3650" \
        -alias "${CLOUD_KEY_ALIAS}" \
        -keypass "${CLOUD_PASS}" \
        -ext "SubjectAlternativeName=${SAN}" \
        -rfc |
      keytool -importcert \
        -keystore "${SYSTEM_KEYSTORE}" \
        -storepass "${SYSTEM_PASS}" \
        -alias "${SYSTEM_KEY_ALIAS}" \
        -keypass "${SYSTEM_PASS}" \
        -trustcacerts \
        -noprompt
  fi

  if [ ! -f "${SYSTEM_PUB_FILE}" ]; then

    keytool -list \
      -keystore "${SYSTEM_KEYSTORE}" \
      -storepass "${SYSTEM_PASS}" \
      -alias "${SYSTEM_KEY_ALIAS}" \
      -rfc |
      openssl x509 \
        -inform pem \
        -pubkey \
        -noout >"${SYSTEM_PUB_FILE}"
  fi
