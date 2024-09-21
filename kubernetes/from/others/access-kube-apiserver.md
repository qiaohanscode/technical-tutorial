### Access Kubernetes API-Server
 The detailed description can be found [Access kube-apiserver With kubectl proxy](https://collabnix.github.io/kubelabs/api.html#:~:text=Once%20the%20proxy%20is%20running,cluster%20from%20your%20local%20machine.).
 
#### Run kubectl in proxy mode
```
kubectl proxy --port=8080 &
```

#### Explore the API with `curl`, `wget` or  a browser
```
curl http://localhost:8080/api
```
The output is similar to this:
```
[node1 kubelabs]$ curl http://localhost:8080/api/
{
  "kind": "APIVersions",
  "versions": [
    "v1"
  ],
  "serverAddressByClientCIDRs": [
    {
      "clientCIDR": "0.0.0.0/0",
      "serverAddress": "192.168.0.18:6443"
    }
  ]
```
