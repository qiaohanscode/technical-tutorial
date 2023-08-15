#### ZoneId
The class ZoneId represents the time zone
````
public static Set<String> getAvailableZoneIds();
````

#### LocalDateTime & LocalDate
LocalDateTime and LocalDate contain no information about the used time zone. <br>
After instantiation the time zone of a LocalDateTime/LocalDate object can not be changed anymore.

````
var ltNow = LocalDateTime.now(ZoneId.of("Europe/Berlin"));
````

#### ZonedDateTime
The class ZonedDateTime contains information about the used time zone which may be modified after instantiation. But the modification of time zone will not cause the represented date and time to be modified, it only causes the time offset to be modified.
````
var ztDeu = ZonedDateTime.of(LocalDateTime.now(),ZoneId.of("Asia/Shanghai"));

/* notice, the created instance will represent the current local date time of the default system time zone 
(e.g. Europe/Berlin) with a time offset corresponding to the given time zone Asia/Shanghai  */
````

````
var ztShanghai = ZonedDateTime.now(ZoneId.of("Asia/Shanghai"));

/* notice, the created instance represents the current local date time of the time zone Asia/Shanghai
*/
````
