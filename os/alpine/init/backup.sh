#!/bin/sh

NOW=$(date +%s)
BASE_DIR=/home/sysop/bk/cloud_config/x${NOW}
mkdir -p ${BASE_DIR}

CLOUDS=$(ls /etc/arrowhead/clouds )
find /etc/arrowhead/ -name "*.properties" | awk '{print "cp " $0 " " $0 ".bk" }' | sh

for i in ${CLOUDS}
do
	find /etc/arrowhead/clouds/${i} -name "*.bk" | awk -F'/' '{print "mkdir -p '${BASE_DIR}/${i}'/"$6"/"$7"/"$8 " && mv "$0" '${BASE_DIR}/${i}'/"$6"/"$7"/"$8"/"$9}' | sh
done

