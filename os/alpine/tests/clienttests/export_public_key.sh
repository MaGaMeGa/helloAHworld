keytool -exportcert -alias alpine1c -keystore alpine1c.p12 -rfc | openssl x509 -out alpine1c.pub -noout -pubkey
