### Security Assertion Markup Language (SAML)
SAML (SAML 2.0 since 2005) is an authentication and authorization standard. SAML is an XML variant for exchanging security information. There are two types of SAML SSO:
- Identity Provider (IdP) initiated SAML SSO: The user atempts to log into an IdP, and the Idp can directly verify the user's identity with a SAML response.
- Service Provider (SP) initiated SAML SSO: The user attempts to log into a SP, and the SP must generate a SAML request. The request and user are sent to an IdP for authentication, and then back to the SP to complete the log in.

### Open Authorization (OAuth)
OAuth (OAuth 2.0 since 2013) is an authentiication standard that allows a resource owner logged-in to one system to delegate limited access to protected information to a third party without sharing the owner's security credentials. A typical OAuth workflow is based on interactions among four roles:
- Resource owner: grants access to protected resources
- Resource Server: hosts protected resources and responds to access requests
- Client: an application that submits access requests on behalf of the resource owner
- Authorization server: issues access tokens to the client after successfully authenticating the resource owner and obtaining authorization.

