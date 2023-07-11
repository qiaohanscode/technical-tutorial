install openapi generator cli
```
npm install -g @openapitools/openapi-generator-cli
```
download cli:jar
```
openapi-generator-cli version-manager set 5.3.0
```
use openapi generator 
```
npx openapi-generator-cli generate \
-i https://api.angular.schule/swagger.json \
-g typescript-angular \
-o ./src/app/books/shared/http \
--additional-properties=ngVersion=13.0.0,modelPropertyNaming=camelCase \
--skip-validate-spec
```
