#!/bin/sh

FILE_NAME="application.properties"

CONF_BASE_DIR="/etc/arrowhead/clouds"
CLOUDS=$(cat clouds.conf)
SYSTEMS=$(cat systems.txt)

for cloud in ${CLOUDS}
do
	for system in ${SYSTEMS}
	do
		FILE="${CONF_BASE_DIR}/${cloud}/conf.d/cores/${system}/${FILE_NAME}"
		sed -i "s/arrowhead/${cloud}-arrowhead/g" ${FILE}
	done
done
