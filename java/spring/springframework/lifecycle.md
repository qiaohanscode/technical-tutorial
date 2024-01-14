The ``JSR-250`` annotations are generally considered best practice for receiving lifecycle callbacks in a modern Spring application.
```
@PostConstruct
@PreDestory
```

To interact with the containers's management of the bean lifecycle, you can also implements the Sprinng ``InitializeingBean`` and ``DisposableBean`` interfaces.

```
public interface InitializingBean {
    void afterPropertiesSet() throws Exception;
}
```

```
public interface DisposableBean {
    void destroy() throws Exception;
}
```
Internally, Spring Framework uses ``BeanPostProcessor`` to process any callback interfaces it can find. If you need custom features or other lifecycle behavior Spring does not by default offer, you can implement a ``BeanPostProcessor`` yourself.
```
public interface BeanPostProcessor {
    @Nullable
    default Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        return bean;
    }

    @Nullable
    default Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        return bean;
    }
}
```

Multiple lifcycle mechanisms configured for the same bean are ccalled as follows,
1) Methods annotated with ``@PostConstruct``
2) ``afterPropertiesSet()`` as defined by the ``InitializingBean`` callback interface
3) A custom configured ``init()`` method

Desotry methods are called in the same order,
1) Methods annotated with ``@PreDestroy``
2) ``destroy()`` as defined by the ``DisposableBean`` callback
3) custom configured ``destroy()`` method
