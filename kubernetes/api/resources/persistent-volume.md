### Persistent Volume (PV) 

PV is  a piece of storage in the cluster that has been provisioned by an administrator 
or dynamically provisioned using [Storage Classes](./storage-class.md). The lifecycle of a PV
is independent of Pods that uses the PV.

### Persistent Volume Claim (PVC)

A PVC is a request for storage by a user. It is similar to a Pod. Pods consume node resources
and PVCs consume PV resources. Pods can request specific levels of resources (CPU and Memory).
Claims can request specific size and access modes (e.g., ReadWriteOnce, ReadOnlyMany
, ReadWriteMany or ReadWriteOncePod).

### Lifecycle of a volume and claim

#### Provisioning
- Static -- A cluster administrator creates a number of PVs. They exist in the Kubernetes API
    and are available for consumption 
- Dynamic -- when none of the static PVs the administrator created match a user's PVC, the cluster
  may try to dynamically provision a volume specially for the PVC. This provisioning is based
  on StorageClasses: the PVC must request a [storage class](./storage-class.md) and the 
  administrator must have created and configured that class for dynamic provisioning to 
  occur. Claims that request the class `""` effectively disable dynamic provisioning for
  themselves. To enable dynamic storage provisioning based on storage class, the cluster 
  administrator needs to enable the `DefaultStorageClass` admission controller on the 
  API server. This can be done by adding `DefaultStorageClass` to the values 
  (comma separated) for the flag `--enable-admission-plugins` of the API server component.

#### Binding
A user creates a PVC with a specific amount of storage requested and with certain access
modes. A control loop in the control plane watches for new PVCs, finds a matching PV 
(if possible), and binds them together. Once bound, PVC binds are exclusive. A PVC to 
PV binding is a one-to-one mapping, using a `ClaimRef` makes a bi-directional binding 
between the PV and PVC.

Claims will remain unbound indefinitely if a matching volume does not exist. Claims 
will be bound as matching volumes become available.

#### Using
Pods use claims as volumes. The cluster inspects the claim to find the bound volume and
mounts that volume for a Pod. Once a user has a claim and that claim is bound, the bound PV
belongs to the user for as long as they need it. Users schedule Pods and access their claimed
PVs by including a `persistentVolumeClaim` section in a Pod's `volumes` block.

#### Storage Object in Use Protection
If a user deletes a PVC in active use by a Pod, the PVC removal is postponed until the 
PVC is no longer actively used by any Pods. Also, if an admin deletes a PV that is bound
to a PVC, the PV removal is postponed until te PV is no longer bound to a PVC.

You can see that a PVC is protected when the PVC's status is `Terminating` and the 
`Finalizers` list includes `kubernetes.io/pvc-protection`.

#### Reclaiming
When a user is done with their volume, they can delete the PVC objects from the API that 
allows reclamation of the resource. The possible reclaim policy are Retained, Recycled 
or Deleted.
- Retain -- allows for manual reclamation of the resource. When PVC is deleted, the PV 
  still exists and the volume is considered "released". An admin needs manually reclaim 
  the volume before another claim can use the volume. 
- Delete -- deletion removes both the OV object from Kubernetes, as well as the associated
  storage asset in the external infrastructure.
- Recycled -- deprecated


### PersistentVolume Deletion Protection Finalizer
Finalizers can be added on a PV to ensure that PV having `Delete` reclaim policy are deleted
only after the backing storage are deleted.

The available finalizers are:
- kubernetes.io/pv-controller -- is added to in-tree plugin volumes.
- external-provisioner.volume.kubernetes.io/finalizer -- is added for CSI volumes.

The finalizers are only added to dynamically provisioned volumes. 

### Types Of Persistent Volumes
PV types are implemented as plugins. Kubernetes currently supports the following plugins:
- csi -- Container Storage Interface
- fc
- hostPath -- only for single node
- iscsi -- SCSI over IP (iSCSI) storage
- local -- local storage devices mounted on nodes
- nfs -- Network File System (NFS) storage

### Persistent Volumes
#### Volume Mode
Kubernetes supports two `volumeModes` of PV:
- Filesystem -- is mounted into Pods into a directory.
- Block -- let a volume to be used as a raw block device without any filesystem on it.


#### Class
A PV can have a class, which is specified by setting the `storageClassName` attribute 
to the name of a StorageClass. A PV of a particular class can only be bound to PVCs 
requesting that class. A PV without `storageClassname` has no class and can only be
bound to PVCs that request no particular class.

#### Phase
A PV will be in one of the following phases:
- Available
- Bound
- Released
- Failed

### Persistent Volume Claims
#### Class
A claim can request a particular class by specifying `storageClassName`. Only PVs 
of the requested class, ones with the same `storageClassName` as the PVC, can be
bound to the PVC.

PVCs don't necessarily have to request a class. A PVC with its `storageClassName` 
set to `""` is always interpreted to be requesting a PV with no class (no annotation 
or one set equal to `""`). A PVC without `storageClassName` is treated differently 
by the cluster, depending on whether `DefaultStorageClass admission plugin` is turned on.
- If admission plugin is turned on, the administrator may specify a default 
  `StorageClass`. All PVCs that have no `storageClassName` can be bound only to PVs 
  of that default. Specifying a default StorageClass is done by setting the annotation
  `storageclass.kubernetes.io/is-default-class` to `true` in a StorageClass object. If
  the administrator does not specify a default, the cluster responds to PVC creation
  as if the admission plugin were turned off. If more than one default StorageClass 
  is specified, the newest default is used.
- If the admission plugin is turned off, there is no default StorageClass. All PVCs that
  have `storageClassName` set to `""` can be bound only to PVs that have `storageClassName`
  also set to `""`.

When a default StorageClass becomes available, the control plane identifies any existing
PVCs without `storageClassName`. For the PVCs that either have an empty value for 
`storageClassName` or do not have this key, the control plane then updates those PVCs to 
set `storageClassName` to match the new default StorageClass. An existing PVC with 
`storageClassName` set to `""` will not be updated.

#### Claims As Volumes
Pods access storage by using the claim as a volume. A Claim is namespaced and needs to 
be in the same namespace as the Pods, which are using the claims. 

#### Raw Block Volume Support
The following volume plugins support raw block volumes,
- CSI
- Local volume
- FC (Fibre Channel)
- iSCSI
- ...
