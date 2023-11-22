.npmrc contains the runtime configuration for npm
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

For details see https://docs.npmjs.com/cli/v9/configuring-npm/npmrc

### Comments
Lines begin with `;` or `#`character are interpreted as comments
