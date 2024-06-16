### Kustomize Usage
#### Transformers
Below is the common transformers,
1. `commonLabels` -- it adds a label to all `Kubernetes` resources
2. `namePrefix` -- adds a common prefix to all resources
3. `nameSuffix` -- adds a common suffix to all resources
4. `namespace` -- adds a common namespace to all resources

#### Image Transformer
```
images:
- name: nginx
  newName: ekl-backend-ws-dev
  newTag: 20240612T124535
```

#### Patches (Overlay)
Patches or overlays provides another method to modify `Kubernetes` configurations. There are three parameters we need 
to provide,
1. `Operation Type: ` add or remove or replace
2. `Target:` Resource name which we want to modify
3. `Value:` Value name that will either be added or replaced. For the remove operation type, there would not be any 
value.

There are two ways to define the patches
1. JSON 6902
2. Strategic Merge Patching

By ___JSON 6902 Patching___, there are two details we need to provide, the target and the patch details i.e. operation,
path, and the new value.

```

patches:
  - target:
      kind: Deployment
      name: web-deployment
    patch: |-
      - op: replace
        path: /spec/replicas
        value: 5
```

By ___Strategic Merge Patching___ 
By this way, all the patch details are similar to standard k8s configuration.

```
  - patch: |-
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: web-deployment
      spec:
        replicas: 5
```

#### Patch From File
For both types of patching, instead of inline configurations, we can use separate file method. Specify all the patch 
details in a YAML file and refer it in the `kustomization.yaml` under the patches directive.
```
patches:
- path: replicas.yaml
```

And the patch can be specified in `replicas.yaml`
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
spec:
  replicas: 5
```