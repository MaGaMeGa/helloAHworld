#!/bin/sh -x

echo starting update system trust stores...

DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)

for i in $DIR
	do 
		cd  /etc/arrowhead/clouds/tc1/conf.d/cores/$i
		sed -i "s%trust-store=classpath:certificates%trust-store=file:/usr/share/arrowhead/certs/testcloud1%" application.properties
	done
