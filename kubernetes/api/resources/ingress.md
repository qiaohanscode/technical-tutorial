## Ingress
- evaluates all the rules
- manage redirection
- entrypoint to cluster
- an Ingress implementation will be need to configure Ingress, which works as the Ingress controller
- many third party implementations, k8s Nginx Ingress Controller is k8s implementation

### Architecture to create Ingress
- Option 1, in the cloud
```
---> cloud load balancer --->Ingress Controller Pod
```

- Option 2 bare metal
```
---> Separate Proxy Server ---> Ingress Controller Pod
```
`Proxy Server` should be
- separate server
- public IP address and open ports
- entrypoint to the cluster

`Important:` No Server in k8s ckuster is accessible from outside

#### Configure Ingress,
- Step 1: Install Ingress Controller -- K8s NgInx Ingress Controller
- Step 2: Create Ingress rules


### Configure Ingress
- Step 1 install bzw. enable Ingress Controller

### Configuring TLS Certificate
