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