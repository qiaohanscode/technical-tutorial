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
