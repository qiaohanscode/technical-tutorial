## OAuth 2.1
OAuth 2.1 is at Jan. 6th 2025 an in-progress effort to consolidate and simplify OAuth 2.0. Details are 
available under [OAuth 2.1](https://oauth.net/2.1/).

### Major differences From OAuth 2.0
- `PKCE` is required for all OAuth clients using authorization code flow.
- Redirect URIs must be compared using exact string matching
- Implicit grant (```response_type=token```) is omitted
- `Resource Owner Password Credentials grant` is omitted
- Bearer token usage omits the use of bearer tokens in the query string of URIs
- Refresh tokens for public clients must either be sender-constrained or one-time use
- The definition of public and confidential clients have been simplified to whether the client has
  credentials 