### Collection
Collection is the root interface of the collection hierarchy, implements the interface Iterable<E>.

### Interfaces
````
                 Collection                    Map
                     |                          |
    -----------------------------------         |
    |           |         |            |        |
   Set       List      Queue        Deque   SortedMap
    |
 SortedSet

````



- EnumMap -- saves the elements internally as arrays, extremely compact and efficient
````
EnumMap<UPDATEOPERATION,List<User>> userUpdateOperations = new EnumMap<>(UPDATEOPERATION.class);
````


#### View Collections
do not store elements, but instead they rely on a backing collection to store the actual elements.
- wrapper collections returned by methods such as Collections.checkedCollection, Collections.synchronizedCollection and Collections.unmodifableCollection
- different representation as provided by Lists.subList, NavigableSet.subSet or Map.entrySet.

#### Basic Operations
- size()
- isEmpty()
- add(E e)
````
boolean add (E e)
````
- remove(E e)
- iterator()
````
Iterator<E> iterator();
````

#### Bulk Operations
- contailsAll(Collection<?>)
````
// returns true if s2 is a subset of s1.
s1.containsAll(s2)
````
- addAll(Collection<?>)
````
//transforms s1 into the union of s1 and s2
s1.addAll(s2)
````
- retainAll(Collection<?>)
````
//transforms s1 into the intersection of s1 and s2
s1.retainAll(s2)
````
- removeAll(Collection<?>)
````
//transforms s1 into the (asymmetric) set difference of s1 and s2
s1.removeAll(s2)
````
#### Interator
```
Iterator<T> iterator()

default void forEach(Consumer<? super T> action)
```
#### Converting to array
````
Object[] toArray();


````

