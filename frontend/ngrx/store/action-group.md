## Action Groups
The ___createActionGroup___ function creates a group of action creators with the same source. 
It accepts an action group source and an event dictionary as input arguments, where an event 
is a key-value pair of an event name and event props.
```
import { createActionGroup, emptyProps, props } from '@ngrx/store';

export const ProductsPageActions = createActionGroup({
  source: 'Products Page',
  events: {
    // defining an event without payload using the `emptyProps` function
    'Opened': emptyProps(),

    // defining an event with payload using the `props` function
    'Pagination Changed': props<{ page: number; offset: number }>(),

    // defining an event with payload using the props factory
    'Query Changed': (query: string) => ({ query }),
  },
});
```