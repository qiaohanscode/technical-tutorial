### The List Interface
A List is an ordered Collection (aka. sequence), may contain duplicate elements.

There are two general-purpose List implementations
- ArrayList -- better performance
- LinkedList

In addition to the operations inherited from Collection, List includes operations for the following:
- Positional access -- get, set, add, addAll, remove
- Search -- indexOf, lastIndexOf
- Interation
- Range-view

One Special-purpose list implementation
-CopyOnWriteArrayList

#### List View of an Array
The method Arrays.asList(E...) returns a List view of its array argument. Changes to List write through to the array and vice versa. The size of the collection is that of the array and cannot be changed. If add() or remove() is called on the List, an UnsupportedOperationException will result.

#### The method sort
````
//sorts a List using a merge sort algorithm
default void sort(Comparator<? super E> c)
````
#### The method of (E...) and its other variants
````
//returns an unmodifiable List containing an arbitary number of elements
static <E> List<E> of(E... e)
````
