#### Some properties of generic methods,
- have a type parameter (the diamond operator enclosing the type \<T>) before the return type of the method declaration
- type parameter can be bounded, < ? extends T>, <? super T>
- can have different type parameters separated by comma \<T,G>
- method body is just like normal method
````
public static <T,G> List<G> from ArrayToList(T[] a, Function>T,G> mapperFunction){
return Arrays.stream(1)
             .map(mapperFunction)
             .collect(Collectors.toList());
````
#### Bounded Generics
- upper bound -- accepts a type and all its subclasses
````
<? extends T>
````
- lower bound -- accepts a type and all its superclasses
```` 
<? super T>
````
#### Wildcard -- the question mark ?
#### Multiple bounds -- a type can have multiple upper bounds
````
<T extends Nummer & Comparable>
````
#### Type Erasure -- the compiler removes all type parameters and replaces them with their bounds or with Object if the type parameter is unbounded.
````
public <T> List<T> genericMethod(List<T> list {
    return list.stream().collect(Collectors.toList());
}

//for illustration
public List<Object> withErasure(List<Object> list) {
    return list.stream().collect(Collectors.toList());
}

//which in practice results in
public List withErasure(List list) {
    return list.stream().collect(Collectors.toList());
}
````
#### Generics and primitive data type
primitive data types cannot be used as type parameter. Generics is a compiler feature and will be converted in compile time to Object. The primitive data types are not Objects.

