## Spring Boot
### Monitoring -- the module spring-boot-actuator provides the functionality for monitoring.
### Endpoints
- shutdown -- is disabled by default and can be enabled with
```
management.endpoint.shutdown.enabled=true
```
- health, env, prometheus, beans and etc. are enabled by default. Access with HTTP can be configured with
````
management.endpoints.web.exposure.include=health,prometheus
````
