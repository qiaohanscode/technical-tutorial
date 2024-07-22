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

#### Add Host To DNS Cache And Set CA Certificate
```
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

```
