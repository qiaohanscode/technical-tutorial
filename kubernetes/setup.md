## Step 1 -- Install Container Runtime
Each Node in the cluster, where the Pods will run, needs to install container runtime, which conforms with container runtime interface (cri)
### Install Docker Engine
- uninstall older versions
```
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

```
- install using rpm repository
  - Set up repository
    ```
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    ```
  - install latest version of docker engine
     ```
    sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    ```
- start docker
```
sudo systemctl start docker
```
- verify docker engine installtion
```
sudo docker run hello-world
```
### Install cri-dockerd
- download the rpm package from github
```
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.7/cri-dockerd-0.3.7.20231027185657.170103f2-0.el7.x86_64.rpm
```
- install rpm package
```
sudo dnf install cri-dockerd-0.3.7.20231027185657.170103f2-0.el7.x86_64.rpm
```
## Step 2 -- Configure Kubernetes Node on Linux
`Kubeadm` needs to be installed on each node in the cluster.
### Forwarding IPv4 and letting iptables see bridged traffic
- execute the below instructions:
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
```
- Verify ``br_netfilter``,``overlay``modules are loaded
```
lsmod | grep br_netfilter
lsmod | grep overlay
```
- verify following system variables are set to ``1`` in your sysctl config
```
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward
```
## Step 3 -- Configure cgroup drivers
On Linux, control groups (cgroup) are used to constrain resources that are allocated to processes. Both kubelet and underlying container runtime need to interface with control groups. The kubelet and container runtime need to use a ``cgroup driver`` to interface with control groups. It's critical/important that kubelet and container runtime are configured to use the same ``cgroup driver``.
There are two cgroup drivers available:
- cgrougfs -- control group driver file system
- systemd

`Note:` it is recommended to set `systemd` as the `cgroup driver` for kubelet and container runtime. To set ``systemd``as the cgroup driver, edit ``KubeletConfiguration``option of ``cgroupDriver``and set it to ``systemd``.
```
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
...
cgroupDriver: systemd
```
`Note:` Starting with v1.22 and later, when creating a cluster with kubeadm, if the user does not set the `cgroupDriver`field under `KubeletConfiguration`, kubeadm defaults it to `systemd`.

`Note:` In Kubernetes v1.28, with `KubeletCgroupDriverFromCRI` feature gate enabled and a container runtime that supports the `RuntimeConfig`CRI RPC, the Kubelet automatically detects the appropriate cgroup driver from the runtime, and ignores the `cgroupDriver`setting within the kubelet configuration.
`Caution:` Changing the cgroup driver of a Node that has joined a cluster is a sensitive operation.

## Step 4 Install kubeadm, kubelet and kubectl
- set SELinux to `permissive` mode
  ```
  # Set SELinux in permissive mode (effectively disabling it)
  sudo setenforce 0
  sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
  ```
- add the Kubernetes yum repository.
  ```
  # This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
  [kubernetes]
  name=Kubernetes
  baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
  enabled=1
  gpgcheck=1
  gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
  exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
  EOF
  ```
- Install kubelet, kubeadm and kubectl
  ```
  sudo dnf install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
  ```
- enable kubelet to ensure it as automatically started on startup
  ```
  sudo systemctl enable --now kubelet
  ```
  ## Create Cluster with kubeadm
- Initializing control-plane node
```
sudo kubeadm init --config kubeadm_init_config.yaml
or
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
or
sudo kubeadm join
```
- document of kubeadm https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
- document of kubeadm --config https://kubernetes.io/docs/reference/config-api/kubeadm-config.v1beta3/
- `Troubleshooting`
- [WARNING Firewalld]: firewalld is active, please ensure ports [6443 10250] are open or your cluster may not function correctly
```
# stop firewalld
sudo systemctl stop firewalld

# disable firewalld permanently
systemctl disable firewalld

# enable firewalld permanently
systemctl enable firewalld

# open ports for kubeadm, Enter the following commands on the Master Node:
$ sudo firewall-cmd --permanent --add-port=6443/tcp
$ sudo firewall-cmd --permanent --add-port=2379-2380/tcp
$ sudo firewall-cmd --permanent --add-port=10250/tcp
$ sudo firewall-cmd --permanent --add-port=10251/tcp
$ sudo firewall-cmd --permanent --add-port=10252/tcp
$ sudo firewall-cmd --permanent --add-port=10255/tcp
$ sudo firewall-cmd –reload

#Enter the following commands on each worker node:
$ sudo firewall-cmd --permanent --add-port=10251/tcp
$ sudo firewall-cmd --permanent --add-port=10255/tcp
$ firewall-cmd --reload

sudo systemctl status firewalld
sudo firewall-cmd --list-all
```
- WARNING Swap]: swap is enabled
```
# visualize your degree of memory load before actually disabling swap space, If 0B or close to 0 bytes is the size used, it can be assumed that swap space is not used 
free -h
# check the swap partition by checking for TYPE="swap" line
blkid  
lsblk

# permanently disable swap on fedora server 38
sudo dnf remove zram-generator-defaults

```
- [WARNING FileExisting-tc]: tc not found in system path
```
# install command tc on fedora
sudo dnf install -y iproute-tc
```
- [WARNING Service-Kubelet]: kubelet service is not enabled, please run 
```
systemctl enable kubelet.service
```

- [ERROR CRI]: container runtime is not running 
```
rm /etc/containerd/config.toml
systemctl restart containerd
sudo kubeadm init --apiserver-advertise-address=192.168.178.64
```
`Note` for high availability specify `--control-plane-endpoint` to set the shared endpoint for all `control-plane` nodes. Such an endpoint can be either a DNS name or an IP Address of a load-balancer. Here is an example mapping:
```
192.168.0.102 cluster-endpoint
```
Where `192.168.0.102` is the IP address of this node and `cluster-endpoint` is a custom DNS name that maps to this IP. This allows you to pass `--control-plane-endpoint=cluster-endpoint`to `kubeadm init` and the same DNS name to `kubeadm join`. Later you can modify `cluster-endpoint`to point to the address of your load-balancer in a high availability scenario.  

## kubeadm token list -- show token
```
kubeadm token list
```
Tokens expire by default after 24 hours. Create a new token with the following command,
```
kubeadm token create
```
To get the value of `--discovery-token-ca-cert-hash`, run the following command,
```
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
  openssl dgst -sha256 -hex | sed 's/^.* //' 
```
## Deploy a pod network addon
```
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
# https://kubernetes.io/docs/concepts/cluster-administration/addons/

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/tigera-operator.yaml

kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/custom-resources.yaml

watch kubectl get pods -n calico-system
```
`Note` it is only allowd to install one Pod network per cluster. Once the `CoreDNS` Pod (cluster DNS) is up and running, further nodes can be joined.
`Note` To provide higher availability, you need to rebalance the CoreDNS Pods with the following command after at least one new node is joined.
```
kubectl -n kube-system rollout restart deployment coredns
```
`Troubleshooting`
- links: https://medium.com/@texasdave2/troubleshoot-kubectl-connection-refused-6f5445a396ed

- check the cluster info on the master node
```
kubectl cluster-info
kubectl config view
journalctl -xe
```
- check your component status
```
kubectl get componentstatuses
```
- check your ports to see what’s listening
```
sudo netstat -lnpt|grep kube
## check your kube-apiserver at 6443 see if it's listening
netstat -a | grep 6443
```
- restart the kubelet on the MASTER node!!!?!?. This is semi catastrophic actually, however, check this response out:
```
### do not do this on a dev or production install, ONLY try this on a sandbox install, and be ready to reinstall if this goes south

sudo systemctl stop kubelet
kubectl get pods
##response:
The connection to the server localhost:8080 was refused - did you specify the right host or port?
Now... you can try all kinds of things, but the one that might actually work immediately is this:
sudo systemctl start kubelet
## then issue these commands:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get pods
```
- restart kubelet
```
systemctl daemon-reload
systemctl restart kubelet
```
## Install Calico on multi host on premise
### configure NetworkManager
- create the following configuration file at `/etc/Networkmanager/conf.d/calico.conf`to prevent NetworkManager from interfering with the interfaces
```
[keyfile]
unmanaged-devices=interface-name:cali*;interface-name:tunl*;interface-name:vxlan.calico;interface-name:vxlan-v6.calico;interface-name:wireguard.cali;interface-name:wg-v6.cali
```
- install the operator on your cluster
```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/tigera-operator.yaml
```

## Install Flannel
- remove old cni configuration
```
sudo rm -vR /etc/cni/net.d
```
- download cni plugin
```
mkdir -p /opt/cni/bin
curl -O -L https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz
tar -C /opt/cni/bin -xzf cni-plugins-linux-amd64-v1.3.0.tgz
```
- deploy Flannel in kubernetes
````
curl -O -L https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
kubectl apply -f kube-flannel.yml
````

## Clean up
To deprovision the cluster cleanly, the following steps need to be executed

### Remove the node
```
kubectl drain <node name> --delete-emptydir-data --force --ignore-daemonsets
```
Before removing the node, reset the state installed by `kubeadm`
```
kubeadm reset
```

Now remove the node
```
kubectl delete node <node name>
```
## Clean up the control plane/ re-configure a kubernetes cluster
```
sudo kubeadm reset
```










