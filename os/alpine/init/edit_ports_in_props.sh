#!/bin/sh

FILE_NAME="application.properties"

CONF_BASE_DIR="/etc/arrowhead/clouds"
CLOUDS=$(cat clouds.conf)
SYSTEMS=$(cat systems.txt)

COUNT=0
for cloud in ${CLOUDS}
do
	for system in ${SYSTEMS}
	do
		if [ $COUNT -gt 0 ];then
			FILE="${CONF_BASE_DIR}/${cloud}/conf.d/cores/${system}/${FILE_NAME}"
			sed -i "s/port=/port=${COUNT}/g" ${FILE}
		fi
	done
	COUNT=`expr $COUNT + 1`

	if [ $COUNT -gt 5 ];then
		echo "If you want to run more then 5 clouds, ajust to port setting by zour own means."
		echo "Port settings editing is aborted."
		exit 2
	fi
done
