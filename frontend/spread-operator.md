The JavaScript spread operator (`...`) allows in-place expansion of an an expression for the following cases,
1. Array
2. Function call
3. Multiple variable desstructuring

us to quickly copy all or part of an existing array or object into another array or object
```
const numbersOne = [1, 2, 3];
const numbersTwo = [4, 5, 6];
const numbersCombined = [...numbersOne, ...numbersTwo];

const add = (a, b) => a + b;
let args = [3, 5];
add(...args); // same as `add(args[0], args[1])`, or `add.apply(null, args)`
```
