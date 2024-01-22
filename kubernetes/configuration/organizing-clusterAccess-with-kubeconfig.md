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

`kubectl` uses the following rules to merge kubeconfig files
1. if `--kubeconfig` flag is set, use only the specified file. Do not merge.
   Otherwise, if the `KUBECONFIG` environment variable is set, use it as list of files that should be merged.
2. determine the context to used based on thee first hit in this chain:
   1. Use `--context` command-line flag if exists.
   2. Use `current-context` from the merged kubeconfig files
3. Determine the cluster and user.
   1. Use a command-line flag if it exists: `--user` or `--cluster`
   2. if the context is non-empty, take the user or cluster from the context
4. Determin the actual cluster information to use. The first hit wins:
   1. Use command line flags if they exist:server , `--server`, `--certificate-authority`, `--insecure-skip-tls-verify`
   2. if any cluster information attributes exist from the merged kubeonfig files.
   3. if there is no server location, fail
5. Determine the actual user information to use.
   1. Use command line flags if exist: `--client-certificate`, `--client-key`, `--username`, `--password`, `--token`
   2. use the `user` fields from the merged kubeconfig files
   3. if there are two conflicting techniques, fail.
6. For any information still missing, use default values and potentially for authentication information.

### Proxy
You can configure `kubectl` to use a proxy per cluster using `proxy-url`in your kibeconfig file,
```
apiVersion: v1
kind: Config

clusters:
- cluster:
    proxy-url: http://proxy.example.org:3128
    server: https://k8s.example.org/k8s/clusters/c-xxyyzz
  name: development

users:
- name: developer

contexts:
- context:
  name: development
```
