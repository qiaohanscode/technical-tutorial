#### Step 1 Create X509 CSR
```
openssl req -newkey rsa:2048 -keyout ekl-jenkins-ponyworld-io-privkey.pem \
-config ekl-jenkins-ponyworld-io-req.conf \
-out ekl-jenkins-ponyworld-io.csr
```

#### Step 2 Sign X509 CSR With CA Ponyworld-Infra-CA
```
openssl x509 -req -in ekl-jenkins-ponyworld-io.csr \
-CA ../../ponyworld-infra-ca/ponyworld-infra-ca.crt \
-CAkey ../../ponyworld-infra-ca/ponyworld-infra-ca-privkey.pem \
-days 730 -CAserial ../../ponyworld-infra-ca/ponyworld-infra-ca.srl \
-extfile ekl-jenkins-ponyworld-io-x509.ext \
-out ekl-jenkins-ponyworld-io.crt
```

#### Step 3 Create Keystore With Type PKCS12
```
openssl pkcs12 -export -inkey ekl-jenkins-ponyworld-io-privkey.pem \
-in ekl-jenkins-ponyworld-io.crt \
-out ekl-jenkins-ponyworld-io.p12 
```

#### Step 4 Convert KeyStore Type To JKS
convert to keystore type JKS
```
keytool -importkeystore -srckeystore ekl-jenkins-ponyworld-io.p12 \
-srcstoretype PKCS12 -destkeystore ekl-jenkins-ponyworld-io.jks \
-deststoretype JKS                      
```

view certificates of keystore
```
keytool -list -v -keystore ekl-jenkins-ponyworld-io.jks 
```

#### Step 5 Transfer JKS Keystore to Jenkins Server
```
scp ekl-jenkins-ponyworld-io.jks tim@ekl-jenkins.ponyworld.io:/home/tim/
```

#### Step 6 Move JKS Keystore To /var/lib/jenkins
````
mv -v ekl-jenkins-ponyworld-io.jks /var/lib/jenkins/
````

#### Step 7 Grant Access To Keystore For Jenkins User
```
sudo chown jenkins:jenkins /var/lib/jenkins/ekl-jenkins-ponyworld-io.jks
```

#### Step 8 Edit Jenkins Configuration I
Add the following lines into /lib/systemd/system/jenkins.service
```
Environmenv="JENKINS_HTTPS_PORT=443"                                                
Environment="JENKINS_HTTPS_KEYSTORE=/var/lib/jenkins/ekl-jenkins-ponyworld-io.jks"  
Environment="JENKINS_HTTPS_KEYSTORE_PASSWORD=$PASSWORD"                           
AmbientCapabilities=CAP_NET_BIND_SERVICE                                          
Environment="JENKINS_PORT=-1"                                                     
Environment="JENKINS_HTTPS_LISTEN_ADDRESS=0.0.0.0" 
```
`Note: ` some of the above lines already exist in the configure file, by this case, just uncomment the lines.

#### Step 9 Edit Jenkins Configuration II
add the following line into /etc/systemd/system/jenkins.service.d/override.conf
```
Environmenv="JENKINS_HTTPS_PORT=443"                                                
Environment="JENKINS_HTTPS_KEYSTORE=/var/lib/jenkins/ekl-jenkins-ponyworld-io.jks"  
Environment="JENKINS_HTTPS_KEYSTORE_PASSWORD=$PASSWORD"                           
AmbientCapabilities=CAP_NET_BIND_SERVICE                                          
Environment="JENKINS_PORT=-1"                                                     
Environment="JENKINS_HTTPS_LISTEN_ADDRESS=0.0.0.0"
```

#### Step 10 Restart Jenkins
```
sudo systemctl restart jenkins
sudo systemctl daemon-reload
sudo systemctl status jenkins -l
```