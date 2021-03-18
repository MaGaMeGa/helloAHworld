#!/bin/sh


curl -v -s --insecure --cert-type P12 --cert /home/ah/tests/sysop.p12:123456 -X GET -H "Content-Type: application/json"  https://127.0.0.1:9998 > x.res
