### Secret
contains credentials like password, TLS certificates, TLS private key and etc.

#### Create Secret With K8s Cli
Step 1 -- create a property file which contains the credentials. 
```
# secret-ekl-backend-ws-dev.properties
EKL_BACKEND_DB_URL=db-url
EKL_BACKEND_DB_USER=user
EKL_BACKEND_DB_PWD=password
```
`note: ` the key value needs to be in plain text.

Step 2 -- create YAML
```
kubectl create secret generic ekl-backend-ws-dev \
--from-env-file=secret-ekl-backend-ws-dev.properties \
--type=Opague --dry-run=client -o yaml > secret-ekl-backend-ws-dev.yaml
```

Step 3- apply YAML
```
kubectl apply -f secret-ekl-backend-ws-dev.yaml
```

For more details see
```
kubectl create secret generic --help
kubectl create secret --help
kubectl create --help
```

#### Read Secret 
```
kubectl get secret ekl-backend-ws-dev \
-o jsonpath='{.data.EKL_BACKEND_DB_USER}'|base64 -d
```