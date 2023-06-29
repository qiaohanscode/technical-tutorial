#### Each functional interface has a single abstract method, called the functional method for that functional interface. Functional interfaces provide target types for lambda expressions and method references (String:isEmpty)
- Runnable -- represents a task which should be executed in a separate thread which may started with Thread.start(). No Arguments, no results
````
public abstract void run();
````
- Callable\<V> -- represents a task with a result and may throw exception.
````
V call() throws Exception;
````
- Function<T,R> -- represents a function that accepts one argument and produces a result
````
R apply(T t)
default <V> Function<T,V> andThen(Function<? super R, ? extends V> after)
default <V> Function<V,R> compose(Function<? super V, ? extends T> before)
````
````
static <T> Function<T,T> identity()

List<String> names = Arrays.asList("Peter","Martin","John");
names.stream().map(Function.identity()).forEach(System.out::println);
````
- Supplier\<T> -- represents a supplier of results. No requirement that a new or distinct result will be returned by each invocation.
````
T get();

Supplier<LocalDateTime> ldtNowSupplier = () -> LocalDateTime.now();
System.out.println(ldtNowSupplier.get());
````
- Predicate\<T> -- represents a predicate (boolean valued function) of one argument
````
boolean test(T t)
````
````
default Predicate<T> and(Predicate<? super T> other)

Predicate<Integer> noGreaterThan5 = x -> x>5;
Predicate<Integar> noLessThan8 = x -> x<8;
list.stream()
    .filter(noGraterThan5.and(noLessThan8))
    .collect(Collectors.toList());    
````
````
default Predicate<T> or(Predicate<? super T> other)
````
````
default Predicate<T> negate()

Predicate>String> startWithA = x -> x.startsWith("A");
var listStr = Arrays.asList("A", "AA", "AAA", "B","BB","BBB");
listStr.stream()
       .filter(startwithA.negate())
       .collect(Collectors.toList());
````
````
static <T> Predicate<T> isEqual(Object targetRef)

Predicate<String> isEq = Predicate.isEqual("some thing");
listStr.stream().filter(isEq).collect(Collectors.toList());
````

- Consumer\<T> -- represents an operation that accepts a single input argument and returns no result. Consumer is expected to operate via side-effects.
````
void accept(T t)

default Consumer<T> andThen(Consumer<? super T> after)
````
- UnaryOperator\<T> -- represents an operation on a single operand that produces a result of the same type as its operand. It is a specialization of Function.
````
public interface UnaryOperator<T> extends Function<T,T>
````
- Comparable\<T> -- throws NullPointerExcetpion if o == null, throws ClassCastException if o can not be converted.
````
public int compareTo( T o)
````
