A SortedSet is a Set that maintains its elements in ascending order according to the element's natural ordering or according to a Comparator provided at SortedSet creation time.

The operations that SortedSet inherits from Set behave identically with two exceptions
- The Iterator returned by the iterator operation traverses the sorted set in order
- The array returned by toArray contains the sorted set's elements in order

In addition to the normal Set operations, the SortedSet interface provides operations for the following,
#### Range view
A range-view is really just a window onto whatever portion of the set. Changes to the range-view write back to the backing sorted set and vice versa.
````
SortedSet<E> subSet(E fromElement, E toElement)

//removes all the elements beginning with the letter f
dictionary.subSet("f", "g").clear();
````
````
SortedSet<E> headSet(E toElement)

//the portion of the set with open bigger end, [)
dictionary.headSet("n");
````
````
SortedSet<E> tailSet(E fromElement)

//the portion of set beginning from n, n is inclusive
dictionary.tailSet("n");
````
#### Endpoint Operations
````
E first();
E last();
````
#### Comparator Accessor
an accessor method that returns Comparator used to sort the set or null if natural ordering used.
