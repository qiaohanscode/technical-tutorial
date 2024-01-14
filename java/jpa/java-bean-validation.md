### Jakarta Bean Validation
- @Pattern -- must match the regular expression defined in ``java.util.regex.Pattern``
- @Min, @Max -- annotated element must be a number, supported types are ```BigDecimal, BigInteger, byte, short, int, long``` 
and their reference wrappers. ``Note, double and float`` are not supported.
```
import jakarta.validation.constraints.AssertTrue;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Email;

@NotNull(message = "Name cannot be null")
private String name;

@AssertTrue
private boolean working;

@Size(min = 10, amx = 200, message = "descrption muss be between 10 and 200 character")
privat String descrptiong;

@Min(value = 18, message = "Age sould not be less then 18")
@Max(value = 150, message = "Age shuld not be greater than 150")
private int age;

@Email(message = "Email should be valid")
private String email;
```
