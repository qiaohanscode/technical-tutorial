## RBAC Authorization
Role-based access control (RBAC) is a method of regulating access to computer or network resources based on the roles of
individual users within your organization.

RBAC authorization uses the `rbac.authorization.k8s.io` API group to drive authorization decisions, allowing you to 
dynamically configure policies through the Kubernetes API.

### API Objects
`RBAC API` declares four kinds of Kubernetes object:
- Role
- ClusterRole
- RoleBinding
- ClusterRoleBinding

### Role and ClusterRole
A `Role` or `ClusterRole` contains rules that represent a set of permissions. To define a role within a namespace, 
use a `Role`. To define a role cluster-wide, use a `ClusterRole`.

A `Role` always sets permissions within a particular namespace. Namespace always needs to be specified by creating a `Role`.

`ClusterRole` is a non-namespaced resource and can be used to:
- define permissions on namespaced resources and be granted access within individual namespaces.
- define permissions on namespaced resources and be granted access across all namespaces
- define permissions on cluster-scoped resources

`Note: Kubernetes object always has to be either namespaced or not namespaced; it can't be both. So if you want to define
a role within a namespace, use a Role; if you want to define a role cluster-wide, use a ClusterRole`

### Role example
Role in the "default" namespace that can be used to grant read access to pods:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

### ClusterRole example
ClusterRole that can be used to grant read access to secrets in any particular namespace or across all namespaces 
(depending on how it is bound):

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  # "namespace" omitted since ClusterRoles are not namespaced
  name: secret-reader
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Secret
  # objects is "secrets"
  resources: ["secrets"]
  verbs: ["get", "watch", "list"]
```

### Rolebinding and ClusterRoleBinding
A role binding grants the permissions defined in a role to a user or set of users. It holds a list of subjects (users,
groups or service accounts) and a reference to the role being granted.
- A `Rolebinding` grants permissions within a specific namespace. A `Rolebinding` may reference any Role in the same 
    namespace, can also reference a `ClusterRole` and bind that `ClusterRole`to the namespace of the `Rolebinding`. This
    kind of reference lets you define a set of common roles across your cluster, then reuse them within multiple namespaces.

- A `ClusterRoleBinding` grants access cluster-wide. A `ClusterRoleBinding` can bind a `ClusterRole`to all the namespaces
  in your cluster. 

`Note:` After a binding has been created, the referenced `Role` or `ClusterRole` can not be changed anymore. 
The referenced `Role` or `ClusterRole` need to be removed at first and then replaced with a new `Role` 
or `ClusterRole`. The command `kubectl auth reconcile` helps to create or update a manifest file containing RBAC objects 
and handles deleting and recreating binding objects if changes for the reference roles are required.

### RoleBinding example
A RoleBinding grants the "pod-reader" Role to the user "jane" within the "default" namespace.

```
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
# You need to already have a Role named "pod-reader" in that namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
# You can specify more than one "subject"
- kind: User
  name: jane # "name" is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  # "roleRef" specifies the binding to a Role / ClusterRole
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```
### ClusterRoleBinding example
Allows any user in the group "manager" to read secrets in any namespace.
```
apiVersion: rbac.authorization.k8s.io/v1
# This cluster role binding allows anyone in the "manager" group to read secrets in any namespace.
kind: ClusterRoleBinding
metadata:
  name: read-secrets-global
subjects:
- kind: Group
  name: manager # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

### Referring to resources
In Kubernetes API, most resources are represented and accessed using a string representation of their object name such
as `pods` for a Pod. Some Kubernetes APIs involve a subresource, such as the logs for a Pod. A request for a Pod's logs 
looks like
```
GET /api/v1/namespaces/{namespace}/pods/{name}/log
```

`pods` is the namespaced resource, and `log` is a subresource of `pods`. To represent this in an RBAC role, use a 
slash (/) 

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-and-pod-logs-reader
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "list"]
```

### Wildcard `*` 
Use wildcard to refer any objects:
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  creationTimestamp: "2023-12-28T22:29:55Z"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: cluster-admin
  resourceVersion: "75"
  uid: 6de1de76-0f78-4be8-b60a-53188e4df9dc
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
- nonResourceURLs:
  - '*'
  verbs:
  - '*'
```

### Aggregated ClusterRoles
Several ClusterRoles can be aggregated into one combined ClusterRole. The `aggregationRule` defines a label selector
which used to match other ClusterRole objects. A controller, running as part of the cluster control plane, watches for 
ClusterRole objects with an `aggregationRule` set.

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: monitoring
aggregationRule:
  clusterRoleSelectors:
  - matchLabels:
      rbac.example.com/aggregate-to-monitoring: "true"
rules: [] # The control plane automatically fills in the rules
```

### Referring to subjects
A `RoleBinding` or `ClusterRoleBinding` binds a role to subjects. Subjects can be
- groups
- users
- ServiceAccounts

`ServiceAccounts` have names prefixed with `system:serviceaccount:`, and belong to groups that have names prefixed 
with `system:serviceaccounts`  

`Note:
- `system:serviceaccount:` (singular) is the prefix for service account usernames.
- `system:serviceaccounts:` (plural) is the prefix for service account groups.

### RoleBinding examples
For a group named `frontend-admins
`
```
subjects:
- kind: Group
  name: "frontend-admins"
  apiGroup: rbac.authorization.k8s.io
```

For the default service account in the "kube-system" namespace:
```
subjects:
- kind: ServiceAccount
  name: default
  namespace: kube-system
```

For all service accounts in the "qa" namespace:
```
subjects:
- kind: Group
  name: system:serviceaccounts:qa
  apiGroup: rbac.authorization.k8s.io
```

For all service accounts in any namespace:
```
subjects:
- kind: Group
  name: system:serviceaccounts
  apiGroup: rbac.authorization.k8s.io
```

### Default Roles and RoleBinding

```
Default ClusterRole         Default
                            ClusterRoleBinding
--------------------------------------------------------
system:basic-user           system:authenticated (group)
system:discovery            system:authenticated (group)
...
```

### User facing Roles
```
Default ClusterRole         Default
                            ClusterRoleBinding
--------------------------------------------------------
cluster-admin               system:masters (group)
admin                       None
edit                        None
view                        None
```

### Command-line utilities
```
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods

kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods

# Within the namespace "acme", grant the permissions in the "admin" ClusterRole to a user named "bob":
kubectl create rolebinding bob-admin-binding --clusterrole=admin --user=bob --namespace=acme

# Across the entire cluster, grant the permissions in the "cluster-admin" ClusterRole to a user named "root":
kubectl create clusterrolebinding root-cluster-admin-binding --clusterrole=cluster-admin --user=root
```
### ServiceAccount permissions
- Grant a role to an application-specific service account (best practice)
```
# grant read-only permission within "my-namespace" to the "my-sa" service account:
kubectl create rolebinding my-sa-view \
  --clusterrole=view \
  --serviceaccount=my-namespace:my-sa \
  --namespace=my-namespace
```

- Grant a role to all service accounts in a namespace
```
# grant read-only permission within "my-namespace" to all service accounts in that namespace
kubectl create rolebinding serviceaccounts-view \
  --clusterrole=view \
  --group=system:serviceaccounts:my-namespace \
  --namespace=my-namespace
```

- Grant a limited role to all service accounts cluster-wide (discouraged)
```
# grant read-only permission across all namespaces to all service accounts in the cluster
kubectl create clusterrolebinding serviceaccounts-view \
  --clusterrole=view \
 --group=system:serviceaccounts
```

### Appendix A -- Further Role examples
Allow reading Pods in the core API group, as well as reading or writing Job resources in the batch API group:
```
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing Pod
  # objects is "pods"
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["batch"]
  #
  # at the HTTP level, the name of the resource for accessing Job
  # objects is "jobs"
  resources: ["jobs"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

Allow reading a ConfigMap named "my-config" (must be bound with a RoleBinding to limit to a single ConfigMap in a single
namespace)

```
rules:
- apiGroups: [""]
  #
  # at the HTTP level, the name of the resource for accessing ConfigMap
  # objects is "configmaps"
  resources: ["configmaps"]
  resourceNames: ["my-config"]
  verbs: ["get"]
```

Allow GET and POST requests to the non-resource endpoint `/healthz` and all subpaths (must be in a ClusterRole bound 
with a ClusterRoleBinding to be effective):
```
rules:
- nonResourceURLs: ["/healthz", "/healthz/*"] # '*' in a nonResourceURL is a suffix glob match
  verbs: ["get", "post"]
```