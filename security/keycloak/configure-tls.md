### Configure TLS On keycloak
#### Step 1 Transfer x509 certificate and private key to server

#### Step 2 Set environment variable
```
export KC_HOME=/path/to/keycloak
```

#### Step 3 Modify configuration file keycloak.conf
```
hostname=oauth-dev.ponyworld.io

https-certificate-file=${KC_HOME}/conf/server.crt.pem

https-certificate-key-file=${KC_HOME}/conf/server.key.pem
```

#### Step 4 Start keycloak as daemon
```
bin/kc.sh start &
```