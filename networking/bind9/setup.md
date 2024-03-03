## Setup Bind 9 on Ubuntu 22.02

### Step 1 Install Bind 9 Package
```
sudo apt update
sudo apt install -y bind9 bind9utils bind9-doc dnsutils
```

### Step Setup Bind
All configuration files for BIND are located in folder `/etc/bind`

One of the important configuration file for bind is "/etc/bind/named.conf.options", from this file we can set the following parameters:
- Allow Query to your dns from your private network
- Allow recursive query
- Specify DNS port (53)
- Forwarders (DNS query will be forwarded to the forwarders when your local DNS server is unable to resolve query)

```
acl ponyworld-network {
192.168.178.0/24;
};
options {
        directory "/var/cache/bind";
        allow-query { localhost; ponyworld-network; };
        allow-transfer { localhost; };
        forwarders { 8.8.8.8; };
        recursion yes;

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable 
        // nameservers, you probably want to use them as forwarders.  
        // Uncomment the following block, and insert the addresses replacing 
        // the all-0's placeholder.

        // forwarders {
        //      0.0.0.0;
        // };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        dnssec-validation auto;

        listen-on-v6 { any; };
};
```

Next important configuration file is "/etc/bind/named.conf.local", in this file we will define the zone files for our domain
- forward lookup zone file
- reverse lookup zone file

```
zone "fritz.box" IN {
        type master;
        file "/etc/bind/forward.fritz.box";
        allow-update { none; }
};
zone "0.168.192.in-addr.arpa" IN {
        type master;
        file "/etc/bind/reverse.fritz.box";
        allow-update { none; };
};
```
Now create the forward lookup zone file. Sample zone files (db.local) are already in "/etc/bind",
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     primary.fritz.box. root.primary.fritz.box. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;Name Server Information
@       IN      NS      primary.fritz.box.

;IP address of Domain Name Server (DNS)
primary IN A 192.168.178.48

; A Record for Host names
ekl-k8s-master-1 IN A 192.168.178.44
ekl-k8s-worker-1 IN A 192.168.178.47
ekl-k8s-worker-2 IN A 192.168.178.46
```

Next create a reverse lookup zoe file, sample reverse lookup zone file is present "/etc/bind/db.127"
```
;
; BIND reverse data file for local loopback interface
;
$TTL    604800
@       IN      SOA     fritz.box. root.fritz.box. (
                              1         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;Your Name Server Info
@       IN      NS      primary.fritz.box.
primary IN A 192.168.178.48

;Reverse Lookup for Your DNS Server
42 IN PTR primary.fritz.box
;PTR Record IN address to HostName
44 IN PTR ekl-k8s-master-1.fritz.box
47 IN PTR ekl-k8s-worker-1.fritz.box
46 IN PTR ekl-k8s-worker-2.fritz.box
```

Update the following parameter in "/etc/default/named" file, so that dns service starts listening on IPv4
```
OPTIONS="-u bind -4"
```

Now start and enable the BIND service to implement the changes made,
```
sudo systemctl start named
sudo systemctl enable named
```

## Step 3 Validating syntax of bind configuration and Zone files
verify the syntax of your bind 9 configuration file (named.conf.local)
```
sudo named-checkconf /etc/bind/named.conf.local
```

verify the syntax your forward and reverse lookup zone files,
```
sudo named-checkzone fritz.box /etc/bind/forward.fritz.box

sudo named-checkzone fritz.box /etc/bind/reverse.fritz.box
```
