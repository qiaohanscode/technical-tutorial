### The SortedMap Interfact
A SortedMap is a Map that maintains its entries in ascending order according to th keys's natural ordering or according to a Comparator provided at the time of the SortedMap creation.

SortedMap has the following methods,
````
Comparator<? super K> comparator();

SortedMap<K,V> subMap(K fromKey, K toKey);

SortedMap<K,V> headMap(K toKey);

SortedMap<K,V> tailMap(K fromKey);

K firstKey();

K lastKey();
````
