#### generates a private key with pass phrase
```
openssl genrsa -des3 -out rootCA.key 2048
```
#### generates a public key for the given private key. This step is not necessary for generating certificate.
```
openssl pkey -in rootCA.key -pubout -out pubkeyRootCA.key
```
- pkey -- processes public or private keys
- -in rootCA.key -- read the key from rootCA.key
- -pubout -- outout a public key (by default, a private key is output)

#### view the keys in plain text
```
openssl pkey -in rootCA.key -text -noout
```
```
openssl req -x509 -new -nodes -key rootCA.key -days 1024 -sha256 -out ponyworld_rootCA.crt 
```
