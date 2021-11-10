#!/bin/sh

echo "started copy system properties ..."

awk ' { system("cp /tmp/master/" $1 "/target/application.properties /home/ahdev/coresystems/" $1 " " )}' /home/ahdev/conf.d/systems.txt

