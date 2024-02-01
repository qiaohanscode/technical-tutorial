The `rest parameter syntax` allows a function to accept an indefinite number of arguments as an array, providing a way to represent variadic functions in javascript. A function can only have one rest parameter, and the rest parameter must be the last parameter in the function definition.
```
# correct
function f(a, b, ...theArgs) {
  // …
}

# wrong
function wrong1(...one, ...wrong) {}
function wrong2(...wrong, arg2, arg3) {}
```

Examples
```
function myFun(a, b, ...manyMoreArgs) {
  console.log("a", a);
  console.log("b", b);
  console.log("manyMoreArgs", manyMoreArgs);
}

myFun("one", "two", "three", "four", "five", "six");

// a, "one"
// b, "two"
// manyMoreArgs, ["three", "four", "five", "six"] <-- an array
```
