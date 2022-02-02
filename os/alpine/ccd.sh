#!/bin/sh

ROOT_NAME="master"
ROOT_ALIAS="arrowhead.eu"
OPERATOR="aitia"
CLOUD1_NAME="testcloud1"
CLOUD1_ALIAS="${CLOUD1_NAME}.${OPERATOR}"
CLOUD2_NAME="testcloud2"
CLOUD2_ALIAS="${CLOUD2_NAME}.${OPERATOR}"
RELAY_ROOT_NAME="relay-master"
RELAY_ROOT_ALIAS="${RELAY_ROOT_NAME}"
RELAY_NAME="relay1"
RELAY_ALIAS="${RELAY_NAME}"
RELAY_IP="192.168.56.1"
RELAY_TRUSTSTORE_NAME="${RELAY_NAME}.truststore"

CLOUD1_TRUSTSTORE_NAME="${CLOUD1_NAME}.truststore"
CLOUD1_GATE_TRUSTSTORE_NAME="${CLOUD1_NAME}.gate.truststore"

CLOUD2_TRUSTSTORE_NAME="${CLOUD2_NAME}.truststore"
CLOUD2_GATE_TRUSTSTORE_NAME="${CLOUD2_NAME}.gate.truststore"

UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 )
BASEDIR="/tmp/newclouds_${UUID}/"

CLOUD1_KS="${BASEDIR}${CLOUD1_NAME}.p12"
CLOUD2_KS="${BASEDIR}${CLOUD2_NAME}.p12"

ROOT_PASS="123456"
CLOUD1_PASS="123456"
CLOUD2_PASS="123456"
RELAY_ROOT_PASS="123456"
RELAY_PASS="123456"
RELAY_TRUST_PASS="123456"
CLOUD1_TRUST_PASS="123456"
CLOUD1_GATE_TRUST_PASS="123456"
CLOUD2_TRUST_PASS="123456"
CLOUD2_GATE_TRUST_PASS="123456"

SYS_CONFIG="systems.txt"

echo "${UUID}" >> /tmp/tempclouds

if [ ! -d ${BASEDIR} ]; then
	mkdir ${BASEDIR}
fi

echo "${ROOT_PASS}" >> "${BASEDIR}masterpass.sec" ## TODO: store in gpg instead
echo "${CLOUD1_PASS}" >> "${BASEDIR}${CLOUD1_NAME}.sec"
echo "${CLOUD2_PASS}" >> "${BASEDIR}${CLOUD2_NAME}.sec"
echo "${RELAY_ROOT_PASS}" >> "${BASEDIR}RELAY_ROOT_PASS.sec"
echo "${RELAY_PASS}" >> "${BASEDIR}RELAY_PASS.sec"
echo "${RELAY_TRUST_PASS}" >> "${BASEDIR}RELAY_TRUST_PASS.sec"
echo "${CLOUD1_TRUST_PASS}" >> "${BASEDIR}CLOUD1_TRUST_PASS.sec"
echo "${CLOUD1_GATE_TRUST_PASS}" >> "${BASEDIR}CLOUD1_GATE_TRUST_PASS.sec"
echo "${CLOUD2_TRUST_PASS}" >> "${BASEDIR}CLOUD2_TRUST_PASS.sec"
echo "${CLOUD2_GATE_TRUST_PASS}" >> "${BASEDIR}CLOUD2_GATE_TRUST_PASS.sec"

sh makemastercert.sh "${BASEDIR}${ROOT_NAME}.p12" ${ROOT_ALIAS} ${ROOT_PASS}
sh makecloudcert.sh "${BASEDIR}${ROOT_NAME}.p12" ${ROOT_ALIAS} ${ROOT_PASS} "${CLOUD1_KS}" "${CLOUD1_ALIAS}" ${CLOUD1_PASS}
sh makecloudcert.sh "${BASEDIR}${ROOT_NAME}.p12" ${ROOT_ALIAS} ${ROOT_PASS} "${CLOUD2_KS}" "${CLOUD2_ALIAS}" ${CLOUD2_PASS}

sh makerelaymastercert.sh \
	"${BASEDIR}${ROOT_NAME}.p12" \
	"${ROOT_ALIAS}"  \
	"${ROOT_PASS}" \
	"${BASEDIR}${RELAY_ROOT_NAME}.p12" \
	"${RELAY_ROOT_ALIAS}" \
	"${RELAY_ROOT_PASS}"

sh makerelaycert.sh \
	"${BASEDIR}${ROOT_NAME}.crt" \
	"${ROOT_ALIAS}"  \
	"${BASEDIR}${RELAY_ROOT_NAME}.p12" \
	"${RELAY_ROOT_ALIAS}" \
	"${RELAY_ROOT_PASS}" \
	"${BASEDIR}" \
	"${RELAY_NAME}" \
	"${RELAY_PASS}" \
	"${RELAY_IP}"


echo "starting truststore generation: ${RELAY_TRUSTSTORE_NAME}"
sh makecloudtruststore.sh \
	"${BASEDIR}" \
	"${BASEDIR}" \
	"${ROOT_NAME}" \
	"${ROOT_ALIAS}" \
	"${ROOT_PASS}" \
	"${RELAY_TRUSTSTORE_NAME}" \
	"${RELAY_TRUST_PASS}"

echo "starting truststore generation: ${CLOUD1_TRUSTSTORE_NAME}"
sh makecloudtruststore.sh \
	"${BASEDIR}" \
	"${BASEDIR}" \
	"${CLOUD1_NAME}" \
	"${CLOUD1_ALIAS}" \
	"${CLOUD1_PASS}" \
	"${CLOUD1_TRUSTSTORE_NAME}" \
	"${CLOUD1_TRUST_PASS}"


echo "starting truststore generation: ${CLOUD1_GATE_TRUSTSTORE_NAME}"
sh makecloudtruststore.sh \
	"${BASEDIR}" \
	"${BASEDIR}" \
	"${CLOUD1_NAME}" \
	"${CLOUD1_ALIAS}" \
	"${CLOUD1_PASS}" \
	"${CLOUD1_GATE_TRUSTSTORE_NAME}" \
	"${CLOUD1_GATE_TRUST_PASS}" \
	"${BASEDIR}" \
	"${RELAY_ROOT_NAME}" \
	"${RELAY_ROOT_ALIAS}" 


sh makecloudtruststore.sh \
	"${BASEDIR}" \
	"${BASEDIR}" \
	"${CLOUD2_NAME}" \
	"${CLOUD2_ALIAS}" \
	"${CLOUD2_PASS}" \
	"${CLOUD2_TRUSTSTORE_NAME}" \
	"${CLOUD2_TRUST_PASS}"

sh makecloudtruststore.sh \
	"${BASEDIR}" \
	"${BASEDIR}" \
	"${CLOUD2_NAME}" \
	"${CLOUD2_ALIAS}" \
	"${CLOUD2_PASS}" \
	"${CLOUD2_GATE_TRUSTSTORE_NAME}" \
	"${CLOUD2_TRUST_PASS}" \
	"${BASEDIR}" \
	"${RELAY_ROOT_NAME}" \
	"${RELAY_ROOT_ALIAS}" 


echo "--- generating system certs ----"
while read line
do
	SYSNAME=$(echo "${line}" | awk '{print $1 }')
	SYSIP1=$(echo "${line}" | awk '{print $2 }')
	SYS_PASS="123456"
	
	echo "${SYS_PASS}" >> "${BASEDIR}${CLOUD1_ALIAS}.${SYSNAME}.sec" # TODO: store in gpg
	SYS_PARAMS=$(echo "${SYSNAME} ${SYS_PASS} ${SYSIP1}")

	if [ ! -d "${BASEDIR}c1" ];then
		mkdir "${BASEDIR}c1"
	fi
	
	echo "base dir: $(echo ${BASEDIR})"
	sh makesystemcert.sh "${BASEDIR}${ROOT_NAME}.crt" "${ROOT_ALIAS}" "${CLOUD1_KS}" "${CLOUD1_ALIAS}" "${CLOUD1_PASS}" "${BASEDIR}c1/" "${SYSNAME}" "${SYS_PASS}" "${SYSIP1}" 
done < "${SYS_CONFIG}"

while read line
do
	SYSNAME=$(echo "${line}" | awk '{print $1 }')
	SYSIP1=$(echo "${line}" | awk '{print $2 }')
	SYS_PASS="123456"
	
	echo "${SYS_PASS}" >> "${BASEDIR}${CLOUD2_ALIAS}.${SYSNAME}.sec" # TODO: store in gpg
	SYS_PARAMS=$(echo "${SYSNAME} ${SYS_PASS} ${SYSIP1}")

	if [ ! -d "${BASEDIR}c2" ];then
		mkdir "${BASEDIR}c2"
	fi

	echo "system paramters:${SYS_PARAMS}---"
	sh makesystemcert.sh "${BASEDIR}${ROOT_NAME}.crt" "${ROOT_ALIAS}" "${CLOUD2_KS}" "${CLOUD2_ALIAS}" "${CLOUD2_PASS}" "${BASEDIR}c2/" "${SYSNAME}" "${SYS_PASS}" "${SYSIP1}" 
done < "${SYS_CONFIG}"
