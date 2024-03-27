### 3 parts
- metadata -- `metadata`
- specification -- `spec`
- status -- automatically created by k8s, shows the current status of the deployment

### `spec`
- replicas
- selector
- template

### `spec.template`
- is specification within the specification
- has its own `metadata` and `spec`
- applies to Pod
- blueprint for a Pod

### Connecting Deployment to Pods
Connection is established with `Labels` and `Selectors
- any key-value pair for components
```
metadata:
  labels:
    app: nginx
```

### Deployment
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress
  labels:
    app: nginx-ingress
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-ingress
  template:
    metadata:
      labels:
        app: nginx-ingress
    spec:
      containers:
      - name: nginx-ingress
        image: nginx
        ports:
        - containerPort: 8081
        env:
        - name: DB_USER_NAME
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: db-username
        - name: DB_URL
          valueFrom:
            configMapKeyRef:
              name: mongodb-configmap
              key: db_url  
```
### Service
```
apiVersion: v1
kind: Service
metadata: 
  name: mongodb-service
spec:
  selector: //labels of the Pods and Deployment
    app: mongodb
  type: LoadBalancer //only need to create external service
  ports: //multi ports are possible
    - protocol: TCP
      port: 27017 //port of the service
      targetPort: 27017 //port of the container
      nodePort: 30000 //only need for external service, muss be im range 30000-32767
```
check the service connects with the right pods, 
```
# attribute "Endpoint:" muss reference the IP adress of the Pods
kubectl describe service mongodb 

kubectl get pod -o wide
```

### ConfigMap -- local volume, namespaced
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: mongodb-configmap
data:
  db_url: db-service.database //where database is the namespace where the service db-service defined.
```

### Secret -- local volume, namespaced
```
apiVersion: v1
kind: Secret
metadata:
  name: mongodb-secret
type: Opaqu’e //general key value pair
data:
  db-user-name: $BASE64_CODED_USERNAME
```

### Ingress
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
spec:
  rules: //routing rules
  - host: myapp.com //valid domain name of the node of cluster which will be used as the entry point of the cluster
    http:
      paths: //url path, everything after the domain, can be empty
      - backend:
          serviceName: myapp-internal-service //muss be forwarded to a internal serivce
          servicePort: 8080
```
K8s NgInx Ingress Controller has a default backend which references the service `default-http-backend`. You can define your own default backend to customize the error message.
````
apiVersion: v1
kind: Service
metadata:
  name: default-http-backend
spec:
  selector:
    app: default-response-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
````
Configuring TLS Certificate - https//
```
apiVersion: networking.k8s.io/vi
kind: Ingress
metadata:
  name: tls-example-ingress
spec:
  tls:
  - host:
    - myapp.com
    secretName: myapp-secret-tls
  rules:
    - host: myapp.com
      http:
        paths:
        - path: /
          backend:
            serviceName: myapp-internal-service
            servicePort: 8080
---
apiVersion: v1
kind: Secret
metadata:
  name: myapp-secret-tls
  namespace: default
data:
  tls.crt: base64 encoded cert
  tls.key: base64 encoded key
type: kubernetes.io/tls
```
`Important:`
- data keys need to be `tls.crt` and `tls.key`
- values are file contents, NOT file paths/locations
- secret component must be in the same namespace as the Ingress component

#### Multiple paths for same host
```
apiversion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: name-virtual-host-ingress
spec:
  rules:
  - host: myapp.com
    http:
      paths:
      - path: /analytics
        backend:
          serviceName: analytics-service
          seervicePort: 3000
      - path: /shopping
        backend:
          serviceName: shopping-service
          servicePort: 8080
```

#### Multiple hosts -- subdomain
```
apiversion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: name-virtual-host-ingress
spec:
  rules:
  - host: analytics.myapp.com
    http:
      paths:
        backend:
          serviceName: analytics-service
          seervicePort: 3000
  - host: shopping.myapp.com
    http:
      paths:
        backend:
          serviceName: shopping-service
          servicePort: 8080
```