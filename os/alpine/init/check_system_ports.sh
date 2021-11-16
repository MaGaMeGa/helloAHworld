#!/bin/sh -x

## echo starting check system ports...

DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)

for i in $DIR
	do 
		cd  /etc/arrowhead/clouds/tc1/conf.d/cores/$i

		COUNT=$( grep -ch port=1 application.properties)

		if [ $COUNT -ne "0" ]; then
			exit 1
		fi

	done
exit 0
