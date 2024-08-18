### Install Prometheus With Helm
Details about Prometheus Helm Charts can be found ([Git Hub Prometheus-Community](https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus/README.md)).

Details about Prometheus Operator can be found ([Git Hub Prometheus-Operator](https://github.com/prometheus-operator/kube-prometheus)).

#### Create K8s Namespace For Prometheus
````
kubectl create ns prometheus-system
kubectl label ns prometheus-system istio-injection=enabled --overwrite
````

#### Add Prometheus Repo into local repository
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

#### Install Prometheus
```
helm install prometheus prometheus-community/prometheus
```

#### Access Prometheus UI With Port-forward
```
kubectl port-forward $POD_NAMES_PROMETHEUS_SERVER 9090 -n prometheus-system
```

#### Access Prometheus Server With K8s Cluster
```
URL: prometheus-server.prometheus-system.svc.cluster.local   
Port: 80
```
