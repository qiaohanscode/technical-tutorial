#### Authorities
The objects ``GrantedAuthority`` are inserted into the ``Authentication`` object by the ``AuthenticationManager`` and 
represent the authorities that have been granted to the principal.

The ``GrantedAuthority`` interface has only one method:
```
String getAuthority();
```
This method is used by an ``AuthorizationManager`` instance to obtain a precise ``String`` representation of the ``GrantedAuthority``.
Spring Security inludes one concrete``Grantedauthority`` implementation: ``SimpleGrantedauthority``. This implementation lets any user-specified
``String`` be converted into a ``GrantedAuthority``. All ``AuthenticationProvider`` instances included with the security architecture use
``SimpleGrantedAuthority`` to populate the ``Authentication`` object. <br>

By default, role-based authorization rules include ``ROLE_`` as a prefix.
Spring Security will by default look for a `GrantedAuthority#getAuthority that returns ``ROLE_USER``.
