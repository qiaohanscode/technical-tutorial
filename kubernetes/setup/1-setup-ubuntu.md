### OS: Ubuntun 22.04, Kubernetes v1.29
### Step 1 Set hostname on master and worker nodes
```
sudo hostnamectl hostname ekl-k8s-master-1.ponyworld.io
sudo hostnamectl hostname ekl-k8s-worker-1.ponyworld.io
sudo hostnamectl hostname ekl-k8s-worker-2.ponyworld.io
```

### Step 1 Disable swap & Add kernel parameters. 
The following commands need to be executed on all the nodes
```
sudo swapoff -a
sudo sed -i 's/^\/swap/#\/swap/g' /etc/fstab
```
`Note:` check swap usage with following commands
```
free -h
lsblk
blkid
```

Forwarding IPv4 and letting iptables see bridged traffic
```
# Load the following kernel moules on all the nodes
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Set the following kernel parameters for Kubernetes
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```

Verify that `br_netfilter`, `overlay` modules are loaded
```
lsmod | grep br_netfilter
lsmod | grep overlay
```

Verify the following system variables are set to `1` in `sysctl`
```
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward 
```

### Step 2 Install Containerd Runtime 
Using containerd runtime. First install its dependencies
```
sudo apt install -y curl gpg software-properties-common apt-transport-https ca-certificates
```
`Note:` software-properties-common and apt-transport-https are required by kubernetes

Enable docker repository
```
# Add Docker's official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

#Add the repository to Apt sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
```

Install containerd
```
sudo apt install -y containerd.io
```

Configure containerd so that it starts using systemd as cgroup
```
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

Restart and enable containerd serivce
```
sudo systemctl restart containerd
sudo systemctl enable containerd
```

### step 3 Add apt repository for Kubernetes
Download the public signing key for the Kubernetes package repositories. The same signing key is used for all repositories, so you can disregard the version in the URL
```
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

Add Kubernetes apt repository. This repository have packages only for kubernetes 1.29; for other kubernetes minor versions, change the Kubernetes minor version in the URL.
```
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
`Note:` replaces the version v1.29 with new higher version if available.

### Step 4 Install Kubectl, kubeadm and kubelet
Update the `apt` package index, install kubernetes components kubectl,kubelet and kubeadm on all the nodes, and pin their version:
```
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
### Step 5 Install Kubernetes Cluster
Run following kubeadm on the master node
```
sudo kubeadm init --control-plane-endpoint=ekl-k8s-master-1.ponyworld.io 
# ? --pod-network-cidr=192.168.0.0/16
```

To start interacting with cluster, run following commands on master node
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Run following kubectl command to view cluster and node status
```
kubectl cluster-info
kubectl get nodes
kubectl get componentstatuses
```

### Step 6 Install Calico Network Plugin
A network plugin is responsible for communication between pods in the cluster
- Install with operator
```
#Install Tigera Calico operator 
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/tigera-operator.yaml

#Download the custom resources necessary to configure Calico.
curl https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/custom-resources.yaml -O

#Create the manifest in order to install Calico
kubectl create -f custom-resources.yaml

#Verify Calico installation in your cluster
watch kubectl get pods -n calico-system
```

- Install directly with Manifest
```
#Download the Calico networking manifest for the Kubernetes API datastore
curl https://raw.githubusercontent.com/projectcalico/calico/v3.27.2/manifests/calico.yaml -O

#Apply the manifest using the following command.
kubectl apply -f calico.yaml

#Verify the status of pods in kube-system namespace
watch kubectl get pods -n kube-system
```

Check the nodes status 
```
kubectl get nodes
```

### Step 7 Join worker nodes to the cluster
On each worker node, use kubeadm join command to add worker node
```
sudo kubeadm join ekl-k8s-master-1.ponyworld.io:6443 --token <token> \
--discovery-token-ca-cert-hash sha256:<token-hash>

# Check the nodes status from master node using kubectl command
kubectl get nodes
```
`Note:` The generated token is expired after 24 hours. To generate a new token with following command,
```
//list the current token which has been generated with "kubeadm init"
kubeadm token list

//create a new token
kubeadm token create
```

`Note:` The token ___discovery-token-ca-cert-hash___ can be read with following command,
```
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
  openssl dgst -sha256 -hex | sed 's/^.* //' 
```
`Note:` If the worker node has ever been added, reset the worker node firstly with
```
sudo kubeadm reset
``` 
#### Step 8 Test your kubernetes cluster installation
Try to deploy nginx based application and try to access it
```
kubectl create deployment nginx-app --image=nginx --replicas=2
```

Check the status of nginx-app deployment
```
kubectl get deployment nginx-app
```

Expose the deployment as NodePort,
```
kubectl expose deployment nginx-app --type=NodePort --port=80
```

Run following commands to iew service status
```
kubectl get svc nginx-app
kubectl describe svc nginx-app
```

Use following curl command to access nginx based application
```
curl http://<worker-node-ip-address>:31246
```
### Appendix
#### Uninstall old versions of containerd
```
for pkg containerd runc; do sudo apt remove $pkg; done
```

#### Delete a worker node
```
# safely evict pods of the node
kubectl drain --ignore-daemonsets ekl-k8s-worker-1.ponyworld.io

# delete the node
kubectl delete node ekl-k8s-worker-1.ponyworld.io
```
#### Links
`How to Install Kubernetes Cluster on Ubuntu 22.04` </br>
https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/?unapproved=53072&moderation-hash=e2092ea8dd88b10870083b1ae3784777#comment-53072

`Home page Calico` </br>
https://www.tigera.io/project-calico/