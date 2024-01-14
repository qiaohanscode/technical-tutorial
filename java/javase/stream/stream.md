#### Intermediate operation

````
Stream<T> filter(Predicate<? super T> predicate)
````

````
<R> Stream<R> map(Function<? super T, ? extends R> mapper)

IntStream mapToInt(ToIntFunctin<? super T> mapper);

LongStream mapToLong(ToLongFunction<? super T> mapper);

DoubleStream MapToDouble(ToDoubleFunction<? super T> mapper);
````
````
<R> Stream<R> flatMap(Function<? super T, ? extends Stream<? extends R>> mapper);

Stream<String> lines = Files.lines(path, StandardCharsets.UTF_8);
Stream<String> words = lines.flatMap(line -> Stream.of(line.split(" +")));
````

````
IntStream flatMapToInt(Function<? super T, ? extends IntStream> mapper);

LongStream flatMapToLong(Function<? super T, ? extends LongStream> mapper);

DoubleStream flatMapToDouble(Function<? super T, ? extends DoubleStream> mapper);
````

````
Stream<T> distinct()

/* returns a stream consisting of the distinct elements according to the method equals() */
````
````
Stream<T> sorted()

Stream<T> sorted(Comparator<? super T> comparator);
````

````
Stream<T> peek(Consumer<? super T> action);

/* performing the provided action (Consumer) on each element */

Stream.of("one", "two", "three", "four")
       .filter(e -> e.length() > 3)
       .peek(e -> System.out.println("Filtered value: " + e))
       .map(String::toUpperCase)
       .peek(e -> System.out.println("Mapped value: " + e))
       .collect(Collectors.toList());
````

````
Stream<T> limit(long maxSize);

/* truncate the stream to be no longer than maxSize in length
   important, can be expensive with ordered parallel pipelines
   recommended to use with unordered stream or sequential stream */
````

````
Stream<T> skip(long n)

/* returns a stream consisting of the remaining elements after discarding the first n elements */
````




````
default Stream<T> takeWhile(Predicate<? super T> predicate)

/* returns a stream consisting the longest prefix of elements matching the given predicate*/

List<Integer> list = Stream.of(4,5,6,7,8)
                    .takeWhile(n -> (n%4 ==0))
                    .collect(Collectors.toList());
System.out.println(list);

/* output is [4] 
   stream processing is broken after 5 processed */
   
List<Integer> list = Stream.of(3,4,5,6,7,8)
                    .takeWhile(n -> (n%4 ==0))
                    .collect(Collectors.toList());
System.out.println(list);

/* output is [] */
````
````
default Stream<T> dropWhile(Predicate<? super T> predicate)

/* returns a stream consisting of the remaining elements of this stream after dropping the longest prefix of elements matching the given predicate */

List<Integer> list = Stream.of(3,4,5,6,7,8)
                    .dropWhile(n -> (n%4 ==0))
                    .collect(Collectors.toList());
System.out.println(list);

/* output is [3,4,5,6,7,8] */

List<Integer> list = Stream.of(4,5,6,7,8)
                    .dropWhile(n -> (n%4 ==0))
                    .collect(Collectors.toList());
System.out.println(list);

/* output is [5,6,7,8] */
````
#### Terminal Operations
````
void forEach(Consumer<? super T> action);
````
````
void forEachOrdered(Consumer<? super T> action)

/* performs an action for each element of this stream in the encounter order 
   of the stream if the stream has a defined encounter order */
````

````
Object[] toArray();

/* returns an array containing the elements of this stream,
   the runtime component type is Object */
````
````
<A> A[] toArray(IntFunction<A[]> generator);

Person[] men = people.stream()
                     .filter(p -> p.getGender() == MALE)                      
                     .toArray(Person[]::new)
````





























