This page contains the information about how to configure access to multiple clusters by using configuration files.

You can switch between clusters by using the following command
```
kubectl config use-context
```

### Define clusters, users and contexts
Suppose you have two clusters, one for `development` work and one for `test` work. In the `development`cluster, 
your frontend developer work in a namespace called `frontend`, the storage developers work in the namespace `storage`. In
`test` cluster, developers work in the default namespace.

#### Step 1. create a file named `config-demo`

```
apiVersion: v1
kind: Config
preferences: {}

clusters:
- cluster:
  name: development
- cluster:
  name: test

users:
- name: developer
- name: experimenter

contexts:
- context:
  name: dev-frontend
- context:
  name: dev-storage
- context:
  name: test-exp
```

#### Step 2 Add cluster details
A configuration file describes clusters, users and contexts. Enter the following commands to add cluster details

```
kubectl config --kubeconfig=config-demo set-cluster development --server=https://1.2.3.4 --certificate-authority=fake-ca-file
kubectl config --kubeconfig=config-demo set-cluster test --server=https://5.6.7.8 --insecure-skip-tls-verify
```

#### Step 3 Add user details 
```
kubectl config --kubeconfig=config-demo set-credentials developer --client-certificate=fake-cert-file --client-key=fake-key-seefile
kubectl config --kubeconfig=config-demo set-credentials experimenter --username=exp --password=some-password
```

`Note:`
- To delete a user
```
kubectl --kubeconfig=config-demo config delete-user qiao-han
```
- To remove a cluster
```
kubectl --kubeconfig=config-demo config delete-cluster ekl-k8s-dev
```
- To remove a context
```
kubectl --kubeconfig=config-demo config delete-context ekl-k8s-dev-edit
```

### Step 4 Add context details
```
kubectl config --kubeconfig=config-demo set-context dev-frontend --cluster=development --namespace=frontend --user=developer
kubectl config --kubeconfig=config-demo set-context dev-storage --cluster=development --namespace=storage --user=developer
kubectl config --kubeconfig=config-demo set-context test-exp --cluster=test --namespace=default --user=experimenter
```

You can open the configure file with
```
kubectl config --kubeconfig=config-demo view
```

`Note:`
The `fake-ca-file` and `fake-cert-file` and `fake-key-file` are the placeholders for the pathname of the certificate 
files. If you want to use Base64-encoded date embedded here, you need to add the suffix `-data` to the keys, for example
`certificate-authority-data`, `client-certificate-data`and `client-key-data`.

`Note: Each context is a triple (cluster, user, namespace).`

Set the current context with
```
kubectl config --kubeconfig=config-demo use-context dev-frontend
```

Now whenever you enter a `kubectl` command, the action will apply to the cluster, and namespace listed in the 
`dev-frontend` context. And the command will use the credentials of the user listed in the `dev-frontend`context.

To see only the configuration information associated with the current context, use the `--minify` flag
```
kubectl config --kubeconfig=config-demo view --minify
```

### Check the subject represent by the kubeconfig
The following `kubectl` subcommand check subject attributes (username,groups) after authenticating to the cluster,
```
kubectl auth whoami
```
