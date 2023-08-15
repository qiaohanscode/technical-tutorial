### Method Security
Method Security can be activated by annotating any ``@Configuration`` class with ``@EnableMethodSecurity``.
```
@EnableMethodSecurity
```
### Expressing Authorization with SpEL
Spring Secrity encapsulates all of its authorization fields and methods in a set of root objects. 
The most generic root object is called ``SecurityExpressionRoot`` and it forms the basis for ``MethodSecurityExpressionRoot``. 
This Root objects will be supplied to ``MethodSecurityEvaluationContext``.

#### The Most Common Authorization Expression Methods,
- ``permitAll``
- ``denyAll``
- ``hasAuthority``
- ``hasRole``
- ``hasAnyAuthority``
- ``hasAnyRole``
- ``hasPermission``

#### The most common authorization Expression Fields
- ``authentication`` -- The ``Authentication`` instance associated with this method invocation
- ``principal`` -- The ``Authentication#getPrincipal`` associated with this method invocation.

```
@Component
public class MyService {
    @PreAuthorize("denyAll")
    MyResource myDeprecatedMethod(...);

    @PreAuthorize("hasRole('ADMIN')")
    MyResource writeResource(...)

    @PreAuthorize("hasAuthority('db') and hasRole('ADMIN')")
    MyResource deleteResource(...)n

    @PreAuthorize("principal.claims['aud'] == 'my-audience'")
    MyResource readResource(...);

	@PreAuthorize("@authz.check(authentication, #root)")
    MyResource shareResource(...);
}
```

#### Using Method Parameters
- ``@P``
```
import org.springframework.security.access.method.P;

...

@PreAuthorize("hasPermission(#c, 'write')")
public void updateContact(@P("c") Contact contact);
```
- ``@Param``
```
import org.springframework.data.repository.query.Param;

...

@PreAuthorize("#n == authentication.name")
Contact findContactByName(@Param("n") String name);
```
