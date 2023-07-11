list available versions of nodejs
```
dnf module list nodejs
```

install nodejs 18 on fedora 35
```
dnf module install nodejs:18/common
```

update to arbitary nodejs version
```
/* Step 1: Clean the NPM cache */
sudo npm cache clean -f

/* install node helper (n) globally */
sudo npm install -g n

/* install the Latest Version of Node */
sudo n stable

/* install a specific Node.js version */
sudo n 8.0.0
```
