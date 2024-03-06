## What is an NgRx feature?
There are three main building blocks of global state management with ___@ngrx/store___: actions, reducers, and selectors. 
For a particular feature state, we create a reducer for handling state transitions based on the dispatched actions 
and selectors to obtain slices of the feature state. Also, we need to define a feature name needed to register 
the feature reducer in the NgRx store. Therefore, we can consider the NgRx feature as a grouping of 
the feature name, feature reducer, and selectors for the particular feature state.

## Using feature creator
The createFeature function reduces repetitive code in selector files by generating a feature selector and child selectors for each feature state property. It accepts an object containing a feature name and a feature reducer as the input argument:
