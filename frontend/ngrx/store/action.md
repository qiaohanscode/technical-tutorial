## Actions
## Introduction
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

## Writing actions
There are a few rules to write good actios wthin you application,
- Upfront -- write actions before developing feature to understand and gain a shared knowleedge of the feature being implemented.
- Divide -- categorize actions based on the event source
- Many --- actions are inexpensive to write, so the more actions you write, the better you express flows in your application
- Event-Driven -- capture events ___not___ commands as you are separating the description of an event and the handling of that event.

An Example

___login-page.actions.ts___
```
import { createAction, props } from '@ngrx/store';

export const login = createAction(
  '[Login Page] Login',
  props<{ username: string; password: string }>()
);

```

The `createAction` function returns a function, that when called returns an object in the shape of the `Action` interface. The `prop` method is used to define any additional metadata needed for the hadling of the action. Action creators provide a consistent, type-safe way to construct an action that is being dispatched.

Use the action creator to return the `Action ` when dispatching.

`login-page.componentts`
```
onSubmit(username: string, password: string) {
  store.dispatch(login({username: username, password: password}));
}
```

The `login` action creator receeives an object of `username` and `password` and returns a plain JavaScript object with a `type` property of `[Login Page] Login`, with `username` and `password` as additional properties. The returned action has very specific context about where the ation came from and what event happended.
- The category of the action is captured within the squared brckets `[]`.
- The caategory is used to group actions for a particular area, whether it be a component page, bckend API, or browser API.
- The `Login` text after the category is a description about what event occurred fom this action.

