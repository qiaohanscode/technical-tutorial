### Wrapper Implementations
All implementations are found in the Collections class which consists solely of static factory methods.

#### Synchronization Wrappers
Each of the six core collection interfaces -- Collection,Set,List,Map,SortedSet,SortedMap -- has one static factory method.

The easy way to guarantee serial access is not to keep a reference to the backing collection.
````
public static <T> Collection<T> synchronizedCollection(Collection<T> c)

public static <T> Set<T> synchronizedSet(Set<T> s);
````
````
public static <T> List<T> synchronizedList(List<T> list);

List<Type> list = Collections.synchronizedList(new ArrayList<Type>());
````
````
public static <K,V> Map<K,V> synchronizedMap(Map<K,V> m);

public static <T> SortedSet synchronizedSortedSet(SortedSet<T> s);

public static <K,V> Sortedmap<K,V> synchronizedSortedmap(SortedMap<K,V> m);
````
#### Unmodifiable Wrappers
Each of the six core Collection interfaces has one static factory method,
````
public static <T> Collection<T> unmodifiableCollection(Collection<? extends T> c);

public static <T> Set<T> unmodifiableSet(Set<? extends T> s);

public static <T> List<T> unmodifiableList(List<? extends T> List);

public static <K,V> Map<K,V> unmodifiableMap(Map<? extends K,? extends V> m);

public static <T> SortedSet<T> unmodifiableSortedSet(SortedSet<? extends T> s);

public static <K,V> SortedMap<K,V> unmodifiableSortedmap(SortedMap<K,? extends V> m); 
````
#### Checked Interfae Wrappers
Collections.checked interface wrappers are provided for use with generic collections.

#### Immutable Singleton Set
````
c.removeAll(Collections.singleton(e));
````
#### Immutable Singleton List
````
public static T List<T> singletonList(E e);
````
#### Immutable Singleton Map
````
public static <K,V> Map<K,V> singletonMap(K key, V value);
````
#### Static factory method to sort list
````
public static <T extends Comparable <? super T>> void sort(List<T>)

public static <T> void sort(List<T>, Comparator<? super T>)
````
