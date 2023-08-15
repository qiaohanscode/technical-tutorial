- Number -- abstract class representing numeric values convertible to the primitive types byte, short, int, long, float, double. Declares follwoing abstract methodes,
````
public abstract byte byteValue();

public abstract short shortValue();

public abstract int intValue();

public abstract long longValue();

public abstract floatValue();

public abstract doubleValue(); 
````
- Byte
- Short, Integer, Long -- compare with numeric operator
````
< <= == >= >
````
- Float, Double -- imposes a total order on Float/Double objects, the numeric operators (< <= == >= >) provide incomplete order, should be compared with the method 
````
Float.compareTo(Float) 
or 
Double.compareTo(Double)
````
define the static methods and the constant NaN,
````
//equivalent to Float.intBitsToFloat(0x7fc00000)
public static final float NaN = 0.0f/0.0f;

public static int compare(float x, float y);

//equivalent to Double.longBitsToDouble(0x7ff8000000000000L)
public static final double naN = 0.0d/0.0;

public static int compare(double x, Double y);
````
