#!/bin/sh

if [ $( service docker status | awk '{ print $1 }' ) -ne "started" ]; then
	service docker start
else
	docker ps -aq | awk '{ print "docker stop " $1 }' | sh
	service docker stop
	sleep 5s
	service docker start
fi

docker run --name db1 -d ah_base_db
docker run --name db2 -d ah_base_db


DB1IP=$( docker inspect db1 | grep IPAddress | cut -d '"' -f 4 | tail -1 )
DB2IP=$( docker inspect db2 | grep IPAddress | cut -d '"' -f 4 | tail -1 )

##TODO cd to scripts dir && connect db and run create_emptydb ...
##TODO edit and run update_cloud_db util scripts
