## Reducers
Reducers in NgRx are responsible for handling transitions from one state to the next state in your application. Reducer functions handle these transitions by determining which ___actions___ to handle based on the action's type.

## Introduction
Reducers are pure functions in that they produce the same ougput for a given input. They are without side effects and handle each state transition synchronously. Each reducer function takes the latest `Action` dispatched, the current state, and determines whether to return a newly modified state or the original state. This guide shows you how to write reducer functions, register them in your `Store` and compose feature states. 
