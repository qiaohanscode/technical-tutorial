#### Step 1 Create ServiceAccount jenkins-ekl-k8s-dev
```
kubectl create serviceaccount ekl-dev-jenkins -n ekl-dev
```

#### Step 2 Assign Clusterrole edit to ServiceAccount jenkins-ekl-k8s-dev
```
# append following lines into Yaml of RoleBindng ekl-dev-edit
 
- kind: ServiceAccount
  name: ekl-dev-jenkins
  namespace: ekl-dev
```

#### Step 3 Assign ClusterRole ekl-k8s-istio-edit to ServiceAccount jenkins-ekl-k8s-dev
```
# append the folllowing lines into Yaml of RoleBinding ekl-k8s-dev-istio-edit
- kind: ServiceAccount
  name: ekl-dev-jenkins
  namespace: ekl-dev
```

#### Step 4 Create a long-lived API token for a ServiceAccount jenkins-ekl-k8s-dev
```
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: token-ekl-dev-jenkins
  namespace: ekl-dev
  annotations:
    kubernetes.io/service-account.name: ekl-dev-jenkins
type: kubernetes.io/service-account-token
EOF
```

#### Step 5 Create kubeconfig for ServiceAccount jenkins-ekl-k8s-dev
```
bash ./create-kubeconfig-for-sa.sh
```
### Appendix
[Kubernetes - ServiceAccount](https://kubernetes.io/docs/concepts/security/service-accounts/)