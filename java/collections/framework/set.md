A Set is a Collection that cannot contain duplicate elements. There are three general-purpose Set implementations
- HastSet -- stores its elements in a hash table, is the best-performing implementation
- TreeSet -- stores its elements in a red-black tree, orders its elements based on their natural ordering (through Comparable or Comparator), is substantially slower than HashSet.
- LinkedHashSet -- is implemented as a hash table with a linked list running through it, orders its elements based on the order in which they were inserted into the set (insertion-order), is slightly slower than HashSet
 
There are two special-purpose Set implementations
- EnumSet
- CopyOnWriteArraySet

#### TreeSet
````
//constructs a new tree set sorting its elements according to the natural ordering of its elements
TreeSet(Collection<? extendsE> c)

//constructs a new empty tree set, sorted according to the specified comparator
TreeSet(Comparator<? super E> comparator) 
````

#### The method of (E... ) and its variants
````
//returns an unmodifiable set containing an arbitary number of elements
static <E> Set<E> of (E... e)
````
