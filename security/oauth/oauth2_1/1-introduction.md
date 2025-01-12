## OAuth 2.1
OAuth 2.1 is (Jan. 6th 2025) an in-progress effort to consolidate and simplify OAuth 2.0. 
Details are available under [OAuth 2.1](https://oauth.net/2.1/).

### Major differences From OAuth 2.0
- `PKCE` is required for all OAuth clients using authorization code flow.
- Redirect URIs must be compared using exact string matching
- Implicit grant (```response_type=token```) is omitted
- `Resource Owner Password Credentials grant` is omitted
- Bearer token usage omits the use of bearer tokens in the query string of URIs
- Refresh tokens for public clients must either be sender-constrained or one-time use
- The definition of public and confidential clients have been simplified to whether 
  the client has credentials 

### What's new in OAuth 2.1
The complete article is available under 
[What's new in OAuth 2.1](https://fusionauth.io/blog/whats-new-in-oauth-2-1).

OAuth 2.1 doesn't introduce any new features, it just consolidates the changes that
have been made over the past eight years. Many of the new draft specification details are
drawn from the [OAuth 2.0 Security Best Current Practices](https://tools.ietf.org/html/draft-ietf-oauth-security-topics-14).

#### Terms Of OAuth 2.1
- A `client` is a piece of code that the user is interacting with; browsers, native apps
  or singe-page applications are all clients
- An `OAuth server` implements OAuth specifications and has or can obtain information
  about which resources are available to clients. In the RFCs this is called an
  `Authorization Server`, but it is also known as an `Identity Provider`. Most users 
  call it "the place I log in".
- An `application server` doesn't have any authentication functionality but knows how
  to delegate to an OAuth Server. It has a client id which allows the OAuth server to
  identify it.


#### The Authorization Code Grant And PKCE
The authorization code grant is extended with the functionality from PKCE 
([RFC7636](https://tools.ietf.org/html/rfc7636)) such that the only method of using 
authorization code grant requires the addition of the PKCE mechanism.