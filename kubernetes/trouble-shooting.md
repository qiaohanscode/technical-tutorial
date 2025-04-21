#### Finding Logs in /var/log/containers/ and /var/log/pods/

#### systemd
```
journalctl -u kubelet
```
#### Api Server certifikate expires
```
# 1 - check whether certificate of api server is expired
openssl s_client -connect ekl-k8s-master-1.ponyworld.io:6443

# 2 - check certificate with kubeadm
sudo kubeadm certs check-expiration
 
# 3 -renew the certificate
sudo kubeadm certs renew all

# 4 - Kubelet & API-Server restart
sudo systemctl restart kubelet

# 5 - copy admin.conf to kubeconfig
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config
```


#### Appendix
https://www.baeldung.com/ops/kubelet-logs-location