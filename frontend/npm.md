install dependency
```
npm install
```

install angular cli to global path
```
npm iq -g @angular/cli@13.3.10
npm install -g @angular/cli
```

uninstall global installed package angular cli
```
npm uninstall -g @angular/cli@16
```

uninstall global installed package angular cli
```
npm uninstall -g @angular/cli@16
```

list currently installed packages in prefix path
```
npm list
```

list version of the given packages
```
npm list @angular/core
```

list currently installed package in global path
```
npm list -g
```

list currently used configuration
```
npm config list
```

list currently used configuration with default -- all the currently used configuration
```
npm config list -l
```
update npm to 9.8.0
```
npm install -g npm@9.8.0
```

show where the global librarys have been installed 
```
npm root -g
```

find out if the scope @allianz has special registry
```
npm config get @allianz:registry
```

set registry for the scope @allianz
```
npm config set @allianz:registry "https://nexus-frontend.frameworks.allianz.io/repository/npm-public/"
```
login to the neux repository - after successful authentication an authentication token will be saved in ~/.npmrc.
```
npm config set @allianz:registry "https://nexus-frontend.frameworks.allianz.io/repository/npm-public/"
```

