#!bin/sh

Echo init script started...
mkdir /home/ah/core
mkdir /var/log/arrowhead
mkdir /var/log/arrowhead/serviceregistry
mkdir /var/log/arrowhead/authorization
mkdir /var/log/arrowhead/orchestrator

sed -i 's$#http://dl-cdn.alpinelinux.org/alpine/edge/community$http://dl-cdn.alpinelinux.org/alpine/edge/community$' /etc/apk/repositories
cat  /etc/apk/repositories
apk update && upgrade

apk add vim git curl jq openjdk11 maven mariadb mariadb-common mariadb-client

rc -s mariadb stop
/etc/init.d/mariadb setup
sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/#bind-address/bind-address/' /etc/my.cnf.d/mariadb-server.cnf
echo "port=3306" >> /etc/my.cnf.d/mariadb-server.cnf
openrc -s mariadb start
mysql -u root < setdbrootpass.sql

mysql_secure_installation

#git config --global user.email xxx@xxxxxxx.com
#git config --global user.name xxxxxx

cd /tmp
git clone http://github.com/eclipse-arrowhead/core-java-spring

cd /tmp/core-java-spring/scripts
echo "Type your database root password, when propted."
mysql -u root -p < create_empty_arrowhead_db.sql

rm /tmp/core-java-spring/pom.xml
cp /home/ah/init/pom.xml /tmp/core-java-spring/pom.xml
cd /tmp/core-java-spring

mvn clean install -DskipTests

mkdir /home/ah/core/serviceregistry
mkdir /home/ah/core/authorization
mkdir /home/ah/core/orchestrator

ls /home/ah/core/serviceregistry
ls /home/ah/core/authorization
ls /home/ah/core/orchestrator

cp /tmp/core-java-spring/serviceregistry/target/arrowhead-serviceregistry-4.3.0.jar /home/ah/core/serviceregistry/arrowhead-serviceregistry-4.3.0.jar
cp /tmp/core-java-spring/authorization/target/arrowhead-authorization-4.3.0.jar /home/ah/core/authorization/arrowhead-authorization-4.3.0.jar
cp /tmp/core-java-spring/orchestrator/target/arrowhead-orchestrator-4.3.0.jar /home/ah/core/orchestrator/arrowhead-orchestrator-4.3.0.jar

cp /tmp/core-java-spring/serviceregistry/target/log4j2.xml /home/ah/core/serviceregistry//log4j2.xml
cp /tmp/core-java-spring/authorization/target/log4j2.xml /home/ah/core/authorization/log4j2.xml
cp /tmp/core-java-spring/orchestrator/target/log4j2.xml /home/ah/core/orchestrator/log4j2.xml

sed -i 's*<Property name="LOG_DIR">.</Property>*<Property name="LOG_DIR">/var/log/arrowhead/serviceregistry</Property>*' /home/ah/core/serviceregistry/log4j2.xml		
sed -i 's*<Property name="LOG_DIR">.</Property>*<Property name="LOG_DIR">/var/log/arrowhead/authorization</Property>*' /home/ah/core/authorization/log4j2.xml		
sed -i 's*<Property name="LOG_DIR">.</Property>*<Property name="LOG_DIR">/var/log/arrowhead/orchestrator</Property>*' /home/ah/core/orchestrator/log4j2.xml		

cp /tmp/core-java-spring/serviceregistry/target/application.properties /home/ah/core/serviceregistry/application.properties
cp /tmp/core-java-spring/authorization/target/application.properties /home/ah/core/authorization/application.properties
cp /tmp/core-java-spring/orchestrator/target/application.properties /home/ah/core/orchestrator/application.properties

ls /home/ah/core/serviceregistry
ls /home/ah/core/authorization
ls /home/ah/core/orchestrator

cp /home/ah/init/ah_* /etc/init.d/

rc-update add ah_sr_service
rc-update add ah_auth_service
rc-update add ah_orch_service


