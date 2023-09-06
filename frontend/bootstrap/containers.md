#### Containers
Containers are the most basic layout element in Bootstrap and are ``required when using the default grid daystem``. Containters are used to contain, pad and center the content within them. While containers can be nested, most layouts do not required a nested container. Bootstrap comes with three different containers,
- ``.container`` class provides a responsive fixed width container and sets a ``max-width`` at each responsive breakpoint.
```
            Extra small     Small       Medium      Large       Extra Large     XXL
            <576px          >= 576px    >=768px     >=960px     >= 1140px       >=1400px
max-width   100%            540px       720px       960px       1140px          1320px
```
- ``.container-fluid`` class is ``width: 100%`` at all breakpoints
- ``.container-{breakpoint}``, which is ``width: 100%`` until the specified breakpoint reached and then has a fixed width specified for each monitor size. 
