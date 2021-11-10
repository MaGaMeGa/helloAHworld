#!/bin/sh

echo "started copy system jars ..."

awk ' { system("cp /tmp/master/" $1 "/target/arrowhead-" $1 "-4.4.0.jar /home/ahdev/coresystems/" $1 " " )}' /home/ahdev/conf.d/systems.txt

