#!/bin/sh

err(){
	echo "[$(date +'%Y-%m-%dT%H:%M:%S.%3N%z')]: $*" >&2
} 

echo "starting truststore generation, based on : ${3}"

if [ ! -z ${1} ]; then
	DST_PATH=${1}
else
	err "Argument 1 must be an existing, writeable directory: the destination of the new truststore."
	exit 1
fi

if [ ! -z ${2} ]; then
	SRC_PATH=${2}
else
	err "Argument 2 must be an existing, readable directory: the location of the trusted certificate .p12 file"
	exit 1
fi

if [ ! -z ${3} ]; then
	SRC_NAME=${3}
else
	err "Argument 3 must be the name of an existing, readable file: the trusted certificate file name without the .p12 extention"
	exit 1
fi

if [ ! -z ${4} ]; then
	SRC_ALIAS=${4}
else
	err "Argument 4 must be the trusted certificate's alias"
	exit 1
fi

if [ ! -z ${5} ]; then
	SRC_PASS=${5}
else
	err "Argument 5 must be the trusted certificate's password"
	exit 1
fi


if [ ! -z ${6} ]; then
	DST_NAME=${6}
else
	err "Argument 6 must be the name for the new turststore" 
	exit 1
fi

if [ ! -z ${7} ]; then
	DST_PASS=${7}
else
	err "Argument 7 must be the password for the new turststore" 
	exit 1
fi

if [ ! -z ${8} ]; then
	OTHER_TRUST_PATH=${8}
fi

if [ ! -z ${9} ]; then
	OTHER_TRUST_NAME=${9}
fi

if [ ! -z ${10} ]; then
	OTHER_TRUST_ALIAS=${10}
fi

SRC_FILE="${SRC_PATH}/${SRC_NAME}.p12"
DST_FILE="${DST_PATH}/${DST_NAME}.p12"
OTHER_TRUST_FILE="${OTHER_TRUST_PATH}/${OTHER_TRUST_NAME}.crt"

if [ ! -f "${DST_FILE}" ]; then
  keytool -export \
    -alias ${SRC_ALIAS} \
    -storepass ${SRC_PASS} \
    -keystore ${SRC_FILE} \
    | keytool -import \
    -trustcacerts \
    -alias ${SRC_ALIAS} \
    -keystore ${DST_FILE} \
    -keypass ${DST_PASS} \
    -storepass ${DST_PASS} \
    -storetype PKCS12 \
    -noprompt

  if [ -f ${OTHER_TRUST_FILE} ] && \
     [ ! -z ${OTHER_TRUST_ALIAS} ] ; then

     keytool -import \
       -trustcacerts \
       -file ${OTHER_TRUST_FILE} \
       -alias ${OTHER_TRUST_ALIAS} \
       -keystore ${DST_FILE} \
       -keypass ${DST_PASS} \
       -storepass ${DST_PASS} \
       -storetype PKCS12 \
       -noprompt
  fi

fi
