## Round-robin DNS
`Round-robin DNS` is a technique of load distribution, load balancing or fault-tolerance provisioning multiple, 
redundant Internet Protocol service hosts, e.g., Web Server, by managing the Domain Name System's responses to 
address requests from client computers according to an appropriate statical model.

Round-robin DNS works by responding to DNS requests not only with a single potential IP address, but with a list of 
potential IP addresses corresponding to several servers that host identical services. With each DNS response, the IP 
address sequence in the list is permuted -- the first IP address will be arranged to the last of the list by the next
DNS request and the second IP address will be the first IP address and so on. 

Traditionally, IP clients initially attempt connections with the first address returned from a DNS query, so that on
different connection attempts, clients would receive service from different providers, thus distributing the overall 
load among servers. Round-robin DNS is often used to load balance requests among a number of Web servers.

Round-robin DNS may not be the best choice for load balancing on its own, since it merely alternates the order of the 
address records each time a name server is queried. It works more like load distribution.

### Reference
https://en.wikipedia.org/wiki/Round-robin_DNS