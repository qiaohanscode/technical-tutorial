## Volumes
- Storage that doesn't depend on pod `pod lifecycle`
- Storage muss be available on all nodes
- Storage nneds to survive even if cluster crashes

### Persistent Volumen
- a cluster resource
- create via YAML file
  - kind: PersistentVolume
  - spec: e.g. how much storage
- needs actual physical storage, like local disk, nfs server, cloud-storage (s3)
- who makes it available in the cluster
- external plugin to your k8s cluster
- depending on storage type, spec attributes differ
- details in kubernetes documentations
- available to all namespaces
- K8s Admin set up PV and K8s user creates PersistentVolumeClaim(pvc)

PV is external volume, while ConfigMap and Secret are local volume
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimNamme: pvc-name
```

### ConfigMap and Secret
- local volume
- namespaced
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: busybox-container
      image: busybox
      volumeMounts:
        - name: config-dir
          mountPath: /etc/config
  volumes:
    - name: config-dir
      configMap:
        name: bb-configmap
```

### Different volume types in one pod
```
apiVersion: v1
kind: Deployment
metadata:
  name: elastic
spec:
  selector:
    matchLabels:
      app: elastic
    template:
      metadata:
        labels:
          app: elastic
      spec:
        containers:
        - image: elastic:latest
          name: elastic-container
          ports:
          - containerPort: 9200
          volumeMounts:
          - name: es-persistent-storage
            mountPath: /var/lib/data
          - name: es-secret-dir
            mountPath: /var/lib/secret
          -name: es-config-dir
            mountPath: /var/lib/config
        volumes:
        - name: es-persistent-storage
          persistentVolumeClaim:
            claimName: es-pv-claim
        - name: es-secret-dit
          secret:
            secretName: es-secret
        - name: es-config-dir
          configMap:
            name: es-config-map   
```