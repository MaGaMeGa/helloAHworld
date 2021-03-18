#!/bin/sh


#cp /home/ah/init/core-java-spring/serviceregistry/target/arrowhead-serviceregistry-4.3.0.jar /home/ah/core/serviceregistry/arrowhead-serviceregistry-4.3.0.jar
#cp /home/ah/init/core-java-spring/authorization/target/arrowhead-authorization-4.3.0.jar /home/ah/core/authorization/arrowhead-authorization-4.3.0.jar
#cp /home/ah/init/core-java-spring/orchestrator/target/arrowhead-orchestrator-4.3.0.jar /home/ah/core/orchestrator/arrowhead-orchestrator-4.3.0.jar
#cp /home/ah/init/ah_* /etc/init.d/

#ls /etc/init.d/

mkdir /var/log/arrowhead
mkdir /var/log/arrowhead/serviceregistry
mkdir /var/log/arrowhead/authorization
mkdir /var/log/arrowhead/orchestrator
cp /home/ah/init/core-java-spring/serviceregistry/target/log4j2.xml /home/ah/core/serviceregistry/log4j2.xml
cp /home/ah/init/core-java-spring/authorization/target/log4j2.xml /home/ah/core/authorization/log4j2.xml
cp /home/ah/init/core-java-spring/orchestrator/target/log4j2.xml /home/ah/core/orchestrator/log4j2.xml
