.npmrc contains the runtime configuration for npm. `.npmrc`files are parsed by `npm/ini`
```
#always-auth = true
#email = timhanq@hotmail.com
registry=https://jfrog.io/artifactory/api/npm/npm-all/
#_auth = dHUtdGVhbS1hbWFzOlZXbFhSMEZSV0cxNGNFcHlRMUZ4V1RaNk5XTjRja2gw
#@angular:registry=https://nexus-gcj.apps.ec1.aws.io/repository/npm-public/
#//nexus-gcj.apps.ec1.aws.io/repository/npm-public/:always-auth=true
#//nexus-gcj.apps.ec1.aws.io/repository/npm-public/:email=timhanq@hotmail.com
#//nexus-gcj.apps.ec1.aws.io/repository/npm-public/:_auth=$TOKEN
```

### Files
Four files are relevant for npm. Each of theses files is loaded, the config options are solved in priority oder.
- per-project config (/path/to/my/project/.npmrc)
- per-user config file (~/.npmrc)
- global config file ($PREFIX/etc/npmrc)
- npm built in config file (/path/to/npm/npmrc)

### Comments
Lines begin with `;` or `#`character are interpreted as comments

### Auth related configuration.
The settings `_auth`, `_authToken`, `username` and `_password`must all be scoped to a specific registry. This ensures that `npm`will never send credentials to the wrong host.
- `_auth` - base64 authentication string
- `_authToken` - authentication token
- `usename`
- `_password`
- `email`
- `certfile` - path to certificate file
- `keyfile` - path to key file
`Note` - scope is the id of a library within npm repository, all packages of the library are scoped to this id, eg. @angular.

To scope these values, they must be prefixed by a URI fragment.
```
; bad config
_authToken=MYTOKEN

; good config
@myorg:registry=https://somewhere-else.com/myorg
@another:registry=https://somewhere-else.com/another
//registry.npmjs.org/:_authToken=MYTOKEN
; would apply to both @myorg and @another
; //somewhere-else.com/:_authToken=MYTOKEN
; would apply only to @myorg
//somewhere-else.com/myorg/:_authToken=MYTOKEN1
; would apply only to @another
//somewhere-else.com/another/:_authToken=MYTOKEN2
```

### Set registry
```
npm config set registry https://your-registry.domain.io/path/to/repository
```

### Set login credentials for registry
```
npm login --registry=https//your-registry.domain.io/path/to/repository
```

### Set Proxy
```
npm config set https-proxy http://your-proxy.domain.io:8080
npm config set proxy http://your-proxy.domain.io:8080
```
For details see https://docs.npmjs.com/cli/v9/configuring-npm/npmrc

