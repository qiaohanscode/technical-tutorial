### pipe
`pipe()` can be called on one or more functions, each of which can take one argument ("UnaryFunction") and uses it to return a value. It returns a function that takes one argument, passes it to the first UnaryFunction, and then passes the result to the next, passes that result to the next one, and so on.

```
pipe(...fns: UnaryFunction<any, any> []): UnaryFunction<any, any>
```
