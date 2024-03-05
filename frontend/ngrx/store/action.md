## Actions
Actions express ___unique events___ that happen throughout the application. From user interaction with page, external interaction through network requests, and direct interaction with device APIs, these and more events are described with actions. 

Actions are the inputs and outputs of many systems in NgRx. An `Action` is made uo of a simple interface:

```
interface Action {
  type: string;
}
```

The `type` property is for describing the action that will be dispatched in your application. The value of the type comes in the form `[Source] Event` where
- Source --- describes where an action was dispatched
- Evvent -- describes what category of action it is

