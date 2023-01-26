stream editor

replace all (/g) matched texts in a list of files and write the replacement into (-i) the files
```
sed -i 's/old-text/new-text/g' testfile1.txt testfile2.txt
```

print all configured spring profiles to the console. The command sed uses multiple commands. The first command of sed use the escape character "\\" to escape the dot charactor "." which is a special expression (one arbitary single character) in regular expression (regex). The second command of sed uses regular expression ".*" which matches zero or more of arbitary characters (even new line). To be used in Jenkins pipeline written with groovy script the escape charactor ("\\") of regex may need to be escaped with the escape charactor (also "\\") of groovy script, 's/\\\\.properties//g'
```
ls src/main/resources/application-*.properties | sed -e 's/\.properties//g' -e 's/.*application-//g'
```

The special character & refers to the portion of the pattern space which matched.

```
cat phone.txt

5555551212
5555551213
5555551214
6665551215
6665551216
7775551217

sed -i -e 's/^[[:digit:]][[:digit:]][[:digit:]]/(&)/g' phone.txt

(555)5551212
(555)5551213
(555)5551214
(666)5551215
(666)5551216
(777)5551217

```
you can use multiple sed commands in a single sed command
```
cat phone.txt

5555551212
5555551213
5555551214
6665551215
6665551216
7775551217

sed -e 's/^[[:digit:]]\{3\}/(&)/g' \\
    -e 's/)[[:digit:]]\{3\}/&-/g' phone.txt 
(555)555-1212 
(555)555-1213 
(555)555-1214 
(666)555-1215 
(666)555-1216 
(777)555-1217
```

The special escapes \\1 through \\9 refers to the specific region in the regular expressions. To define a region, you insert backslashed parentheses "\\(" and "\\)" around each region of interest.
```
 cat phone.txt | sed 's/\(.*)\)\(.*-\)\(.*$\)/Area ode: \1 Second: \2 Third: \3/' 
 
Area code: (555) Second: 555- Third: 1212 
Area code: (555) Second: 555- Third: 1213 
Area code: (555) Second: 555- Third: 1214 
Area code: (666) Second: 555- Third: 1215 
Area code: (666) Second: 555- Third: 1216 
Area code: (777) Second: 555- Third: 1217
```
