#!/bin/sh -x

echo starting update cloud db timezone...

DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)

for i in $DIR
	do 
		cd  /etc/arrowhead/clouds/tc1/conf.d/cores/$i
		sed -i "s%serverTimezone=Europe/Budapest%serverTimezone=UTC%" application.properties
	done
