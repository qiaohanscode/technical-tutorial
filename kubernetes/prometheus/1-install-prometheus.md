### Install Prometheus With Helm Chart
The helm chart of prometheus is available 
under [Prometheus-Community/helm-charts](https://prometheus-community.github.io/helm-charts/).

#### Step 1 Add Helm Repo Prometheus-Community
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

#### Step 4 Create Namespace ekl-prometheus
```
kubectl create namespace ekl-prometheus
```

#### Step 3 Install Prometheus
```
helm install ekl-prometheus prometheus-community/prometheus -n ekl-prometheus
```

#### Inspect Helm Chart Of Prometheus
```
helm get manifest ekl-prometheus -n ekl-prometheus > prometheus-helm-chart.yaml
```