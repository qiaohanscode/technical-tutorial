# Spring Framework
## Dependency Injection
### there are three kinds of dependency injection
#### 1) constructor based DI
the constructor arguments will be autowired by the IoC Container to create the bean. If there is only one constructor, it will always be used. If multi constructors exist, only one constructor may declare @Autowired with the attribute required=true (default). (If no constructor declares @Autowired) the constructor with the greatest number of dependencies that can be satisfied will be chosen. If none of the candidates can be satisfied, the primary (@Primary) or default constructor, if present, will be chosen.
