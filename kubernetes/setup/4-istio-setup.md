Istio is an open source service mesh that layers transparently onto existing distributed applications.

A service mesh is a dedicated infrastructure layer that you can add to your applications. It allows you to transparently
add capabilities like observability, traffic management and security, without adding them to your own code.

### Download Istio Release
Download and extract Istio release automatically (Linux & MacOs)
```
curl -L https://istio.io/downloadIstio | sh -
```
Configure Istioctl for the environment
```
export PATH="$PATH:/home/tim/workspace-k8s/istio/istio-1.21.1/bin"
```

### Install With Istioctl
Install Istio with configuration profile `default`, which will install `istiod` and istio-ingressgateway`
```
istioctl install
```
The available istio configuration profiles can be listed with the command
```
istioctl profile list
```
Display the configuration of a profile
```
istioctl profile dump demo
```
`Note:` details about the `Istio configuration profile` has been documented by the link
https://istio.io/latest/docs/setup/additional-setup/config-profiles/

Check installation with
```
kubectl get pod -n istio-system

kubectl get svc -n istio-system

kubectl -n istio-system get deployment
```

verify a successful installation
```
//generate the manifest of the deployment with default profile
./istioctl manifest generate > ~/temp/1/generated-manifest-defaut.yaml

//verify the installation with generated manifest
./istioctl verify-install -f ~/temp/1/generated-manifest-default.yaml
```

### Create Istio Gateway
```
kubectl apply -f ekl-k8s-gateway.yaml
```

### Install Kiali
```
//install istio addon kiali
kubectl apply -f $ISTIO_DIR/samples/addon/kiali.yaml

//create virtualservice 
kubectl apply -f ekl-k8s-virtual-service-kiali.yaml

//get IP address of service (type LoadBalancer) istio-ingressgateway
kubectl -n istio-system get svc

//add resource record (RR) into forward mapping zone file for kiali
kiali   IN  A   192.168.178.240 ; IP Address of service istio-ingressgateway

//check availabilty of kiali
curl -v http://kiali.ponyworld.io 
```
`Note: ` the application kiali is also available under web browser

### Create ClusterRole ekl-k8s-istio-edit
```
kubectl apply -f ekl-k8s-istio-edit-clusterrole.yaml
```

### Uninstall Istio
```
istioctl uninstall --purge

//the namespace will not removed automaticall and can be removed with kubectl
kubectl delete namespace istio-system
```

### Appendix A -- useful links
- Istio -- https://istio.io/latest/