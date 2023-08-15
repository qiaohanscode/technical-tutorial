### Aspect Oriented Programming
a proxy-based AOP Framework, supports currently only method execution join points on spring beans. Field interception (typically domain object) is not implemented (AspectJ is the best choice).

- Aspect: a modularization of a concern that cuts across multiple classes, e.g. transaction managenebt. Implemented with @Aspect (@AspectJ style) or schema-based
- JoinPoint: is a point during the execution of a program, eg. execution of a method or handeling of a exception. In Spring AOP a join point always represents  a method execution.
- Advice: action taken by a particular Joinpoint, is in Spring modelled as an interceptor.
    - Before
    - After returing
    - After throwing
    - After (finally)
    - Around
- Point cut: a predicate that helps to matche an Advice to be applied by an Aspect at a particular JoinPoint. A Pointcut expression is often associated with Advice.
- Introduction:
- Target object: an object being adviced by one or more aspects
- AOP proxy:
- Weaving:

#### 1) @AspectJ style
regular Java classes annotated with annotations.<br/>

##### Enabling @AspectJ Support with Java
@EnableAspectJAutoProxy + @Configuration
````
@Configuration
@EnableAspectJAutoProxy
public class AppConfig {
}
````

#### Declaring an Aspect with @AspectJ enabled
@Component + @Aspect
````
package com.xyz;

import org.aspectj.lang.annotation.Aspect;

@Component
@Aspect
public class NotVeryUsefulAspect {
}
````

#### 2) schema-based approach with XML
