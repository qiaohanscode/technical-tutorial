```
curl -i https://www.google.de
/* -i include protocol response headers in the output*/
```
```
$ curl -i -u user:8e557245-73e2-4286-969a-ff57fe326336 http://localhost:8080/some/path
```

#### Disable Certificate Verification
```
# -k or --insecure
curl -i -k https://localhost:8443/api/build/version
```
