`API Server` is responsible for authenticate the requests.

### Users in Kubernetes
All Kubernetes clusters have two categories of  users:
- `service accounts` -- are users managed by the Kubernetes API, have the following features:
  - are bound to specific namespaces
  - created automatically by API server or manually through API calls
  - are tied to a set of credentials stored as `Secrets` which are mounted into pods allowing in-cluster processes to
    talk to Kubernetes API.
- `normal users` -- Kubernetes does not have objects which represent normal user accounts. But any user that presents a valid certificate 
signed by the cluster's certificate authority (CA) is considered authenticated. According to the common name (CN) of the
certificate the role based access control (RBAC) sub-system determines whether the user is authorized for a specific 
operation on a resource.

`Note: API requests are tied to either a normal user or a service account, or are treated as anonymous requests.`

### Authentication strategies
- client certificate
- bearer tokens
- authenticating proxy

### Authentication protocols
The following authentication protocols can be accomplished using an `authenticating proxy` or `authentication webhook`,
- LDAP
- SAML
- Kerberos
- alternate x509 schemes

Not finished.