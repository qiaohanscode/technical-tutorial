## Selectors
Selectors are pure functions used for obtaining slices of store state. SElectors provide many features when selecting slices of state:
- Portablility
- Memoization
- Composition
- Testablility
- Type Safety

When using the `createSElector` and `createFeatureSelector` functions ___@ngrx/store___ keeps track of the latest arguments in which your selector function was involed. Because selectors are pure functions, the last result can be returned when the arguments match without reinvoking your selector function. This ccan provide performance benefits, particularly with selectors that perform expensive computation. This practice is known as memoization.

## Using a selector for one piece of state
```
import { createSelector } from '@ngrx/store';

export interface FeatureState {
  counter: number;
}

export interface AppState {
  feature: FeatureState;
}

# selector function for select FeatureState
export const selectFeature = (state: AppState) => state.feature;

# Selector for FeatureState
export const selectFeatureCount = createSelector(
  selectFeature,
  (state: FeatureState) => state.counter
);
```

## Using selectors for multiple pieces of state
The `createSelector` can be used to select some data from the state based on several slies of the same state.

The `createSelector` function can take up to 8 selector functions for more complete state selections.

For example, imagine you have a `selectedUser` object in the state. You also have an `allBooks`. They will aloways show the books that belongs to your user if there is one selectd and will show all the books when there is no user selected.

The result will be just some of your state filterd by another section of the state. And it will be always up to date.

```
import { createSelector } from '@ngrx/store';

export interface User {
  id: number;
  name: string;
}

export interface Book {
  id: number;
  userId: number;
  name: string;
}

export interface AppState {
  selectedUser: User;
  allBooks: Book[];
}

# selector function for selected user
export const selectUser = (state: AppState) => state.selectedUser;
# selector function for selected books
export const selectAllBooks = (state: AppState) => state.allBooks;

export const selectVisibleBooks = createSelector(
  selectUser,
  selectAllBooks,
  (selectedUser: User, allBooks: Book[]) => {
    if (selectedUser && allBooks) {
      return allBooks.filter((book: Book) => book.userId === selectedUser.id);
    } else {
      return allBooks;
    }
  }
);
```
