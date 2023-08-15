# Spring Framework

### Inversion of Controll (IoC) Container Configuration
there are tree ways to configure IoC
#### 1) XML based configuration 
````
ClassPathXmlApplicationContext.java
```` 
#### 2) Annotation based configuration
@Component, @Controller, @Service, @Configuration, @Autowired, @Primary (for the case multi bean candidates exist), @Qualifier("userController"), @Value("${build.info}"), @PropertyResource("classpath:build-info.properties"), @ConfigurationProperties(prefix = "ekl.backend"), @Order, @Priority, @DependsOn, @Import(SomeConfiguration.class)
````
public class MovieRecommender {
@Autowired
@Qualifier("main")
private MovieCatalog movieCatalog;
}

public class MovieRecommender {
private final MovieCatalog movieCatalog;

    @Autowired
    public void prepare(@Qualifier("main") MovieCatalog movieCatalog) {
        this.movieCatalog = movieCatalog;
    }
}

@Configuration
@PropertySource("classpath:build-info.properties")
@Getter
public class BuildInfoConfigure {
@Value("${build.info:default value}")
private String buildInfo;
}
in file build-info.properties
build.info=1.0.1

@ConfigurationProperties(prefix = "ekl.backend")
@Getter
@Setter
@Configuration
public class BuildInfoConfigV3 {
    private String version;
    private Map<String, String> properties;
}
````
#### 3) Java-based configuration
- @Configuration + @Bean => bean factory methode
- (@Component) + @Bean => lite mode, no inter-bean references
````
@Configuration
public class EklBackendWSConfiguration {

    @Bean({"userService", "user-service"})
    public UserService getUserService() {
        return new MyServiceImpl();
    }
}
````



### Dependency Injection
#### there are three kinds of dependency injection
#### 1) constructor based DI (preferable by Spring)
the constructor arguments will be autowired by the IoC Container to create the bean.
If there is only one constructor, it will always be used. If multi constructors exist, 
only one constructor may declare @Autowired with the attribute required=true (default). 
(If no constructor declares @Autowired) the constructor with the greatest number of dependencies 
that can be satisfied will be chosen. If none of the candidates can be satisfied, 
the primary (@Primary) or default constructor, if present, will be chosen.

#### 2) setter based DI
a setter methode annotated with @Autowired

#### 3) field based DI
a field (attribute) annotated with @Autowired

### Transaction Management
- @Transactional: with Spring's standard configuration, should only be applied to methods with public visibility.
### Bean Validation
https://reflectoring.io/bean-validation-with-spring-boot/




