#!/bin/sh -x

SRC=silent_start.sh

#TC1_DIR=$(ls /etc/arrowhead/clouds/tc1/conf.d/cores/)
TC1_DIR=$(cat /home/sysop/utils/systems.txt)
#TC2_DIR=$(ls /etc/arrowhead/clouds/tc2/conf.d/cores/)
TC2_DIR=$(cat /home/sysop/utils/systems.txt)

for i in $TC1_DIR
 	do
		if [ -f  /etc/arrowhead/clouds/tc1/conf.d/cores/$i/$SRC ]
			then
				cd /etc/arrowhead/clouds/tc1/conf.d/cores/$i
				nohup sh $SRC 1>/dev/null 2>/dev/null &
				echo starting tc1 - $i ...
				sleep 10s
		fi
	done


for i in $TC2_DIR 
	do
		if [ -f  /etc/arrowhead/clouds/tc2/conf.d/cores/$i/$SRC ]
			then
				cd /etc/arrowhead/clouds/tc2/conf.d/cores/$i
				nohup sh $SRC 1>/dev/null 2>/dev/null &
				echo starting tc2 - $i ...
				sleep 10s
		fi
	done

