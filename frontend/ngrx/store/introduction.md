NgRx Store provides a global state management through the use of a single state and actions to express state changes. The managed state is application-wide available. For local state management use [NgRx ComponentStore](https://ngrx.io/guide/component-store).

A good guideline might help anser the question, "Do I need NgRx Store?",
- Shared: state that is accessed by many components and services
- Hydrated: state that is persisted and rehydrated from external storage
- Available: state that nneds to be available when re-entering routes
- Retrieved: stathe that must be retrieved with a side-effect
- Impact: state that is impacted by actions fro oehter sources

Store is RxJS powered global state management for Angular applications, inspired by Redux.

Key concepts 
- Actions describe unique events that are dispatched from components and services.
- State changes are handled by pure functions called reducers that take the current state an the latest action to compute a new state
- Selectors are pure functions used to select, derive and comoose pieces of state
- State is accessed with the `Store`, an observable of state and an observer of actions.

