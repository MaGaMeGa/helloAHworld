#!/bin/sh -x

SRC=$1

TC1_DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)
TC2_DIR=$(ls /etc/arrowhead/clouds/tc2/conf.d/cores/)

for i in $TC1_DIR
 	do
		if [ -f  /etc/arrowhead/clouds/tc1/conf.d/cores/$i/$SRC ]
			then
				 echo $SRC allready present...
			else
				cp ./$SRC /etc/arrowhead/clouds/tc1/conf.d/cores/$i/$SRC
		fi
	done


for i in $TC2_DIR 
	do
		if [ -h  /etc/arrowhead/clouds/tc2/conf.d/cores/$i/ah.jar ]
			then
				 echo $SRC allready present...
				cp ./$SRC /etc/arrowhead/clouds/tc2/conf.d/cores/$i/$SRC
		fi
	done

