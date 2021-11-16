#!/bin/sh -x

echo starting update system ports...

DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)

for i in $DIR
	do 
		cd  /etc/arrowhead/clouds/tc1/conf.d/cores/$i
		if [  -z $( sh /home/sysop/utils/check_system_ports.sh ) ]; then
			sed  -i "s/port=/port=1/g" application.properties
		fi
	done
