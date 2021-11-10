#!/bin/sh

echo "started create system dirs ..."

awk '{ system("mkdir /home/ahdev/coresystems/" $1 )}' /home/ahdev/conf.d/systems.txt

