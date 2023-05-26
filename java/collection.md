### Interfaces
````
                 Collection                    Map
                     |                          |
    -----------------------------------         |
    |           |         |            |        |
   Set       List      Queue        Deque   SortedMap
    |
 SortedSet

````



- EnumMap -- saves the elements internally as arrays, extremely compact and efficient
````
EnumMap<UPDATEOPERATION,List<User>> userUpdateOperations = new EnumMap<>(UPDATEOPERATION.class);
````
