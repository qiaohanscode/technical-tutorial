
### Install NFS Server On Ubuntun 20.4
### Install Nfs Server
#### Install nfs-kernel-server
```
sudo apt install nfs-kernel-server
```

#### Create The Folder To Be Shared
```
sudo mkdir -p /etc/opt/ekl-k8s/data
sudo chmod go+w /etc/opt/ekl-k8s/data
```

#### Add Shared Folder To /etc/exports
```
sudo vim /etc/exports

# Add follwing row
/var/opt/ekl-k8s/data/dev *.ponyworld.io(rw,no_subtree_check,no_root_squash)
```

#### Reexport All Directories With Synchronizing
```
exportfs -ar
```

#### Restart Nfs Server
```
sudo systemctl restart nfs-kernel-server
```

#### Check Status Of Nfs Server
```
sudo systemctl status nfs-server.service
```

### Install Nfs Client
#### Install nfs-common 
```
# On ekl-k8s-worker-1, ekl-k8s-worker-2 & ekl-k8s-worker-3
sudo apt install nfs-common
```
#### Check Mount Shared Folder
```
mkdir -p ekl-k8s-data/dev
sudo mount ekl-nfs.ponyworld.io:/var/opt/ekl-k8s/data/dev ekl-k8s-data/dev 
```

#### Unmount Shared Folder
```
# force and lazy unmount 
sudo umount -f -l ekl-k8s-data/dev
```
