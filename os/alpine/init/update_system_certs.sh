#!/bin/sh -x

echo starting update system certs...

DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)

for i in $DIR
	do 
		cd  /etc/arrowhead/clouds/tc1/conf.d/cores/$i
		sed -i "s%key-store=classpath:certificates%key-store=file:/usr/share/arrowhead/certs/testcloud1%" application.properties
	done
