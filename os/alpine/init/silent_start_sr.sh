#!/bin/sh


nohup java -Xms64M -Xmx128M -Dlog4j.configurationFile=log4j2.xml -jar ah.jar 1>/dev/null & 2>/dev/null &
