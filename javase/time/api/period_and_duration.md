Period and Duration can be used to represent an amount of time or determine the difference between two dates.The distinction ist
- Period uses date-based values
- Duration uses time-based values

#### Period
The class Period uses the units year , month and day to represent a period of time. The date units can be determined by using the methods getYears(), getMonths() and getDays().

Notice, the method getYears() returns only the value of the year, getMonths() the value of month and getDays() only the value of the day, there is no accumulation on the time units.

```
Period.of(1,2,3).getMonths(); //returns 2
Period.of(1,2,3).getDays(); //returns 3

Period.ofWeeks(2).getDays(); //return 14 (2*7)

var start = LocalDateTime.of(2023,1,1,0,0,0,0).toLocalDate();
var end = LocalDateTime.of(2024,3,4,1,1,1,1).toLocalDate();
var betw = Period.between(start,end).getDays(); //return 3;
```
#### Duration
The class Duration is suited for handling shorter amounts of time and represents an interval of time in seconds or nanoseconds.
```
var start = LocalDateTime.parse("2017-10-03T10:15:30.00");
var end = LocalDateTime.parse("2018-10-05T10:16:30.00");
var dur = Duration.between(start2,end2);
dur.toDays(); // returns 367
dur.toHours(); // returns 8808
dur.toMinutes(); // returns 528481
dur.toSeconds(); // returns 31708860
```
A Duration can also be created by parsing a char sequence in the format "PnDTnHnMn.nS".
```
Duration dur = Duration.parse("PT1M11.22S");
dur.getSeconds(); // return 71
dur.toSeconds(); // return 71 
dur.toMillis(); // return 71220
dur.getNano(); // return 220000000
dur.toNanos(); // return 71220000000
```
A Duration can also be negative
````
Duration dur = Duration.parse("-P1D1M11.22S");
dur.toString();
/*
  Output: PT-24H-1M-11.22S
*/
````
