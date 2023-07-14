Period and Duration can be used to represent an amount of time or determine the difference between two dates.The distinction ist
- Period uses date-based values
- Duration uses time-based values

#### Period
The class Period uses the units year , month and day to represent a period of time. The date units can be determined by using the methods getYears(), getMonths() and getDays().

Notice, getDays() returns only the values of the unit day, the values of the units year and month will not be concerned.

```
Period.of(1,2,3).getMonths(); //returns 2
Period.of(1,2,3).getDays(); //returns 3
```