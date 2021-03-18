!#/bin/sh

#curl -v -s --insecure --cert-type P12 --cert /home/ah/tests/sysop.p12:123456 -X POST -H "Content-Type: application/json" -d @create_system.request https://127.0.0.1:9998/time

#curl -v -s --insecure --cert-type P12 --cert /home/ah/tests/sysop.p12:123456 -X GET -H "Content-Type: application/json" https://127.0.0.1:9998/time

curl -v -s --insecure --cert-type P12 --cert /home/ah/tests/sysop.p12:123456 -X GET -H "Content-Type: application/json" https://127.0.0.1:9998/helloword

#curl -v http://127.0.0.1:9998/helloword
