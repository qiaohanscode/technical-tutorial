## Filter and FilterChain

### Interface Filter
The `Filter` interface is defined in the `jakarta.servlet` package. A `Filter` is an object that perfomrs filtering tasks on either the request to a resource (a servlet or static content), or on the response from a resource, or both.

Filters perform filtering in the `doFilter` methode and are configured in the deployment descriptor of a web application.

```
void doFilter(ServletRequest request, 
              ServletResponse response,
              FilterChain chain) 
         throws IOException,
                ServletException 
```
