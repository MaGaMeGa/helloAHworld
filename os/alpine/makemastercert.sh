#!/bin/sh

ROOT_KEYSTORE=$1
ROOT_KEY_ALIAS=$2
ROOT_CERT_FILE="${ROOT_KEYSTORE%.*}.crt"
PASSWORD=${3}

  if [ ! -f "${ROOT_KEYSTORE}" ]; then
    
    mkdir -p "$(dirname "${ROOT_KEYSTORE}")"
    rm -f "${ROOT_CERT_FILE}"

    keytool -genkeypair -v \
      -keystore "${ROOT_KEYSTORE}" \
      -storepass "${PASSWORD}" \
      -keyalg "RSA" \
      -keysize "2048" \
      -validity "3650" \
      -alias "${ROOT_KEY_ALIAS}" \
      -keypass "${PASSWORD}" \
      -dname "CN=${ROOT_KEY_ALIAS}" \
      -ext "BasicConstraints=ca:true,pathlen:3"
  fi

  if [ ! -f "${ROOT_CERT_FILE}" ]; then

    keytool -exportcert -v \
      -keystore "${ROOT_KEYSTORE}" \
      -storepass "${PASSWORD}" \
      -alias "${ROOT_KEY_ALIAS}" \
      -keypass "${PASSWORD}" \
      -file "${ROOT_CERT_FILE}" \
      -rfc
  fi
