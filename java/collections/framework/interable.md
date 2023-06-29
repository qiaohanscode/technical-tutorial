### The interface Interable \<T>
implementing this interface allows an object to be the target of the nhanced for statement (aka. for-each loop statement)
````
default void forEach(Consumer<? super T> action)

Iterator<Tr> iterator()

default Spliterator<T> splierator()
````
