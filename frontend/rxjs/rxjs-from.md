### from
Creates an `Observable` from an Array, an array-like object, a `Promise`, an iterable object, or an `Observable`-like 
object. `from`converts almost anything to an `Observable`.
```
from<T>(input: ObservableInput<T>, scheduler?: SchedulerLike): Observable<T>
```
