### Web Console -- Cockpit web server
- Cockpit web server is running on fedora server 
- available under https://hostname:9090
- configuration and administration
- server certificates (.cert oder .crt) will be searched under /etc/cockpit/ws-certs.d in alphabetical order
- check currently used certificate 
````
sudo /usr/libexec/cockpit-certificate-ensure --check
````


#### Links
Cockpit Documentation
https://cockpit-project.org/documentation.html

Cockpit User guide https://cockpit-project.org/guide/latest/

SSL/TLS configuration https://cockpit-project.org/guide/latest/https