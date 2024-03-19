## Dynamic object property
Since ES6, you can define dynamic property for object
```
export type JoinConfiguration = {
  selectionMode: 'TABLE';
  tableSelection: {
    [tableName: string]: TimeSelection;
  };
};

export type TimeSelection = {
  years: string[];
  time: string[];
};
```

To create object with dynamically computed properties. The object ___accumulator___ gets a property for each element 
of the array ___selectedTables___. Every so computed property has the name of an element of the array.

```
const createTableConfiguration = (
  selecteTables: string[]
): JoinConfiguration => ({
  selectionMode: 'TABLE',
  tableSelection: selectedTables.reduce(
    (accumulator: { [tableName: string]: TimeSelection }, curSelectedTable) => {
      accumulator[curSelectedTable] = { fiscalYears: [], timeframes: [] };
      return accumulator;
    },
    {}
  )
});
```
