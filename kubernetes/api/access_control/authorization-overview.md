Kubernetes authorizes API requests using the API server. It evaluates all of the request attributes against all policies
and allows or denies the request.

### Request Attributes
Kubernetes reviews only the following API request attributes:
- user
- group
- extra
- API
- Request path - /api or /healthz
- API request verb -- `get`, `list`, `create`, `update`, `patch`, `watch`, `delete`, and `deletecollection`
- HTTP request vert -- `get`, `post`, `put` and `delete`
- Resource
- Subresource
- Namespace
- API group

### Authorization Modes
- Node
- ABAC
- RBAC
- Webhook