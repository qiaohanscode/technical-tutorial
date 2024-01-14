- doCallRealMethod() -- not the recommended way of creating partial mocks, using spy() for this case
````
public static Stubber doCaallRealMethod()
````

- @Spy -- create a spy of a real object. With spy the real method will be called unless a method is stubbed.
````
@Spy
private UserService spiedUserService;

//optionally, stub the method
when(userService.readUserFromDB(any()).thenReturn(userCreated);

//calls the real method
spiedUserService.createUser("Robert","Meyer");
````
