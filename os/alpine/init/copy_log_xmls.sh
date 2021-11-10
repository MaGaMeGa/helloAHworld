#!/bin/sh

echo "started copy log xmls" 

awk ' { system("cp /tmp/master/" $1 "/target/log4j2.xml /home/ahdev/coresystems/" $1 " " )}' /home/ahdev/conf.d/systems.txt

