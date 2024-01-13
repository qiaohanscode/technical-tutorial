### Step 1 Install Helm Client From Script

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
`Note: ` it is possible to install through package managers like `homebrew`, `apt`, and etc.

### Step 2 Add Kubernetes Dashboard Helm Repository
```
helm repo add k8s-dashboard https://kubernetes.github.io/dashboard/
helm repo list
```

### Step 3 Install Package Kubernetes Dashboard
To install a new package, use the following command. It takes two arguments: a release name that you pick
and the name of the chart you want to install.
```
helm install k8s-dashboard k8s-dashboard/kubernetes-dashboard --create-namespace --namespace k8s-dashboard

helm upgrade --install k8s-dashboard k8s-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
```

### Step 4-A Access Dashboard with NodePort
```
apiVersion: v1
kind: Service
metadata:
  name: k8s-dashboard-nodeport-service
  namespace: k8s-dashboard
spec:
  selector:
    app.kubernetes.io/component: kubernetes-dashboard
    app.kubernetes.io/instance: k8s-dashboard
    app.kubernetes.io/name: kubernetes-dashboard
  ports:
    - protocol: TCP
      port: 8443
      targetPort: 8443
      nodePort: 30010
  type: NodePort
```
K8s dashboard is available under https://ekl-k8s-master-1.fritz.box:30010

### Step 4-B Access Dashboard with Ingress
