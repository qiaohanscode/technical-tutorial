## Tools for Use With the name Server Daemon

### Diagnostic Tools
#### dig
__dig__ is the most versatile and complete of these lookup tools. For a complete list of available commands and options, see [dig-DNS lookup utility](https://bind9.readthedocs.io/en/latest/manpages.html#man-dig)

#### host
__host__ utility emphasizes simplicity and ease of use. By default, it converts between host names and Inernet addresses. For more information see [host - DNS lookup utility](https://bind9.readthedocs.io/en/latest/manpages.html#man-host)

#### nslookup
__nslookup__ has tow modes: interactive and non-interactive. Not recommended. Prefer __dig__.

### Administrative Tools
#### named-checkconf
checks the syntax of a __named.conf__ file. For more information see [named-checkeconf -- named configuration file syntax checking tool](https://bind9.readthedocs.io/en/latest/manpages.html#man-named-checkconf)

#### named-checkzone
checks a zone file for syntax and consistency. For details see [named-checkzone -- zone file validation tool](https://bind9.readthedocs.io/en/latest/manpages.html#man-named-checkzone)

#### rndc
The __remote name daemon control (rndc)__ program allows the system administrator to control the operation of a name server. For details see [rndc - name server control utility](https://bind9.readthedocs.io/en/latest/manpages.html#man-rndc)

