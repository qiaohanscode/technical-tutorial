- stable IP address
- loadbalancing
- loose coupling
- within and outside cluster

## DNS For Services and Pods
Kubernetes creates DNS records for Services and Pods. A DNS query may return different results based on the namespace of 
the Pod making it. DNS queries that don't specify a namespace are limited to the Pod's namespace. Access Services in 
other namespaces by specifying it in the DNS query.

For example. A Pod in a `test`namespace, a `data` Service in the `prod`namespace.

A query for `data` returns no result, because the query will be expanded to `data.test.svc.cluster.local`.

A query for `data.prod` returns the intended result, because it will be expanded to `data.prod.svc.cluster.local`.

In summary, a Pod in the `test` namespace has the fully qualified domain name (FQDN) `data.prod.svc.cluster.local`.

## Type Of Service
There are several types of services

### ClusterIP Service
- default type
- has the function as LoadBalancer
- accessible within cluster
- IP address from Node's range 
- Pods are identified via `selectors`
- key value pairs
- label of pods
- random label names
```
# pod
labels:
  app: my-app
  type: microservice
  
# service  
selector:
  app: my-app
  type: microservice
```


- k8s creates `Endpoint` object with the same name as `Service`
- keeps track of, which Pods are the members/endpoints of the Service
```
kubectl get endpoints
```

- `targetPort` of `Service` corresponds to `containerPort` of `Pod`
- may define multiple ports within a single `Service`
```
apiVersion: v1
kind: Service
metadata:
  name: mongodb-service
spec:
  selector:
    app: mongodb
  ports:
    - name: mongodb //needs to be defined
      protocol: TCP
      port: 27017
      targetPort: 27017
    - name: mongodb-exporter //needs to be defined
      protocol: TCP
      port: 9216
      targetPort: 9216
```
`Important:` each port needs to have a name, the name should/could be arbitrary.

### Headless Service
- used for data synchronisation
- can be used for stateful applications
```
spec:
  clusterIP: none
```

### NodePort Service
- available outside cluster, `NodePort` will be attatched to all the nodes
```
ports:
  - protocal: tcp
    port:3200
    targetPort: 3000
    nodePort: 30008 //in range 30000 -- 32676
```
- is an extension of `ClusterIP Service`
- only for test and not for production

### LoadBalancer Service
- accessible externally through `cloud providers LoadBalancer`
- is an extension of `NodePort Service`
```
spec:
  type: LoadBalancer
  selector:
    app: microservice-one
ports:
  - protocol: tcp
    port:3200
    targetPort: 3000
    nodePort: 30010 
```
`Important:` `LoadBalancer Service` is only accessible through the cloud LoadBalancer