### Kustomize

`kustomize` is a tool for customizing `kubernetes` configuration. `kustomize` lets you customize raw, template-free YAML,
leaving the original YAML file untouched and usable as it. `kustomize` targets `kubenetes` and is also embedded 
into `kubectl` (command kustomize).

To find the `kustomize` version, run 
```
kubectl version --short --client
```

```
# Build the kustomize resources in the current working directory
kubectl kustomize
```

`kustomize` has following features to manage application configuration files,
- generating resources from another resources
- setting cross-cutting fields for resources
- composing and customizing collections of resources

### Setting Cross-Cutting Fields
It is quite common to set cross-cutting fields for all `kubernetes` resources of a project. Some use cases are,
```
- setting the same namespace for all resources
- adding the same name prefix or suffix
- adding the same set of labels
```

### Composing and Customizing Resources
It is common to compose a set of Resources in a project and manage them in the same file or a directory. `kustomize` offers
composing resources from different files and applying patches or other customization to them.

#### Composing
`kustomize` supports composition of different resources. The field `resources` in the `kustomization.yaml` file defines
the list of resources to include in a configuration.
```
# Create a kustomization.yaml composing them
cat <<EOF >./kustomization.yaml
resources:
- deployment.yaml
- service.yaml
EOF
```

#### Customizing
Patches can be used to apply different customizations to resources. `kustomize` supports different patching mechanisms,
- patchesStrategicMerge
- patchesJson6902

___patchesStrategicMerge___ is a list file paths. Each file should be resolved to a strategic merge patch. Small patches
that do one thing is recommended.
```
# Create a patch increase_replicas.yaml
cat <<EOF > increase_replicas.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
spec:
  replicas: 3
EOF

# Create another patch set_memory.yaml
cat <<EOF > set_memory.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-nginx
spec:
  template:
    spec:
      containers:
      - name: my-nginx
        resources:
          limits:
            memory: 512Mi
EOF

cat <<EOF >./kustomization.yaml
resources:
- deployment.yaml
patchesStrategicMerge:
- increase_replicas.yaml
- set_memory.yaml
EOF
```

```
# View the Deployment
kubectl kustomize ./
```

### Bases and Overlays
`kustomize` has the concepts of ___base___ and ___overlay___.

A ___base___ is a directory with a `kustomization.yaml` and a set of resources.

An ___overlay___ is a directory with a `kustomization.yaml` that refers to other kustomization directories as its ___base___.

A ___base___ has no knowledge of an ___overlay___ and can be used in multiple overlays. An ___overlay___ may have 
multiple bases and it composes all resources from the bases may have customization on top of them.

```
mkdir dev
cat <<EOF > dev/kustomization.yaml
resources:
- ../base
namePrefix: dev-
EOF

mkdir prod
cat <<EOF > prod/kustomization.yaml
resources:
- ../base
namePrefix: prod-
EOF
```

### How To apply/delete/view Objects Using kustomize
Use `--kustomize` or `-k` in `kubectl` command to recognize resources managed by `kustomization.yaml`.


#### Apply The Object
```
kubectl apply -k <kusomization directory>
```

#### View The Object
```
# view the Deployment objec
kubectl get -k ./

or

kubectl describe -k ./
```

#### Compare The Current Object with The State After Customization
```
# compare the Deployment object against the state that the cluster would be in if the manifest was applied
kubectl diff -k ./
```

#### Delete The Object
```
# delete the Deployment object
kubectl delete -k ./
```
### Kustomize Feature List
A complete list of build-in fields of `kustomize` can be found [Kustomize Feature List](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/#kustomize-feature-list). 

### Appendix A -- useful links
https://github.com/kubernetes-sigs/kustomize

https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/