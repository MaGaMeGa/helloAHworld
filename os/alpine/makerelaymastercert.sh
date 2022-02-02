#!/bin/sh

ROOT_KEYSTORE=$1
ROOT_KEY_ALIAS=$2
ROOT_CERT_FILE="${ROOT_KEYSTORE%.*}.crt"
ROOT_PASS=$3
CLOUD_KEYSTORE=$4
CLOUD_KEY_ALIAS=$5
CLOUD_CERT_FILE="${CLOUD_KEYSTORE%.*}.crt"
CLOUD_PASS=${6}

if [ -f "${CLOUD_KEYSTORE}" ] && [ "${ROOT_KEYSTORE}" -nt "${CLOUD_KEYSTORE}" ]; then
  rm -f "${CLOUD_KEYSTORE}"
fi

if [ ! -f "${CLOUD_KEYSTORE}" ]; then

    keytool -genkeypair -v \
      -keystore "${CLOUD_KEYSTORE}" \
      -storepass "${CLOUD_PASS}" \
      -keyalg "RSA" \
      -keysize "2048" \
      -validity "3650" \
      -alias "${CLOUD_KEY_ALIAS}" \
      -keypass "${CLOUD_PASS}" \
      -dname "CN=${CLOUD_KEY_ALIAS}.${ROOT_KEY_ALIAS}" \
      -ext "BasicConstraints=ca:true,pathlen:2"

    keytool -importcert -v \
      -keystore "${CLOUD_KEYSTORE}" \
      -storepass "${CLOUD_PASS}" \
      -alias "${ROOT_KEY_ALIAS}" \
      -file "${ROOT_CERT_FILE}" \
      -trustcacerts \
      -noprompt

    keytool -certreq -v \
      -keystore "${CLOUD_KEYSTORE}" \
      -storepass "${CLOUD_PASS}" \
      -alias "${CLOUD_KEY_ALIAS}" \
      -keypass "${CLOUD_PASS}" |
      keytool -gencert -v \
        -keystore "${ROOT_KEYSTORE}" \
        -storepass "${ROOT_PASS}" \
        -validity "3650" \
        -alias "${ROOT_KEY_ALIAS}" \
        -keypass "${ROOT_PASS}" \
        -ext "BasicConstraints=ca:true,pathlen:2" \
        -rfc |
      keytool -importcert \
        -keystore "${CLOUD_KEYSTORE}" \
        -storepass "${CLOUD_PASS}" \
        -alias "${CLOUD_KEY_ALIAS}" \
        -keypass "${CLOUD_PASS}" \
        -trustcacerts \
        -noprompt
  fi

  if [ ! -f "${CLOUD_CERT_FILE}" ]; then

    keytool -exportcert -v \
      -keystore "${CLOUD_KEYSTORE}" \
      -storepass "${CLOUD_PASS}" \
      -alias "${CLOUD_KEY_ALIAS}" \
      -keypass "${CLOUD_PASS}" \
      -file "${CLOUD_CERT_FILE}" \
      -rfc
  fi
