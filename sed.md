stream editor

replace all (/g) matched texts in a list of files and write the replacement into (-i) the files
```
sed -i 's/old-text/new-text/g' testfile1.txt testfile2.txt
```

print all configured spring profiles to the console. The command sed uses multiple commands. The first command of sed use the escape character "\\" to escape the dot charactor "." which is a special expression (one arbitary single character) in regular expression (regex). The second command of sed uses regular expression ".*" which matches zero or more of arbitary characters (even new line). To be used in Jenkins pipeline written with groovy script the escape charactor ("\\") of regex may need to be escaped with the escape charactor (also "\\") of groovy script, 's/\\\\.properties//g'
```
ls src/main/resources/application-*.properties | sed -e 's/\.properties//g' -e 's/.*application-//g'
```
