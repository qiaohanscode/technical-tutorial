## Actions
Actions express ___unique events___ that happen throughout the application. From user interaction with page, external interaction through network requests, and direct interaction with device APIs, these and more events are described with actions. 

Actions are the inputs and outputs of many systems in NgRx. An `Action` is made uo of a simple interface:

```
interface Action {
  type: string;
}
```

