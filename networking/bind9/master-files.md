## Master Files
Master files are text files that contain __RRs__ in text form. A master file is most often used to define a zone.
### Format
The format of master files is a sequence of entries. Entries may in one of the following formats:
```
$ORIGIN <domain-name> [<comment>]

$INCLUDE <file-anme> [<domain-name>] [<comment>]

<domain-name><rr> [<comment>]

<bland><rr> [<comment>]
```
`<rr>` contents take one of the following forms:
```
[<TTL>] [<class>] <type> <RDATA>

[<class>] [<TTL>] <type> <RDATA>
```

All entries of master files need to satisfy the following conditions:
1. All RRs in the file should have the same class
2. Exactly one __SOA RR__ should be present at the top of the zone