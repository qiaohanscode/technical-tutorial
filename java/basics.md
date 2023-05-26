### autoboxing
is the automatic conversion from primitive type to corresponding wrapper class, eg. int -> Integer, double -> Double

### unboxing
is the automatic conversion the other direction, wrapper class to primitive type. Boolean to boolean, Byte to byte


### Enum
each Enum instance has following implicitly declared methods
````
/**
 * Returns an array containing the constants of this enum 
* type, in the order they're declared.  This method may be
 * used to iterate over the constants as follows:
 *
 *    for(E c : E.values())
 *        System.out.println(c);
 *
 * @return an array containing the constants of this enum 
* type, in the order they're declared
 */
 public static E[] values();
````
````
/**
 * Returns the enum constant of this type with the specified
 * name.
 * The string must match exactly an identifier used to declare
 * an enum constant in this type.  (Extraneous whitespace 
* characters are not permitted.)
 * 
* @return the enum constant with the specified name
 * @throws IllegalArgumentException if this enum type has no
 * constant with the specified name
 */
 public static E valueOf(String name);
````
