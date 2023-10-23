#### generates a private key with pass phase
```
openssl genrsa -des3 -out rootCA.key 2048
```
- -des3 -- encrypt the generated key with DES in EDE CBC mode
#### generates a public key for the given private key. This step is not necessary for generating certificate.
```
openssl pkey -in rootCA.key -pubout -out pubkeyRootCA.key
```
- pkey -- processes public or private keys
- -in rootCA.key -- read the key from rootCA.key
- -pubout -- outout a public key (by default, a private key is output)

#### view the private and public key in plain text
```
openssl pkey -in rootCA.key -text -noout
openssl pkey -pubin -in pubkey.pem -text -noout
```
#### generate a self-signed certificate for the root CA
```
openssl req -x509 -new -key rootCA.key -days 1024 -out ponyworld-rootCA.crt 
```
- -x509 -- output a X.509 structure instead of a certificate request
-  -new -- new request
- -key -- private key file
- -days -- number of days generated certificate is valid
- -out -- output file (default stdout)
#### generate a private key and a self-signed CA certificate in one command
```
openssl req -x509 -days 1825 -newkey rsa:2048 -keyout ponyworld-root-ca-privkey.pem -config ponyworld-root-ca.conf -out ponyworld-root-ca.crt
```
#### view the generated CA certificate
```
openssl x509 -in ponyword-rootCA.crt -text -noout
```
#### generate a certificate signing request (csr)
```
openssl req -new -key privkey-pw-infra-CA.pem -out ponyworld-infrastructure-CA.csr
```
- req -- create and process signing request
- -new -- generate a new signing request, will prompt for more information
- -key -- signs the request with private key of ponyworld infrastructure CA
#### generate a private key and a certificate signing request in one command
```
openssl req -newkey rsa:2048 -keyout ponyworld-infra-ca-privkey.pem -config ponyworld-infra-ca-req.conf -out ponyworld-infra-ca.csr
```
#### view the generated signing request
```
openssl req -in domain.csr -text -noout
```
#### sign our CSR with the root CA certificate and its private key
- create a configuration text-file(infra-ca.ext) with following content
```
authorityKeyIdentifier=keyid,issuer
basicConstraints=critical,CA:TRUE,pathlen:0
keyUsage=critical,digitalSignature, keyCertSign, cRLSign
```
-  now sign our CSR 
```
openssl x509 -req -in ponyworld-infra-ca.csr -CA ponyworld-root-ca.crt -CAkey ponyworld-root-ca-privkey.pem -days 1825 -CAcreateserial -extfile ../ponyworld-infra-ca/ponyworld-infra-ca-x509.ext -out ponyworld-infra-ca.crt
```
#### convert rsa private key from .pem file to .key file
```
openssl rsa -in ekl-fritz-box-privkey.pem -out ekl-fritz-box-privkey.key
```
