Use kubeconfig files to organize information about clusters, users, namespaces and authentication mechanisms. The 
`kubectl` command-line tool uses kubeconfig files to find the information it needs to choose a cluster and communicate 
with the API server of a cluster

By default, `kubectl` looks for a file named `config`in the `$HOME/.kube` directory. You can specify other kubeconfig 
files by setting the `KUBECONFIG` environment variable ob by setting the `--kubeconfig` flag.

### Supporting multiple clusters, users and authentication mechanisms

### Context
A `context` element in a kubeconfig file is used to group access parameters under a convenient name. Each context has 
three parameters:
- cluster
- namespace
- user

By default, `kubectl` used parameters from the current context to communicate with the cluster. To choose the current 
context:
```
kubectl config use-context
```

### KUBECONFIG environment variable
`KubeCONFIG` holds a list of kubeconfig files. For Linux and Mac, the list is colon-delimited (:). For Windows, 
semicolon-delimited(;)

If `KUBECONFIG` does exist, `kubectl` merge the files to an effective configuration.

### Merging kubeconfig files
To see your configuration, enter this command:
```
kubectl config view
```