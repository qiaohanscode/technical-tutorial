# Linux command
show dns entry of the given url
```
dig www.google.de
```
sed tutorial

https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/

https://www.gnu.org/software/sed/manual/sed.html

awk tutorial

https://www.baeldung.com/linux/awk-nawk-gawk-mawk-difference

https://www.gnu.org/software/gawk/

execute commands in arbitary intervals
```
watch -n 1 "kubectl get pods | grep dev"
```
find all files in directory and print the number of founded files
```
find /etc -type f -name '*.sh' | wc -l
```
find specific text in files from specific folder
```
find fcp/ -type f -exec grep -l "TARGET" {} \;
```
add user to group vboxsf
```
sudo usermod -a -G vboxsf tim
```
#### SSH host key verification failed, remove the old host key from the known_hosts file
```
ssh-keygen -R <hostname>
```

