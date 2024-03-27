#### Step 1 Create namespace ekl-dev
```
apiVersion: v1
kind: Namespace
metadata:
  name: ekl-k8s-dev
```

#### Step 2 Create X.509 Certificate 
1. Create private key
```
openssl genrsa -out ekl-k8s-dev-edit-qiao-han.key 2048
openssl req -new -key ekl-k8s-dev-edit-qiao-han.key -out ekl-k8s-dev-edit-qiao-han.csr -subj "/CN=qiao-han/O=ekl-k8s-dev-edit"
```

2. Create Certificate Signing Request
create the file ekl-k8s-dev-edit-qiao-han-csr.yaml with placeholder USER_CSR
```
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ekl-k8s-dev-edit-qiao-han-csr
spec:
  request: USER_CSR
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400
  usages:
  - client auth
```

substitute placeholder with CSR
```
sed -i -e "s/^ *request: USER_CSR/  request: $(cat ekl-k8s-dev-edit-qiao-han.csr|base64|tr -d "\n")/g" \
ekl-k8s-dev-edit-qiao-han-csr.yaml
```

apply the yaml
```
kubectl apply -f ekl-k8s-dev-edit-qiao-han-csr.yaml
```

get the list of csr
```
kubectl get csr -n ekl-k8s-dev-edit-qiao-han-csr
```

3. Approve the csr
```
kubectl certificate approve ekl-k8s-dev-edit-qiao-han-csr
```

4. export the created certificate
```
kubectl get csr ekl-k8s-dev-edit-qiao-han-csr -o jsonpath='{.status.certificate}'|base64 -d \
> workspace-k8s/cert/ekl-k8s-dev-edit/ekl-k8s-dev-edit-qiao-han.crt
```

#### step 3 Create RoleBinding
- Option 1 -- create with `kubectl`
```
kubectl create rolebinding ekl-k8s-dev-edit --clusterrole=edit --group=ekl-k8s-dev-edit --namespace=ekl-k8s-dev
```

- Option 2 -- create with yaml
```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ekl-k8s-dev-edit
  namespace: ekl-k8s-dev
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: edit
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: ekl-k8s-dev-edit
```

#### step 4 create kubeconfig file
create the file ~/.kube/ekl-k8s-dev-edit/config

```
kubectl config --kubeconfig=~/.kube/ekl-k8s-dev-edit/config set-cluster ekl-k8s-dev
```

#### step 4.1 add cluster details
1. export ca-certificate to cert_ca.crt
```
cat ~/.kube/cluster-admin/config | grep -e "certificate-authority-data" | \
sed -e 's/^ *certificate-authority-data: //g' | \
tr -d "\n" | base64 -d > ~/Han/workspace-k8s/cert/cert-ca/cert-ca.crt
```

2. set cluster details
```
kubectl config --kubeconfig=/Users/yiyuma/.kube/ekl-k8s-dev-edit/config set-cluster ekl-k8s-dev \
--server=https://ekl-k8s-master-1.ponyworld.io:6443 \
--certificate-authority=/Users/yiyuma/Han/workspace-k8s/cert/cert-ca/cert-ca.crt \
--embed-certs
```

#### step 4.2 add user details
set user credentials
```
cd ~/.kube/ekl-k8s-dev-edit/

kubectl config --kubeconfig=config set-credentials qiao-han \
--client-certificate=/Users/yiyuma/Han/workspace-k8s/cert/ekl-k8s-dev-edit/ekl-k8s-dev-edit-qiao-han.crt \
--client-key=/Users/yiyuma/Han/workspace-k8s/cert/ekl-k8s-dev-edit/ekl-k8s-dev-edit-qiao-han.key \
--embed-certs
```

#### step 4.3 add context details
```
kubectl config --kubeconfig=/Users/yiyuma/.kube/ekl-k8s-dev-edit/config \
set-context ekl-k8s-dev-edit --cluster=ekl-k8s-dev --namespace=ekl-k8s-dev \
--user=qiao-han
```

#### step 4.4 set current context
```
kubectl config --kubeconfig=/Users/yiyuman/.kube/ekl-k8s-dev-edit/config use-context ekl-k8s-dev-edit
```

### step 5 set KUBECONFIG
add following command to ~/.zprofile (MacOS) or ~/.bashrc (Ubuntu)
```
export KUBECONFIG=~/.kube/ekl-k8s-dev-edit/config
```