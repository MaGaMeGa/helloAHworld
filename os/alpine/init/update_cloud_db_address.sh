#!/bin/sh -x

echo starting update cloud db address...

DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)
ADDRESS="$1"

for i in $DIR
	do 
		cd  /etc/arrowhead/clouds/tc1/conf.d/cores/$i
		sed -i "s%mysql://127.0.0.1%mysql://$ADDRESS%" application.properties
	done
