### ConfigMap
provides stage specific configurations.

#### Create ConfigMap With K8s Cli
```
# create the YAML of ConfigMap
kubectl create configmap ekl-backend-ws-dev \
--from-file=config-ekl-backend-ws-dev.properties --dry-run=client \
-o yaml > configmap-ekl-backend-ws-dev.yaml

# open YAML 
vim configmap-ekl-backend-ws-dev.yaml

# extends metadata with Namespace
meta:
  namespace: ekl-k8s-dev
```
For more details see 
```
kubectl create --help
kubectl create configmap --help
```