#### Record classes (from java 14)
A record declaration specifies in a header a description of its contents. The appropriate accessors, constructor, equals, hashCode and toString methods are created automatically.
````
record Rectangle(double length, double width){}
````
A record class declares the following members automatically:
- for each component in the header
  - A private final filed
  - A public accessor method with the same name and type of the component. 
  ````
  Rectangle::length() 
  
  Rectangle::width()
  ````
- A canonical constructor
- Implementations of equals ,hashCode and toString()

#### Feature of Record class
- you can create generic record class
````
record Triangle<C extends Coordinate> (C top, C left, C right)
````
- you can declare a record class that implements one or more interfactes
````
  record Customer (...) implments Billable {}
````
- you can annotate a record class and its individual components
````
record Rectangle(
  @GreaterThanZero double length,
  @GreaterThanZero double width) {}
````
#### Local record class
````
import java.time.*;
import java.util.*;
import java.util.stream.*;

record Merchant (String name) {}

public class MerchantExample {
  
  //Local record class
  record MerchantSales (Merchant merchant, double sales) {}

}
````
