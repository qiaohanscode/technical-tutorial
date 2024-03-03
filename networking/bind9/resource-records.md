## DNS Reource Records (RRs)
`DNS resource records (RRs)` describe the characteristics of a zone (or domain) and have a `binary or wire-format`, which is used in queries and responses, and a text format used in zone files which is described in this chapter.

### Zone File format
A DNS zone file is constructed using `Resource Record (RRs)` and `Directives`. The text representation of these records are stored in zone files.
1. Zone files consist of `Comments`, `Derectives` and `Resource Records`
2. Comments start with `;` (semicolon) and are assumed to continue to the end of the line
3. `Direcitves` start with `$` and are standardized - `$ORIGIN` and `$INCLUDE` (defined in RFC 1035) and `$TTL` (defined in RFC 2308). Bind additionally provides the non-standard `$GENERATE` directive.
4. There are a number of Resource Record (RR) types Defined in RFC 1035 and augmented by subsequent RFCs.
5. The `$TTL` directive should be üresent and appear before the first RR
6. The first Resource Record must be the __SOA (Start of Authority)__ record.

### DNS Generic Record Format
Resource Records have two representations. A textual format described in this chapter and a __binary or wire-format__ describe in [Pro DNS and Bind, Chapter 15](https://www.zytrax.com/books/dns/ch15/)

The textual format has the following generic form:
```
owner-name [ttl] [class] type type-specific-data
or
owner-name [class] [ttl] type type-specific-data
```
where:

Column|Description
---|---
owner-name | The owner-name (or label) of the node in thhe zone file to which this record belongs. The owner-name field may also take one of the following values: `@ ; replace with the current value of $ORIGIN` or ` ; blank/space or tab in which case the last owner-name will be used`.
ttl | 32 bit value, a decimal integer, optional. __The Time to Live__ in seconds (range is 1 to 2137383647) and indicates how long the RR may be cached. The value zero indicates the data should not be cached.
class | A 16 bit value which defines the protocol family or an instance of the protocol, optional. The normal value is __IN__ = __Internet protocol__
__types__ | The resource record type which determines the value(s) of the ___type-specific-dta___ field.
type-specific-data| Data content of each record is defined by the ___type___ and ___class___ values.

Omited ___class___ and ___ttl___ values are default to the last explicitly stated values.

### DNS Resource Record (RR) Types
This is an incomplete list, a more detailed list can be fund in [Pro DNS and Bind, Chapter 8 DNS RR Types](https://www.zytrax.com/books/dns/ch8/#types). The full list of __DNS Resource Record (RR) types__ may be obtained from [IANA DNS Parameters](http://www.iana.org/assignments/dns-parameters).

RR | Value   | RFC                                                          | Description
-|---------|--------------------------------------------------------------|-
A | 1       | [RFC 1035](https://www.iana.org/go/rfc1035) | IPv4 Address record. An IPv5 address for a host
AAAA | 28 | [RFC 3596](https://www.iana.org/go/rfc3596) | IPv6 Adress record for a host
CNAME | 5 | [RFC 1035](https://www.iana.org/go/rfc1035) | Canonical Name. An alias name for a host. Causes redirection for a single RR at the owner-name.
DNAME | 39 | [RFC 6672](https://www.iana.org/go/rfc6672) | Redirection in DNS. Like CNAME but provides redirection for a subtree of the domain name tree in the DNS. That is, all names that end with a particular suffix are redirected to another parf of the DNS. ```frobozz.example.net.  DNAME    frobozz-division.acme.example.com.``
NS | 2 | [RFC 1035](https://www.iana.org/go/rfc1035)| Name Server. Defines the authoritative names server(s) for the domain (defined by the SOA record) or the subdomain.
PTR| 12| [RFC 1035](https://www.iana.org/go/rfc1035)| IP address (IPv4 or IPv6) to host. Unsed in reverse maps.
SOA|6|[RFC 1035](https://www.iana.org/go/rfc1035)| Start of Authority. Defines the zone name, an e-mail contact and various time and refresh values applicable to the zone.


The generic binary or wire-format is:
```
name ttl class type rdlen rdata
```
The binary format is describe in [Pro DNS and Bind, chapter 15 RR format](https://www.zytrax.com/books/dns/ch15/#answer)

### The $ORIGIN Directive
```
Syntax: $ORIGIN domain-name [comment]
```

__$ORIGIN__ sets the domain name that is appended to any unqualified records (those without a terminating dot). If an __$ORIGIN__ directive is not defined - BIND synthesizes an __$ORIGIN__ from the zone name in the named.conf file as illustrated below:
```
//named.conf file fragment

zone "ponyworld.srv" in {
        type master;
        file "forward.ponyworld.srv";
};
```

In the above fragment __$ORIGIN__ example.com. is synthesized if none present in the zone file (forward.ponyworld.srv).

__$ORIGIN__ is used in two contexts during zone file processing:
1. The symbol @ forces substitution of the current (or synthesized) value of __$ORIGIN__.
2. The current value of __$ORIGIN__ is added to any 'unqualified' name (any name which does not end in a dot).

## Appendices
### Useful Links
- [Pro DNS and BIND](https://www.zytrax.com/books/dns/)  -- a comprehensive introduction about BIND, extended version of DNS for Rocket Scientist