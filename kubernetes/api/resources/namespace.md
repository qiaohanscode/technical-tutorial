## Namespace
- cluster within cluster
- 4 built-in namespaces
    - kube-system -- system component
    - kube-public -- public accessible data, a configmap contains cluster information,
    - kube-node-lease -- contains heartbeats of the cluster
    - default -- resource created if no new namespace created

### Charateristic of namespace
- most resources not accessible from other namespaces, e.g. own ConfigMap for Namespace
- Service can be accessed from another namespace, mysql-service.database-ns

### Use case of namespace
- group resources
- solve conflicts between teams
- share resources between different environments, staging and development
- blue green deployment
- access and resources limits on namespaces level

### create component in namespace
```
metadata:
  namespace: my-namespace
```

### change active namespace
Tool `kubectx` helps to switch the current namespace
````
kubens namespace-to-switch
````

### global component, not belong to namespace
- volume
- node

### other Namespaces
- kubernetes-dashboard
- monitoring
- elastic stack -- grafana
- database
- nginx-ingress