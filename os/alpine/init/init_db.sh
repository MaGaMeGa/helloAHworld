#!/bin/sh

if [ $( service docker status | awk '{ print $NF }' ) -ne "started" ]; then
	service docker start
	sleep 5s
else
	docker ps -aq | awk '{ print "docker stop " $1 }' | sh
	service docker stop
	sleep 5s
	service docker start
	sleep 5s
fi

docker images | awk 'NR!=1 && $1!~/ah_base_db/ {print "docker rmi " $1 " && sleep 5s" }' | sh 
#sleep 10s
docker ps -aq | awk '{ print "docker rm " $1 "  && sleep 5s" }' | sh
#sleep 10s

docker run --name db1 -d ah_base_db
sleep 10s
docker run --name db2 -d ah_base_db
sleep 10s

DB1IP=$( docker inspect db1 | grep IPAddress | cut -d '"' -f 4 | tail -1 )
DB2IP=$( docker inspect db2 | grep IPAddress | cut -d '"' -f 4 | tail -1 )

cd /home/sysop/utils/ah_scripts
mysql -h $DB1IP -u root -p < create_empty_arrowhead_db.sql
mysql -h $DB2IP -u root -p < create_empty_arrowhead_db.sql

cd /home/sysop/utils/

IPV4_PATTERN=$( cat /home/sysop/utils/ipv4.match )
#(b25[0-5]|b2[0-4][0-9]|b[01]?[0-9][0-9]?)(.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}

find /etc/arrowhead/clouds/tc1/conf.d/cores -name "application.properties" \
-exec sed -i -r "s%mysql://$IPV4_PATTERN%mysql://$DB1IP%" {} +

find /etc/arrowhead/clouds/tc2/conf.d/cores -name "application.properties" \
-exec sed -i -r "s%mysql://$IPV4_PATTERN%mysql://$DB2IP%" {} +	
