## Spring Boot

### TLS/SSL

````
server.port=8080
server.ssl.key-store=$PATH_KEY_STORE
server.ssl.key-store-password=$KEY_STORE_PASSWORD
server.ssl.trust-store=$PATH_TRUST_STORE
server.ssl.trust-store-password=$KTRUST_STORE_PASSWORD
````
### Monitoring -- the module spring-boot-actuator provides the functionality for monitoring.
### Port
````
management.server.port=8081
````

### Endpoints
- shutdown -- is disabled by default and can be enabled with
```
management.endpoint.shutdown.enabled=true
```
- health, env, prometheus, beans and etc. are enabled by default. Access with HTTP can be configured with
````
management.endpoints.web.exposure.include=health,prometheus
````
### HealthIndicators
HealthIndicators collect the health information. Spring auto-configure a number of HealthIndicators -- DataSourceHealthIndicator, HazelcastHealthIndicator, MailHealthIndicator, LivenessStateHealthIndicator (disabled by default), ReadinessStateHealthIndicator (disabled by default) ...

### Health status 
UP, DOWN, OUT_OF_SERVICE, UNKNOWN

### Kubernetes Probe
dedicated HealthIndicator, LivenessStateHealthIndicator and ReadinessStateHealthIndicator, will be automatically enabled in kubernetes environment und will be exposed under 
- /actuator/health/readiness
- /actuator/health/liveness 

In other enviroment enabled with
````
management.endpoint.health.probes.enabled=true          
````

### Application Information
Build information is avaiable when META-INF/build.properties exists, which can be generated with spring boot maven plugin
````
<plugins>
    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <configuration>
            ...
        </configuration>
        <executions>
            <execution>
                <goals>
                    <goal>build-info</goal>
                </goals>
            </execution>
        </executions>
    </plugin>
</plugins>
````

### Register customer metrics
````
@Configuration
public class MyMeterBinderConfiguration {

    @Bean
    public MeterBinder queueSize(Queue queue){
        return (registry) -> Gauge.builder("queueSize", queue::size).register(registry);
    }
}
````
