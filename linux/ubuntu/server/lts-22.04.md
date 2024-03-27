### Expand unallocated disk space
By default, the Ubuntu installation doesn't allocate all the disk space. To allocate unused disk space, run following 
commands,
```
// check Free PE/Size available for expansion
sudo vgdisplay

//check the size of the loical volumen
sudo lvdisplay

//grow the size of logical volume with all available free space
sudo lvresize -l +100%FREE /dev/ubuntu-vg/ubuntu-lv

//confirm that the logical volume has been expanded
sudo lvdisplay

//check type of the filesystem
df -TH

//grow the filesystem of ext4
sudo resize2fs /dev/ubuntu-vg/ubuntu-lv

//check free disk space
df -h --total
```

### update
```
// update the reposotory
sudo apt update

//sudo apt full-upgrade
```