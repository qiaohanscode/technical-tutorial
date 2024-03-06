## Reducers
Reducers in NgRx are responsible for handling transitions from one state to the next state in your application. Reducer functions handle these transitions by determining which ___actions___ to handle based on the action's type.

## Introduction
Reducers are pure functions in that they produce the same output for a given input. They are without side effects and handle each state transition synchronously. Each reducer function takes the latest `Action` dispatched, the current state, and determines whether to return a newly modified state or the original state. This guide shows you how to write reducer functions, register them in your `Store` and compose feature states. 

## The reducer function
There are a few consistent parts of every piece of state managed by a reducer,
- An interface or type that defines the shape of the state.
- The arguments including the initial state or current state and the current action
- The functions that handle state changes for their associated action(s).

Bwlow is an example of a set of actions to handle the state of a scoreboard, and the associated reducer function.

First, define some actions for interacting with a piece of state,

`scoreboard-page.actions.ts`
```
import { createAction, props } from '@ngrx/store';

export const homeScore = createAction('[Scoreboard Page] Home Score');
export const awayScore = createAction('[Scoreboard Page] Away Score');
export const resetScore = createAction('[Scoreboard Page] Score Reset');
export const setScores = createAction('[Scoreboard Page] Set Scores', props<{game: Game}>());
```
Next, create a reducer file that imports the actions and define a shape for the piece of state.

## Defining the state shape
Each reducer function is a listener of actios. The scoreboard actions defined above describe the possible transitions handled by the reducer. Import multiple sets of actions to handle additional state transitions within a reducer,

`scoreboard.reducer.ts`
```
import { Action, createReducer, on } from '@ngrx/store';
import * as ScoreboardPageActions from '../actions/scoreboard-page.actions';

# Define the shape of the state according to what you are capturing, whether it be a single type such as a number,
# or a more complex object with nultiple properties.
export interface State {
  home: number;
  away: number;
}
```

## Setting the initial state
The initial state gives the state an initial value, or provides a value if the current state is `undefined`. You set the initial state with defauts for your required state properties.

`scoreboard.reducer.ts`
```
# create and export a variable to capture the initial state with one or more default values
export const initialState: State = {
  home: 0,
  away: 0,
};
```

## Creating the reducer function
The reducer function's responsibility is to handle the state transitions in an immutable way. 

`scoreboard.reducer.ts`
```
# Create a reducer function that handles the actions for managing the state of the scoreboard using the `createReducer` function
export const scoreboardReducer = createReducer(
  initialState,
  on(ScoreboardPageActions.homeScore, state => ({ ...state, home: state.home + 1 })),
  on(ScoreboardPageActions.awayScore, state => ({ ...state, away: state.away + 1 })),
  on(ScoreboardPageActions.resetScore, state => ({ home: 0, away: 0 })),
  on(ScoreboardPageActions.setScores, (state, { game }) => ({ home: game.home, away: game.away }))
);
```
In the wxample above, the reducer is handling 4 actions. Each action is strongly-typed. Each action handels the stat transition immutably. This means that hte state transitions are not modiying the original state, but are returning a new state object using the ___spread operator___.

`Note:.` The spread operator only does shallow copying and does not handle deeply nested objects. you need to copy each level in the object to ensure immutability. There are libraries that handle deep copying including [lodash])[https://lodash.com/) and [immer](https://github.com/mweststrate/immer)
