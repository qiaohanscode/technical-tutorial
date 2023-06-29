### The Map Interface
has three general-purpose Map implementations
- HashMap -- analogous to HashSet
- TreeMap -- analogous to TreeSet
- LinkedHashMap -- analogous to LinkedHashSet

There are three special-purpose Map implementations
- EnumMap -- a high performance Map for enum keys.
- WeakHashMap -- stores only weak references to its keys allowing a key-value pair to be garbage-collected when its key is no longer referenced outside of the WeakHashMap
- IdentityhashMap
#### Basic operations
- put (K,V)
- get (K)
- remove (K)
- containsKey (K)
- containsValue (V)
- size ()
- empty ()
````
Map<Department,List<Employee>> bydept = employees.stream()
    .collect(Collectors.groupingBy(Employee::getDepoartment));

or
    
Map<Dempartmehnt, Integer> totalByDept = employees.stream()
    .collect(Collectors.groupingBy(Employee::getDepartment,Collectors.summingInt(Employee::getSalary)));
    
or

Map<Boolean, List<Student>> passingFailing = students.stream()
    .collect(Collectors.partitioningBy(s -> s.getGrade()>= PASS_THRESHOLD));
````
#### TreeMap
````
//constructs a new tree map containing the same mapping as the given map, ordered to the natural ordering of its keys
TreeMap(Map<? extends K, ? extends V> m)

//constructs a new empty tree map, ordered according to the given comparator
TreeMap(Comparator<? super K> comparator)
````
#### Bulk Operations
- putAll(Map)
#### Collection views
- keySet -- the Set of keys contained in the Map
- values -- The Collection (not a Set) of values contained in the Map
- entrySet -- the set of key-value pairs contained in the Map
