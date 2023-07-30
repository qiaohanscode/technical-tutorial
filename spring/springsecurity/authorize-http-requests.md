Spring Security allows you to model your authorization at the request level. Whenever you have an ``HttpSecurity```instance, you should at least do:
```
http
    .authorizeHttpRequests((authorize) -> authorize
        .anyRequest().authenticated()
```

### How Request Authorization Components Work
The ``AuthorizationFilter`` is last in ``Spring Security filter chain`` by default. 
This means that other filter,  Spring Security's authentication filters, exploit protections and other filter integrations,
do not require authorization. You need to add you own authentication filter before ``AuthorizationFilter``. 
