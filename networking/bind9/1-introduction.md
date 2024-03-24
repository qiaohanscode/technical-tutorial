## Introduction to DNS and BIND 9
This Tutorial bases on the official documentation [BIND 9 Administrator Reference Manual](https://bind9.readthedocs.io/en/latest/#)

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
                                _______________|____________________                                  Delegation
                         ______|______                       _______|________                                              
                        |     |       |                     |       |        |                                      
TLD                    .com  ( )   .org                    .us     ( )      .uk
DNS                           |                                     |
                              |                                     |
                   ___________|_______                      ________|_________
User               |          |       |                     |       |         |   
DNS            .example      .b      .c                    .co     .ac       .org
                                             
                                             
                                                                                                     
```

### Root Servers
The `root servers` are a critical part of `DNS` authoritative infrastructure. There are 13 `root name servers` operated by 12 independent organisations. There are over 1758 instances of `root servers` which are also operated by the 12 independent operators. Further information is available at https://www.root-servers.org.   

### Name resolution
The process of converting `domain name` to IP address is called `name resolution`, and is handled by `resolvers`  (aka. `caching name servers`).

An end-user application, such as a browser, makes at first an internal system call to `stub resolver`. The `stub resolver` (using cached IP addresses) contacts a `resolver` (a caching resolver or a full-service resolver) which in turn contacts all the necessary authoritative name servers (`DNS root server`, `DNS TLD Domain`, `DNS User Domain`) to provide answer to the end user. To improve performance, all resolvers (include `stub resolver`) cache their results. All communication between `stub resolver`, `resolver` and the authoritative `name servers` uses the `DNS` protocol's query and response message pair.

### DNS Protocol and Queries
`DNS queries` use the protocol `UDP` over the reserved `port 53`, but both `TCP` and `TLS` can optionally be used.

The name resolution process contains the following steps,

![Resolvers and Queries](images/recursive-query.png)

#### Step 1 *Stub Resolve*r sends a *Recursive Query*
The `stub resolver` sends a `recursive query` message (2) with the required domain name in the `QUESTION` section of the query to the `resolver`,
  - A `recursive` query requests the `resolver` to find the complete answer. 
  - And a `stub resolver` only sends `recursive queries` and always needs the service of a `resolver`. 

The response to a `recursive query` can be:
1. The answer to the user's `Question` in the `ANSWER` section of the query response
2. or an error (such as NXDOMAIN - the name does not exist)

#### Step 2 *Resolver* sends *Iterative Queries*
The `resolver` receives the `recursive query` and will
1. respond immediately, if the `ANSWER` is in its cache
2. or accesses the `DNS hierarchy` to obtain the answer. 

The `resolver` always starts with `root servers` and sends an `iterative query` (4,5 and 6). The response to an `iterative query` can be:
1. The answer to the resolver's `QUESTION ` in the `ANSWER` section of the query response
2. or a `referal` (indicated by an empty `ANSWER` section but data in the `AUTHORITY` section, and typically `IP`addresses in the `ADDITIONAL` section of the response) or
3. or an error (such as `NXDOMAIN - the name does not exist)

If the response is either an answer or an error, these are returned immediately to the user and cached for future use.
If the response is a referral, the resolver needs to take additional action to respond to the user's recursive query.

#### Step 3 *Resolver* sends queries to *Referral*
A `referral` indicates that 
1. the queried server does not know the answer (the `ANSWER` section of the response is empty)
2. and it refers the `resolver` to the `authoritative name servers` in the `AUTHORITY` section of the response.

Thus, if the **QUESTION** is for the domain name **www.example.com**, then
1. the **root server** to which the **iterative query** was sent adds a list of the **.com authoritative name servers** in the **AUTHORITY** section.
2. And the `resolver` selects one of the servers from the **AUTHORITY** section and sends an `interative query` to it.
3. Similarly, the `.com authoritative name servers` send a referral containing a list of the **example.com authoritative name servers**.
4. This process continues **down** the DNS hierarchy until either an **ANSWER** or an error is received
5. and at which point the user's original `recursive query` is sent a response.

`Note: The DNS hierarchy is always accessed starting at the root servers and working down.`

For further information read [RFC 1034](https://datatracker.ietf.org/doc/html/rfc1034.html) and [RFC 1035](https://datatracker.ietf.org/doc/html/rfc1035.html).

### DNS and BIND 9
**BIND 9** is a complete implementation of the **DNS** protocol. **BIND 9** can be configured (using its `named.conf` file) as an `authoritiative name server`, a `resolver`, and, on supported host, a `stub resolver`. 

Smaller operators will use **BIND 9** to configure a single **DNS server** acting as both an **authoritative name server** and a **resolver** 

### DNS Security Overview
**DNS** is a communications protocol. All communication protocols are potentially vulnerable to both subversion and eavesdropping. 

To increase security, consider to configure **DNS over TLS**