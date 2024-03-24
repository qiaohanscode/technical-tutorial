## Configurations and Zone Files

### Introduction
BIND 9 uses a single configuration file called `named.conf` which is located in /etc/bind in Ubuntu 22.04. Depending on the functionality of the system, one or more zone files is required. 

### `named.conf` Base File
The  `named.conf` provides a basic logging service and may be extended as required.

### Zone file
Zone files consist of [Resource Records](3.2-resource-records), which describe the zone's characteristics or properties.

### localhost Zone File
All end-user systems are shipped with a `host` file (usually located in /etc). This file is normally configured to map the name __localhost__ to the loopback address. It is argued, reasonably, that a forward-mapped zone file for __localhost__ is therefore not strictly required. 

```
$TTL 3h
localhost.  SOA      localhost.  nobody.localhost. 42  1d  12h  1w  3h
            NS       localhost.
            A        127.0.0.1
            AAAA     ::1
```

### localhost Reverse-Mapped Zone File
This zone file allows any query requesting the name associated with hte loopback IP (127.0.0.1). This file is required to prevent unnecessary queries from reaching the public DNS hierarchy.
```
$TTL 1D
@        IN        SOA  localhost. root.localhost. (
                        2007091701 ; serial
                        30800      ; refresh
                        7200       ; retry
                        604800     ; expire
                        300 )      ; minimum
         IN        NS    localhost.
1        IN        PTR   localhost.
```

### Authoritative Name Servers
These provide authoritative answers to user queries for the zones they support: for instance, the zone data describing the domain name example.com. An authoritative name server may support one or many zones.

Each zone may be defined as either a __primary zone__ or a __secondary zone__. A __primary zone__ reads its zone data directly from a file system. A __secondary zone__ obtains its zone data from the primary zone using a process called __zone transfer__. Both the primary and the secondary zones provide authoritative data for their zone; there is no difference in the answer to a query from a primary or a secondary zone. An auhoritative name server may support any combinaion of primary and secondary zones. 

`Note:` The terms __primary__ and __secondary__ do not imply any access priority. For reasons of backward compatibility BIND 9 treats "primary" and "master" as synonyms, a well as "secondary" and "slave".

### Primary Authoritative Name Server
A `primary auhoritative name server` declares its zone as ___primary___.

```
// We are the primary server for example.com
zone "example.com" {
  // this is the primary name server for the zone
  type primary;
  file "example.com";
  // this is the default
  notify yes;
  // IP addresses of secondary servers allowed to
  // transfer example.com from this server
  allow-transfer {
    192.168.4.14;
    192.168.5.53;
  };
};
```
The complete configuration can be found [Bind 9 Configuration Primary Authoritiative name Server](https://bind9.readthedocs.io/en/latest/chapter3.html#primary-authoritative-name-server).

### Secondary Authoritative Name Server
A `secondary authoritative name server` obtains the zone file from the primary via zone transfer and does not define a zone file in this file system. Instead, a `secondary authoritiative name server` may cache the retrieved zone file for the case that the server needs to be restarted.
```
// We are the secondary server for example.com
zone "example.com" {
  // this is a secondary server for the zone
  type secondary;
  // the file statement here allows the secondary to save
  // each zone transfer so that in the event of a program restart
  // the zone can be loaded immediately and the server can start
  // to respond to queries without waiting for a zone transfer
  file "example.com.saved";
  // IP address of example.com primary server
  primaries { 192.168.254.2; };
};
```
The complete configuration can be found [Bind 9 Configuration Secondary Authoritative Name Server](https://bind9.readthedocs.io/en/latest/chapter3.html#secondary-authoritative-name-server)
### Resolver
Resolvers handle [recursive user queries](https://bind9.readthedocs.io/en/latest/chapter1.html#recursive-query) and provide complete answers; that is, they issue one or more iterative queries to the DNS hierarchy. 

```
// resolver named.conf file
// Two corporate subnets we wish to allow queries from
// defined in an acl clause
acl corpnets {
  192.168.4.0/24;
  192.168.7.0/24;
};

// options clause defining the server-wide properties
options {
  // all relative paths use this directory as a base
  directory "/var";
  // version statement for security to avoid hacking known weaknesses
  // if the real version number is revealed
  version "not currently available";
  // this is the default
  recursion yes;
  // recursive queries only allowed from these ips
  // and references the acl clause
  allow-query { corpnets; };
  // this ensures that any reverse map for private IPs
  // not defined in a zone file will *not* be passed to the public network
  // it is the default value
  empty-zones-enable yes;
};

// zone file for the root servers
// discretionary zone (see root server discussion above)
zone "." {
  type hint;
  file "named.root";
};

// zone file for the localhost forward map
// discretionary zone depending on hosts file (see discussion)
zone "localhost" {
  type primary;
  file "masters/localhost-forward.db";
  notify no;
};

// zone file for the loopback address
// necessary zone
zone "0.0.127.in-addr.arpa" {
  type primary;
  file "localhost.rev";
  notify no;
};

// zone file for local IP reverse map
// discretionary file depending on requirements
zone "254.168.192.in-addr.arpa" {
  type primary;
  file "192.168.254.rev";
  notify no;
};
```

## Loading Balancing
A primitive form of loading balancing can be achieved in the DNS by using multiple resource records in a zone file (such as multiple A records) for one name

name|TTL|CLASS|TYPE|Resource Record Data
---|---|---|---|---
www|600|IN|A|10.0.0.1
www|600|IN|A|10.0.0.2
www|600|IN|A|10.0.0.3

When a resolver queries for these records, BIND rotates them and reponds to the query with the records in a random order, because all the records have the same value of TTL.




