An Array has following features,
- all arrays are dynamically allocated
- arrays are stored in contiguous memorythe size of an array must be specified by int or short, NOT long
- the direct superclass of an array type is Object
- every array type implements the interfaces Cloneable and Serializable
- the size of  the array acnnot be altered once initialized.
````
int[] arrayInt = {1,2,3};
arrayInt[4] = 4; //ArrayIndexOutOfBoundException will be thrown
````
- the class name of an array will begin with a bracket followed with the element type
````
/* the output is [I */
System.out.println("class name arrayInt " + arrayInt.getClass().getName());

/* the output is [Ljava.lang.String;
String[] arrayStr = {"ab","cd"};
System.out.println("class name arrayStr " + arrayStr.getClass().getName());

/* the output is [Ljava.lang.Integer;
Integer[] arrayInteger = {1,2,3};
System.out.println("class name arrayInteger " + arrayInteger.getClas().getName());
````
#### the general form of a one-dimensional array declaration is like following.
````
type var-name[];
OR
type[] var-name;
````
````
// both are valid declarations
int intArray[]; 
or int[] intArray; 

byte byteArray[];
short shortsArray[];
boolean booleanArray[];
long longArray[];
float floatArray[];
double doubleArray[];
char charArray[];

// an array of references to objects of
// the class MyClass (a class created by
// user)
MyClass myClassArray[]; 

Object[]  ao,        // array of Object
Collection[] ca;  // array of Collection
````
####  To notice, with declaration above,no actual array exists. To link an Array with an actual, physical array, you must allocate one using new and assign it with values.
#### Obtaining an array is a two-step process. First, you must declare a variable of the desired array type. Second, you must allocate the memory to hold the array, using new, and assign it to the array variable. Thus, in java, all arrays are dynamically allocated.
````
int intArray[]; //declaring array
intArray = new int[20]; //allocating memory to array

/* Note:
   the elements in the array allocated by new will automatically be initialized to zero (for numeric types),false (for boolean), or null (for reference types).
````
#### Array Literal
in the situation where the size of the array and varialbes of the array are already known,
````
int[] intArray = new int[]{1,2,3,4,5,6};

int[] intArray = {1,2,3}; //it also works
/* declaring array literal */
````

#### Arrays can be accessed with for or for each loops
````
for(int i=0;i<array.length;i++)

for(int e : arry)
````
#### Cloning of arrays
- when clone a single-dimensional array, a "deep copy" will be performed.
- when clone a multi-dimensional array, a "shallow copy" will be performed.Only a single new array with each element array as a reference.
#### Arrays.toString()
The static factory method Arrays.toString() will generate a string for the array
````
Arrays.toString(arrayInt);
````

#### Converting to Collection
- Collections.addAll(Collection<T> c, T... elements)
````
Integer arrayInteger[] = new Integer[]{1,2,3};
var listInteger = new ArrayList<Integer>();
Collections.addAll(listInteger, arrayInteger);
System.out.println(listInteger);
````
- List.of(E... elements)
````
String countryArray[] = { "India", "Pakistan", "Afganistan", "Srilanka" };
List<String> countryList = new ArrayList<>(List.of(countryArray));
System.out.println("Converted ArrayList elements: " + countryList);
````
- Arrays.stream(T[] array)
````
String countryArray[] = { "India", "Pakistan", "Afganistan","Srilanka" };
List<String> countryList = Arrays.stream(countryArray).collect(toList());
System.out.println("Converted ArrayList elements: " + countryList);
````
- Arrays.asList(T... array)
````
String playersArray[] = { "Virat", "Sachin", "Rohit", "Bumrah" };
List playersList = Arrays.asList(playersArray);
System.out.println("Converted elements: " + playersList);
````
