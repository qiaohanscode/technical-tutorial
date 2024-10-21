#### Add/Install a package
```
ng add @allianz/ngx-ndbx
ng add @angular-devkit/schematics@16.2.10
```

#### Update Angular Application
Details about update can be found [Angular Update Guide](https://angular.dev/update-guide).
```
# analyse possible updates and show possible update steps
ng update
```

#### Update a dependency forcely
```
ng update @angular/cli@17.0.7 --force
```

#### Create a new project/workspace
```
ng new my-new-project
```

#### Start angular application with proxy configuration
```
ng serve --host 0.0.0.0 --proxy-config proxy.conf.json
```

#### Compile angular project 
Compile with configuration defined in the file angular.json -- not tested
```
ng build --configuration production
```
