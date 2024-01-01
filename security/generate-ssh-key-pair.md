### generate ssh key pair with username
```
# generate public & private key, and exports the key pair to ~/.ssh/
ssh-keygen -C qiaohanscode
```

### copy public key to remote server
```
# copy the ssh key pair to the remote server
ssh-copy-id tim@ekl-k8s-master-1.fritz.box
```
