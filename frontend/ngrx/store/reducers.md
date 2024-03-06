## Reducers
Reducers in NgRx are responsible for handling transitions from one state to the next state in your application. Reducer functions handle these transitions by determining which ___actions___ to handle based on the action's type.

`Note: ` for more details see [NgRx Reducers](https://ngrx.io/guide/store/reducers).
## Introduction
Reducers are pure functions in that they produce the same output for a given input. They are without side effects and handle each state transition synchronously. Each reducer function takes the latest `Action` dispatched, the current state, and determines whether to return a newly modified state or the original state. This guide shows you how to write reducer functions, register them in your `Store` and compose feature states. 

## The reducer function
There are a few consistent parts of every piece of state managed by a reducer,
- An interface or type that defines the shape of the state.
- The arguments including the initial state or current state and the current action
- The functions that handle state changes for their associated action(s).

Below is an example of a set of actions to handle the state of a scoreboard, and the associated reducer function.

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
In the example above, the reducer is handling 4 actions. Each action is strongly-typed. Each action handels the stat transition immutably. This means that hte state transitions are not modiying the original state, but are returning a new state object using the ___spread operator___.

`Note:.` The spread operator only does shallow copying and does not handle deeply nested objects. you need to copy each level in the object to ensure immutability. There are libraries that handle deep copying including [lodash](https://lodash.com/) and [immer](https://github.com/mweststrate/immer)

when an action is dispatched, all registered reducers receive the actions. Whether they handle te action is determined by the `on` functions that associate one or more actions with a given state change.



## Registering root state
The state of yor application is defined as one large object. Registering reducer functions to manage parts of your state only defines keys with associated values in the object. To register the global `Store` within your application, used the `StoreModule.forRoot()` method with a map of key/value pairs that define your state. The `StoreModule.forRoot()` registers the global providers for your application, including the `Store` service you inject into your components and services to dispatch actions and select pieces of state.

`app.modules.ts`
```
import { NgModule } from '@angular/core';
import { StoreModule } from '@ngrx/store';
import { scoreboardReducer } from './reducers/scoreboard.reducer';

@NgModule({
  imports: [
    StoreModule.forRoot({ game: scoreboardReducer })
  ],
})
export class AppModule {}
```

Registering states with `StoreModule.forRoot()` ensures that the states are defined upon application startup. In general, you register root states that always need to be available to all areas of your application immediately.

## Using the standalone API
Registering the root store and state can also be done using the standalone APIs if you are boostrapping an Angular application using standalone features.

`main.ts`
```import { bootstrapApplication } from '@angular/platform-browser';
import { provideStore, provideState } from '@ngrx/store';

import { AppComponent } from './app.component';
import { scoreboardReducer } from './reducers/scoreboard.reducer';

bootstrapApplication(AppComponent, {
  providers: [
    provideStore(),
    provideState({ name: 'game', reducer: scoreboardReducer })
  ],
});
```

## Registering feature state
Feature states behave in the same way root states do, but allow you to define them with spedific feature areas in your application. Your state is one large object, and feature states register additional keys and values in that object.

The follwoing example shows how a feature state allows your state to be built up incrementally. Let''s start with an empty state object.
`Note: ` this tutorial describes the approch for standalone API. For module based application see [NgRx Reducer Registering feature State](https://ngrx.io/guide/store/reducers#registering-feature-state).

`main.ts`
```
import { bootstrapApplication } from '@angular/platform-browser';
import { provideStore } from '@ngrx/store';

import { AppComponent } from './app.component';

bootstrapApplication(AppComponent, {
  providers: [
    provideStore()
  ],
});
```

This registers your application with n empt y object for the root state.
```
{
}
```

Now use the `scoreboard` reducer with a feature `NgModule` named `ScoreboardModule` to register additional state.

`scoreboard.reducer.ts`
```
export const scoreboardFeatureKey = 'game';
```

Feature states are registered in the `providers` array of the route config.

`game-routers.ts`
```
import { Route } from '@angular/router';
import { provideState } from '@ngrx/store';

import { scoreboardFeatureKey, scoreboardReducer } from './reducers/scoreboard.reducer';

export const routes: Route[] = [
  {
    path: 'scoreboard',
    providers: [
      provideState({ name: scoreboardFeatureKey, reducer: scoreboardReducer })
    ]
  }
];
```
`Note: ` It is recommended to abstract a feature key string to prvent hardcoding strings when registering feature state and calling [createFeatureSelector](https://ngrx.io/api/store/createFeatureSelector). Alternatively, you can use a [Feature Creator](https://ngrx.io/guide/store/feature-creators) which automatically generates seletors for your feature state.

Using Standalone API, register the feature state on application bootstrop:

`main.ts`
```
import { bootstrapApplication } from '@angular/platform-browser';
import { provideStore } from '@ngrx/store';

import { AppComponent } from './app.component';
import { scoreboardFeatureKey, scoreboardReducer } from './reducers/scoreboard.reducer';

bootstrapApplication(AppComponent, {
  providers: [
    provideStore({ [scoreboardFeatureKey]: scoreboardReducer }),
  ]
});
```

After the feature is loaded, the `game` key becomes a property in the object and is now manged in the state.
```
{
  game: { home: 0, away: 0 }
}
```
Whether your feature states are loaded eagerly or lazily depends on the needs of your application. You use feature states to build up your state object over time and through different feature areas.
