## Introduction to DNS and BIND 9
The Internet `Domain Name System (DNS)` consists of:
1. the syntax to specify the names of entities in the Internet in a hierarchical manner
2. the rules used for delegating authority over names and
3. the system implementation that actually maps names to Internet addresses.

`DNS` data is maintained in a group of distributed hierarchical databases.

The `Berkeley Internet Name Domain (BIND)` software implements a domain name server.

### DNS Fundamentals
The DNS naming system is organized as a tree structure comprised of multiple levels and creates a distributed system.

Each node in the tree is given a label which defines its `Domain of Authority`

- `Root Domain` is the topmost node in the tree ; it delegates to `Domains`at the next level which are generically known as
- `Top-Level Domains (TLDS).` They in turn delegate to 
- `Second-Level Domains (SLDs)`, and so on. 

The `top-Level Domains (TLDs)` include a special group of `TLDs` called the `Country Code top-Level Domains (ccTLDs)`, in which every country is assigned a unique two-character country code from ISO 3166 as its domain.

`Root Domain`has a unique label of `"."`(dot), which is normally omitted when it is written as a domain name, but by `Fully Qualified Domain Name (FQDN)` the dot must be present.
```
example.com    # domain name
example.com.   # FQDN
```

A domain is the label of a node in the tree. A `domain name` uniquely identifies any node in the DNS tree and is written left to right by combining all the domain labels with a dot separating each component up to the root domain.
```
example.com
b.com
ac.uk
us
org
```

### Authority and Delegation
Each domain (node) has delegated authority from its parent domain. The delegated authority includes specific responsibilities to
- ensure every domain it delegates has a unique name or label within its zone or domain of authority 
- maintain an `authoritative` list of its delegated domain
- include an operational requirement to operate two (or more) name servers which will contain the authoritative data for all the domain labels within its zone of authority in a `zone file`.

The tree structure ensures that the `DNS` name space is naturally distributed. The following diagram illustrates that `Authoritative Name Servers` exist for every level and every domain in the DNS name space:
```

Root 
DNS                                           root (.)                                               Authority
                               ____________________________________                                  Delegation
                         _____|______                       _______|________                                              
                         |    |    |                        |                                            
TLD                    .com .org  ()
DNS


User 
DNS                                             
                                             
                                             
                                                                                                     
```