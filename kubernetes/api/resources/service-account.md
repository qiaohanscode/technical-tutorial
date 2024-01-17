A service account is a type of non-human account that provides a distinct identity in a Kubernetes cluster. Service 
accounts exist as ServiceAccount objects in the API server. Service accounts have the following properties:
- Namespaced -- each service account is bound to a Kubernetes namespace. Every namespace gets a `default ServiceAccount`
- Lightweight 
- Portable -- A configuration bundle for a complex containerized workload might include service account definitions for
  the system's components.

### Default service accounts
- Kubernetes automatically creates a ServiceAccount object named `default` for very namespace in your cluster.
- The `default` service accounts in each namespace get by default no permissions other that the default API discovery
    permissions.
- If the `default` ServiceAccount object in a namespace has been deleted, the control plane replaces it with a new one

### Use cases for Service accounts
- A Pod needs to communicate with the Kubernetes API server, for example
  - providing read-only access to sensitive information stored in Secrets
  - Granting cross-namespace access
- A Pod need to communicate with an external service.
- Authenticating to a private image registry using an `imagePullSecret`
- An external service needs to communicate with Kubernetes API server.

### How to use service accounts
1. creat a ServiceAccount object
2. Grant permission to the ServiceAccount
3. Assign the ServiceAccount object to Pods during Pod creation by setting `spec.serviceAccountName` field in the Pod 
specification.

`Note: By default, Kubernetes provides the Pod with the credentials for an assigned ServiceAccount, whether that is the 
default ServiceAccount or a custom ServiceAccount that you specify.`