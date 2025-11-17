#!/bin/bash

echo "Kubernetes Upgrade Script (1.31 -> 1.32)"

read -p "Enter k8s path version (e.g. v1.32): " K8S_PATH_VERSION
read -p "Enter kubeadm version (e.g. 1.32.10-1.1): " KUBEADM_VERSION
read -p "Enter kubelet/kubectl version (e.g. 1.32.10-1.1): " KUBELET_VERSION
read -p "Enter Kubernetes version (e.g. v1.32.10): " K8S_VERSION

ask() {
    read -p "$1 [y/N]: " yn
    case "$yn" in
        [Yy]*) return 0 ;;
        *) return 1 ;;
    esac
}
echo "curl -fsSL https://pkgs.k8s.io/core:/stable:/${K8S_PATH_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg"
if ask "Download the public signing key for k8s package repositories?"; then
    curl -fsSL https://pkgs.k8s.io/core:/stable:/${K8S_PATH_VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
fi

echo "echo \"deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_PATH_VERSION}/deb/ /\" | sudo tee /etc/apt/sources.list.d/kubernetes.list"
if ask "Add the appropriate k8s apt repository?"; then
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_PATH_VERSION}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
fi

echo "sudo apt update"
echo "sudo apt-cache madison kubeadm"
if ask "Update apt package index?"; then
    sudo apt update
    sudo apt-cache madison kubeadm
fi

echo "sudo apt-mark unhold kubeadm"
echo "sudo apt-get update && sudo apt-get install -y kubeadm=\"$KUBEADM_VERSION\""
echo "sudo apt-mark hold kubeadm"
if ask "Upgrade kubeadm to $KUBEADM_VERSION?"; then
    sudo apt-mark unhold kubeadm
    sudo apt-get update && sudo apt-get install -y kubeadm="$KUBEADM_VERSION"
    sudo apt-mark hold kubeadm
fi

echo "kubeadm version"
if ask "Verify kubeadm version?"; then
    kubeadm version
fi

echo "sudo kubeadm upgrade plan"
if ask "Verify the upgrade plan?"; then
    sudo kubeadm upgrade plan
fi

echo "sudo kubeadm upgrade apply \"$K8S_VERSION\""
if ask "Start the upgrade (control plane node)?"; then
    sudo kubeadm upgrade apply "$K8S_VERSION"
fi

echo "sudo kubeadm upgrade node"
if ask "Upgrade other control plane/worker nodes?"; then
    sudo kubeadm upgrade node
fi

echo "kubectl drain ekl-k8s-master-1.ponyworld.io --ignore-daemonsets"
if ask "Drain ekl-k8s-master-1?"; then
    kubectl drain ekl-k8s-master-1.ponyworld.io --ignore-daemonsets
fi

echo "kubectl drain ekl-k8s-worker-1.ponyworld.io --ignore-daemonsets"
if ask "Drain ekl-k8s-worker-1?"; then
    kubectl drain ekl-k8s-worker-1.ponyworld.io --ignore-daemonsets
fi

echo "kubectl drain ekl-k8s-worker-2.ponyworld.io --ignore-daemonsets"
if ask "Drain ekl-k8s-worker-2?"; then
    kubectl drain ekl-k8s-worker-2.ponyworld.io --ignore-daemonsets
fi

echo "sudo apt-mark unhold kubelet kubectl"
echo "sudo apt-get update && sudo apt-get install -y kubelet=\"$KUBELET_VERSION\" kubectl=\"$KUBELET_VERSION\""
echo "sudo apt-mark hold kubelet kubectl"
if ask "Upgrade kubelet and kubectl to $KUBELET_VERSION?"; then
    sudo apt-mark unhold kubelet kubectl
    sudo apt-get update && sudo apt-get install -y kubelet="$KUBELET_VERSION" kubectl="$KUBELET_VERSION"
    sudo apt-mark hold kubelet kubectl
fi

echo "sudo systemctl daemon-reload"
echo "sudo systemctl restart kubelet"
if ask "Restart kubelet?"; then
    sudo systemctl daemon-reload
    sudo systemctl restart kubelet
fi

echo "kubectl uncordon ekl-k8s-master-1.ponyworld.io"
if ask "Uncordon ekl-k8s-master-1?"; then
    kubectl uncordon ekl-k8s-master-1.ponyworld.io
fi

echo "kubectl uncordon ekl-k8s-worker-1.ponyworld.io"
if ask "Uncordon ekl-k8s-worker-1?"; then
    kubectl uncordon ekl-k8s-worker-1.ponyworld.io
fi

echo "kubectl uncordon ekl-k8s-worker-2.ponyworld.io"
if ask "Uncordon ekl-k8s-worker-2?"; then
    kubectl uncordon ekl-k8s-worker-2.ponyworld.io
fi

echo "kubectl get nodes -o wide"
if ask "Check status of cluster nodes?"; then
    kubectl get nodes -o wide
fi
