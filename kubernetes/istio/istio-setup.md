### Download Istio Release
Download and extract Istio release automatically (Linux & MacOs)
```
curl -L https://istio.io/downloadIstio | sh -
```
Configure Istioctl for the environment
```
export PATH="$PATH:/home/tim/workspace-k8s/istio/istio-1.20.1/bin"
```

### Install With Istioctl
Install Istio with `default configuration profile
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
```

### Uninstall Istio
```
istioctl uninstall --purge

//the namespace will not removed automaticall and can be removed with kubectl
kubectl delete namespace istio-system
```