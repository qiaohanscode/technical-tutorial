### @EnableWebSecurity 
add @EnableWebSecurity annotation which publishes SecurityFilterChain as a @Bean. SecurityFilterChain is used 
by FilterChainProxy to determine which Spring Security Filter instances should be invoked for the current request. 
FilterChainProxy implements (throught GenericFilterBean) the Servlet interface <b><i>Filter</i></b>. 
Spring Boot adds any <i><b>Filter</b></i> published as a @Bean to the application's filter chain. This means that 
the Spring Security's filter chain will be used for every request.
```
@Configuration
@EnableWebSecurity
public class EklSecurityConfiguration {

...

}
```
### OAuth 2.0 Resource Server, Authentication with JWT
#### Dependencies for JWT
  - spring-security-oauth2-resource-server -- Resource Server support of Spring Security
  - spring-security-oauth2-jose -- support for decoding and verifying JWTs
#### Configurtion for JWTs 
when using Spring Boot, configuring an application as a resource server consists of two basic steps,
  - include the needed dependencies
  - specifying the Authorization Server
    ```
    spring:
      security:
        oauth2:
          resourceserver:
            jwt:
              issuer-uri: https://idp.example.com/issuer
    ```
Where idp.example.com/issuer is the value contained in the <b>iss</b> claim for JWT tokens that the authorization server will issue.<br>
Note: To sue the <b>issuer-uri</b> property, it must also be true that the authorization server supports one of the following endpoints.<br>
This endpoint is referred to as a <b>Provider Configuration</b> endpoint or a <b>Authorization Server Metadata</b> endpoint
- idp.example.com/issuer/.well-known/openid-configuration
- idp.example.com/.well-known/openid-configuration/issuer
- idp.example.com/.well-known/oauth-authorization-server/issuer

#### Startup Expectations
When this property and these dependencies are used, Resource Server will automatically configure itself to validate JWT-encoded Bearer Tokens,
1. Query the ``Provider Configuration`` or ``Authorization Server MEtadata`` endpoint for the ``jwks_url`` property
2. Query the ``jwks_url`` endpoint for supported algorithms
3. Configure the validation strategy to query ``jwks_url`` for valid public keys of the algorithms found
4. Configure the valiation strategy to valiate each JWTs ``iss`` claim against ``idp.example.com``.

#### Runtime Expectations
Once the application is started up, Resource Server will attempt to process any request containing an ``Authorization: Bearer `` hader:
```
GET / HTTP/1.1
Authorization: Bearer some-token-value #Resource Server will process this
```
So long as this scheme is indicated, Resource Server will attempt to process the request according to tthe Bearer Token specification,
1. Validate its signature against a public key obtained from ``jwks_url`` endpoint during startup and matched against the JWT
2. Validate the JWT's ``exp`` and ``nbf`` timestamps and the JWT's ``iss`` claim and
3. Map each scope to an authority with prefix ``SCOPE_``.
The resulting ``Authentication#getPrincipal``, by default, is a Spring Security ``Jwt`` object, and ``Authentication#getName`` maps to the JWT's ``sub`` property, if one is present.

#### How JWT Authentication works
``JwtAuthenticationProvider`` is an ``AuthenticationProvider`` implementation that leverages a ``JwtDecoder`` and ``JwtAuthenticationConverter`` to authenticate a JWT<br>
```
(1) ---BearerTokenAuthenticationToken --------> AuthenticationManager -------- (2) -------------> AuthenticationProviders
            [Token]                              [ProviderManager]                                     [         ]
                                                         |                                                 ..... 
                                                         |                  (3) [JwtDecoder] <--- [JwtAuthenticationProvider]
                                                         |  (4) [JwtAuthenticationConverter]              ......
    <--- (5) --- JwtAuthenticationToken -----------------|                                              [          ]
                 [Jwt][Authorities]
```
``(1)`` The authentication Filter ``BearerTokenAuthenticationFilter`` passes a ``BearerTokenAuthenticationToken`` to the ``AuthenticationManager`` which is implemented by ``ProviderManager``.<br>
``(2)`` The ``ProviderManager`` is configured to sue an ``AuthenticationProvider`` of type ``JwtAuthenticationProvider``.<br>
``(3)`` ``JwtAuthenticationProvider`` decodes, verifies and validates the ``Jwt`` using a ``JwtDecoder``.<br>
``(4)`` ``JwtAuthenticaionProvider`` then uses the ``JwtAuthenticationConverter`` to convert the ``Jwt`` into a ``Collection`` of granted authorities.<br>
``(5)`` When the authentication is successful, the ``Authentication`` that is returned is of type ``JwtAuthenticationToken`` and has a principal that is the `Jwt` returned by the configured ``JwtDeocder``. Ultimately, the returned ``JwtAuthenticationToken`` will be set on the ``SecurityContextHolder`` by the authentication ``Filter``.<br>
### UserDetailsService
- publishes a UserDetailsService as @Bean, Spring Security will not generate default password. 
```
	@Bean
	public UserDetailsService userDetailsService() {
		UserDetails user = User.withDefaultPasswordEncoder()
				.username("client")
				.password("password")
				.roles("USER")
				.build();
		UserDetails dianne = User.withDefaultPasswordEncoder()
				.username("dianne")
				.password("password")
				.roles("USER")
				.build();
		UserDetails rod = User.withDefaultPasswordEncoder()
				.username("rod")
				.password("password")
				.roles("USER", "ADMIN")
				.build();
		UserDetails scott = User.withDefaultPasswordEncoder()
				.username("scott")
				.password("password")
				.roles("USER")
				.build();
		return new InMemoryUserDetailsManager(user, dianne, rod, scott);
	}
```
