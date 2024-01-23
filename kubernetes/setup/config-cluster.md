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
openssl req -new -key ekl-k8s-dev-edit.key -out ekl-k8s-dev-edit.csr -subj "/CN=ekl-k8s-dev-edit/OU=einkaufsliste/O=ponyworld"
```

2. Create Certificate Signing Request
create the file ekl-k8s-dev-edit-csr.yaml
```
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ekl-k8s-dev-edit-csr
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ2pEQ0NBWFFDQVFBd1J6RVpNQmNHQTFVRUF3d1FaV3RzTFdzNGN5MWtaWFl0WldScGRERVdNQlFHQTFVRQpDd3dOWldsdWEyRjFabk5zYVhOMFpURVNNQkFHQTFVRUNnd0pjRzl1ZVhkdmNteGtNSUlCSWpBTkJna3Foa2lHCjl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFrNzcwaTBtdWFjWXhCUEJqUFNGdm9RZXUrY0xBR2J3OG1iUmMKajNmN3hzckg2UlBOZWM3Y0FTMDJ3VlFXUkZNQmFNMmtSa3J2RjRBQit2cGVXb2ZLV2FhcFZSbThUdy9QUFpBRgprODYxcGk5cDZIUkk1aDR5cDlpcCtyaHY0RDJ0TXRhbDUxcGRBa295L2JCeXZCNVZWanNVYlR2NG53bmhhcDZnCnlxMWZ6SW9Xc1oyTkZ0ajV4SWwwUHZtZUdoMlgyT0Zsb0JIblhUNHh6TUdjZmp1VW52eERUUWJuejFFai91RVQKUFI0azFHSUxFajlaUWlPVmpvdHAwQUIreXVzZ3RIcFluc084MXlhVzg1QTQxbktqWnpibWRZWWFRaG9aVTd5VQpXVENmcEduOUVCRkZ2UWZoWVc3QlFmcWI5UEQ0Q3hPek9GL2JkQzlscXllZHhUN01UUUlEQVFBQm9BQXdEUVlKCktvWklodmNOQVFFTEJRQURnZ0VCQUdsRW56QVhrbC90VWxrSDhoNURrVm14anVLNi9zSW9WWXZieXhmWDFmbTgKdW93L2ZyZ0JCTjVPWFNUR0pNQjdHemFyZGgyRXhGNnI5SE0vWWFGSkpJRUZMN3lhU2Vqa1RmUnpDb3dkWkJEcgp1Ky8xem4xM0YzQ1VyLzc2QXdiY0hwdFQ1d0o4OWthN1N5Zlh1Z1lLc2phQ0hzbk1sUTRkdGxLMytRYkg1cmswCmZIUzhqNjZsVUdua05NWnFtNU9UUEY5SXhDazMyWk94RzhDb3h3VnFvN085MGJyNkdIWGowek5XT2hScTcvUi8KUzlnUHh0M3JDcXdFWVZuRDZ5cTJ6MytnRjZCVUNJYTZzZEp3VVFMdTZlRjhPaEJWcVNOZnc3T2ErTXV0dGU1bgpGQkl1VTlYdzh2VERFY0hUb2I0RnQrOUpCNVhGMzBGVGhYaGVqT21KdjZzPQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400
  usages:
  - client auth
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

4. get the created certificate
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

add cluster details
```
# export ca-certificate to environment variable
export cluster_ca=$(cat .kube/cluster-admin/config|grep -e "certificate-authority-data"| \
sed -e 's/certificate-authority-data://g'| \
tr -d "[:blank:]"| \
tr -d "\n")

# set cluster details
kubectl config --kubeconfig=.kube/ekl-k8s-dev-edit/config set-cluster ekl-k8s-dev \
--server=https://ekl-k8s-master-1.fritz.box:6443 \
--certificate-authority=$(echo $cluster_ca)

# change to certificate-authority-data
sed -i -e 's/certificate-authority/certificate-authority-data/g' .kube/ekl-k8s-dev-edit/config
```