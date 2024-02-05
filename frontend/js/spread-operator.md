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

object literals can do the same thing:
```
let mapABC  = { a: 5, b: 6, c: 3};
let mapABCD = { ...mapABC, d: 7};  // { a: 5, b: 6, c: 3, d: 7 }
```

The spread operator is often used in combination with destructuring
```
# Assign the first and second items from numbers to variables and put the rest in an array:
const numbers = [1, 2, 3, 4, 5, 6];
const [one, two, ...rest] = numbers;
```
