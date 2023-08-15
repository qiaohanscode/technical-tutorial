- Comparator\<T> -- represents a comparison function.
````
int compare(T o1, T o2)
````
````
static <T,U extends Comparable<? super U>> Comparator<T> comparing(Function<? super T,? extends U> keyExtractor)

Comparator<Employee> employeeNameComparator = Comparator.comparing(Employee::getName);
Arrays.sort(employees, employeeNameComparator);
````
````
static <T,U> Comparator<T> comparing(Function<? super T,? extends U> keyExtractor,Comparator<? super U> keyComparator)

Comparator<Employee> employeeNameComparator = Comparator.comparing(Employee::getName 
    ,(s1,s2) -> { return s1.compareTo(s2);});
Arrays.sort(employees,employeeNameComparator);                            
````
````
default Comparator<T> reversed()

Comparator<Employee> employNameComparator = Comparator.comparing(Employee::getName);
Comparator<Employee> employNameComparatorReversed = employNameComparator.reversed();
Arrays.sort(employees,employNameComparatorReversed);
````
````
public static <T extends Comparable<? super T>> Comparator<T> naturalOrder()

public class Employee implements Comparable<Employee> {
    
    ... 
    
    public int compareTo(Employee other){
        return this.name.compareTo(other.getName());
}

Comparator<Employee> employeeNameComparator = Comparator.<Employee> naturalOrder();
or
Comparator<Employee> employeeNameComparator = Comparator.naturalOrder();

Collections.sort(ListEmployee,employeeNameComparator);
or
Collections.sort(listEmployee,Comparator.naturalOrder());
````
````
public static <T extends Comparable<? super T>> Comparator<T> reverseOrder()

listEmployee.sort(Comparator.reverseOrder());
````
````
public static <T> Comparator<? super T> nullFirst(Comparator<? super T> comparator)

Comparator<Employee> comparatorEmployeeName = Comparator.comparing(Employee::getName);
Comparator<Employee> comparatorEmployeeNameNullFirst = Compatator.nullFirst(comparatorEmployeeName);
Arrays.sort(employeeArrayWithNulls, comparatorEmployeeNameNullFirst);
````
````
public static <T> Comparator<? super T> nullLast(Comparator<? super T> comparator)
````
````
default <U extends Comparable<? super U>> Comparator<T> thenComparing (Function<? super T, ? extends U> keyExtractor)

Comparator employeeAgeNameComparator = Comparator.comparing(Employee::getName).thenComparing(Employee::getAge);
Arrays.sort(employeesArray,employeeAgeNameComparator);
````
````
default U Comparator<T> thenComparing(Function<? super T, ? extends U> keyExtractor, Comparator<? super U> comparator)
````
````
//when equal, then compare with Comparator other
default Comparator<T> thenComparing(Comparator<? super T> other)
````
````
default Comparator<T> thenComparingInt(ToIntFunction<? super T> keyExtractor)

default Comparator<T> thenComparingLong(ToLongFunction<? super T> keyExtractor)

default Comparator<T> thenComparingDouble(ToDoubleFunction<? super T> keyExtractor)

public static <T> Comparator<T> comparingInt(ToIntFunction<? super T> keyExtractor)

public static <T> Comparator<T> comparingLong(ToLongFunction<? super T> keyExtractor)

public static <T> Comparator<T> comparingDouble(ToDoubleFunction<? super T> keyExtractor)



````









