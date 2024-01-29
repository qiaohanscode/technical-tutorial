#### Step 1 Create namespace ekl-dev
```
apiVersion: v1
kind: Namespace
metadata:
  name: ekl-dev
```

#### Step 2 Create X.509 Certificate 
1. Create private key
```
openssl genrsa -out ekl-k8s-dev-edit.key 2048
openssl req -new -key ekl-k8s-dev-edit.key -out ekl-k8s-dev-edit.csr -subj "/CN=ekl-k8s-dev-edit"
```

2. Create Certificate Signing Request
export CSR to variable user_ca_csr
```
user_ca_csr=$(cat ekl-k8s-dev-edit.csr|base64|tr -d "\n")
```

create the file ekl-k8s-dev-edit-csr.yaml with placeholder USER_CA_CSR
```
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ekl-k8s-dev-edit-csr
spec:
  request: USER_CA_CSR
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400
  usages:
  - client auth
```

substitute placeholder with CSR
```
sed -i -e "s/^ *request: USER_CA_CSR/    request: $user_ca_csr" .kube/ekl-k8s-dev-edit/config
```

apply the yaml
```
kubectl apply -f ekl-k8s-dev-edit-csr.yaml
```

get the list of csr
```
kubectl get csr -n ekl-k8s-dev
```

3. Approve the csr
```
kubectl certificate approve ekl-k8s-dev-edit-csr
```

4. export the created certificate
```
kubectl get csr ekl-k8s-dev-edit-csr -o jsonpath='{.status.certificate}'|base64 -d \
> workspace-k8s/cert/ekl-k8s-dev-edit/ekl-k8s-dev-edit.crt
```

#### step 3 Create RoleBinding
- Option 1 -- create with `kubectl`
```
kubectl create rolebinding ekl-k8s-dev-edit --clusterrole=edit --user=ekl-k8s-dev-edit --namespace=ekl-k8s-dev
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
  kind: User
  name: ekl-k8s-dev-edit
```

#### step 4 create kubeconfig file
create the file .kube/ekl-k8s-dev-edit/config

```
apiVersion: v1
kind: Config
preferences: {}

clusters:
- cluster:
  name: ekl-k8s-dev

contexts:
- context:
  name: ekl-k8s-dev-edit

users:
- name: ekl-k8s-dev-edit
```

#### step 4.1 add cluster details
1. export ca-certificate to variable
```
cluster_ca=$(cat .kube/cluster-admin/config|grep -e "certificate-authority-data"| \
sed -e 's/certificate-authority-data://g'| \
tr -d "[:blank:]"| \
tr -d "\n")
```

2. set cluster details
```
kubectl config --kubeconfig=.kube/ekl-k8s-dev-edit/config set-cluster ekl-k8s-dev \
--server=https://ekl-k8s-master-1.fritz.box:6443 \
--certificate-authority=$(echo $cluster_ca)

# change to certificate-authority-data
sed -i -e 's/certificate-authority/certificate-authority-data/g' .kube/ekl-k8s-dev-edit/config
```

#### step 4.2 add user details
1. export user certificate and user private key to variables
```
user_ca=$(cat workspace-k8s/cert/ekl-k8s-dev-edit/ekl-k8s-dev-edit.crt|base64|tr -d "\n")
user_key=$(cat workspace-k8s/cert/ekl-k8s-dev-edit/ekl-k8s-dev-edit.key|base64|tr -d "\n")
```
2. set user credentials
```
kubectl config set-credentials --kubeconfig=.kube/ekl-k8s-dev-edit/config \
--client-certificate=$user_ca --client-key=$user_key
```

#### step 4.3 add context details
```
kubectl config --kubeconfig=.kube/ekl-k8s-dev-edit/config \
set-context ekl-k8s-dev-edit --cluster=ekl-k8s-dev --namespace=ekl-k8s-dev \
--user=ekl-k8s-dev-edit
```

#### step 4.4 set current context
```
kubectl config --kubeconfig=.kube/ekl-k8s-dev-edit use-context ekl-k8s-dev-edit
```

### step 5 set KUBECONFIG
add following command to ~/.zprofile (MacOS) or ~/.bashrc (Ubuntu)
```
export KUBECONFIG=~/.kube/ekl-k8s-dev-edit/config
```