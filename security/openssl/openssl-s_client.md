### openssl s_client 
implements a SSL/TLS client to test the connectivity of a SSL/TLS Server and shows 
Details about the server certificate

#### check the SSL/TLS connectivity with TLSv1.3
```
openssl s_client -connect ekl-jenkins.ponyworld.io -tls1_3
```