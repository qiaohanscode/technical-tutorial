### Preparation
By using kube-proxy in IPVS mode, since k8s v1.14.2 you need to enable strict ARP mode
```
kubectl edit configmap -n kube-system kube-proxy
```
and set
```
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
strictARP: true
```

### Installation by Manifest
To install MetallLB apply the manifest:
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml
```
This will deploy MetalLB to the cluster under `metallb-system` namespace.

### Configure MetalLB
#### Defining the IPs to assign to the LoadBalancer Services
```
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: metallb-ip-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.178.240-192.168.178.250
```
Multiple instances of `IPaddressPool`s can co-exist and addresses can be defined by CIDR.

#### Announce The Service IPs
Once the IPs are assigned to a service, they must be announced. There are several protocols to announce service IPs:
- Layer 2 configuration
- BGP configuration
- ...

The protocol Layer 2 configuration is the simplest to configure and will be used.
```
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: metallb-ip-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.178.240-192.168.178.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: metallb-l2-advertisement
  namespace: metallb-system
spec:
  ipAddressPools:
  - metallb-ip-pool
```
Save the Layer 2 configuration to metallb-l2-range-allocation.yaml and apply
```
kubectl apply -f metallb-l2.range-allocation.yaml
```