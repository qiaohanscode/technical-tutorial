## What is an NgRx feature?
There are three main building blocks of global state management with ___@ngrx/store___: actions, reducers, and selectors. 
For a particular feature state, we create a reducer for handling state transitions based on the dispatched actions 
and selectors to obtain slices of the feature state. Also, we need to define a feature name needed to register 
the feature reducer in the NgRx store. Therefore, we can consider the NgRx feature as a grouping of 
the feature name, feature reducer, and selectors for the particular feature state.

## Using feature creator
The createFeature function reduces repetitive code in selector files by generating a feature selector and child selectors for each feature state property. It accepts an object containing a feature name and a feature reducer as the input argument:

`books.reducer.ts`
```
import { createFeature, createReducer, on } from '@ngrx/store';
import { Book } from './book.model';

import * as BookListPageActions from './book-list-page.actions';
import * as BooksApiActions from './books-api.actions';

interface State {
  books: Book[];
loading: boolean;

inst initialState: State = {
  books: [],
  loading: false
};  

export const booksFeature = createFeature({
  name: 'books',
  reducer: createReducer(
    initialState,
    on(BookListPageActions.enter, (state) => ({
      ...state,
      loading: true
    }))
  )
});

export const {
  name, // feature name
  reducer, // feature reducer
  selectBooksState, // feature selector
  selectBooks, // selector for books property
  selectLoading, // selector for loading property
} = beeoksFeature;
```

An object created with the `createFeature` function contains a feature name, a feature reducer, a feature selector, and a selector for each feature state property. All generated selectors have the "select" prefix, and the feature selector has the "State" suffix. In the examle abouve, the name of the feature seletor is selectBooksState, the names of the child selectors are `selectBooks` and `selectLoading`.

The generated selectors can be used to create other selectors:
```
import {createSelector} from '@ngrx/store';
import { booksFeature } from './books.reducer';

export const selectBookListPageViewModel = createSelector(
  booksFeature.selectBooks,
  booksFeature.selectLoading,
  (books, loading) => ({books, loading})
);
```

## Feature Registration
Registerung the feature can be done using the standaloe APIs. For registeration for module based application see [NgRx Feature Registration](https://ngrx.io/guide/store/feature-creators#feature-registration).

`main.ts`
```
import { bootstrapApplication } from '@angular/platform-browser';
import { provideStore, provideState } from '@ngrx/store';

import { AppComponent } from './app.component';
import { booksFeature } from './books.reducer';

bootstrapApplication(AppComponent, {
  providers: [
    provideStore(),
    provideState(booksFeature)
  ],
});
```

Feature states can slso be registered in the `providers` array of the route config.
`books-routes.ts`
```
import { Route } from '@angular/router';
import { provideState } from '@ngrx/store';

import { booksFeature } from './books.reducer';

export const routes: Route[] = [
  {
    path: 'books',
    providers: [
      provideState(booksFeature)
    ]
  }
];
```

## Restrictions
The `createFeature` function cannot be used for features whose state contains optional properties. In other words, all state properties have to be passed to the initial state object. 

So, if the state contains optional properties, each optional symbol (?) have to be replaced with `| null` or `| undefined`.

`books.reducer.ts`
```
interface State {
  books: Book[];
  activeBookId: string | null;
  // or activeBookId: string | undefined;
}

const initialState: State = {
  books: [],
  activeBookId: null,
  // or activeBookId: undefined,
};
```
