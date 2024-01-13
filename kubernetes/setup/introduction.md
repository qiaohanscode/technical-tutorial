### Container Runtime Interface (CRI)
Each node in the kubernetes cluster, which is going to run pods, needs to install container runtime which conforms with CRI

### Docker Engine
Docker Engine is one common container runtime. For Kubernetes cluster you need to install
- Docker Engine
- cri-dockerd

### kubeadm
the command to bootstrap the cluster. Kubeadm `will not` install or manage `kubelet`or `kubectl` for you, so you need to ensure they match the version of the kubernetes control plane you want kubeadm to install for you. One minor version skew between the kubelet and control plane is supported, but the kubelet version may never exceed the API server version.

### kubelet
the component that runs on all of the nodes in the cluster and does things like staring pods and containers

### kubectl
the command line util to talk to your cluster