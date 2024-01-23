### Subjects

An RxJS `Subject` is a special type of `Observable` that allows values to be multicasted to many `Observers`. While plan `Observables` are unicast (each subscribed `Observer` owns an independent execution of the `Observable`), `Subjects` are multicast.

- `Every Subject is an Observable`. Given a `Subject`, you can `subscribe` to it, providing an `Observer`, which will start receiving values. It works like `addListener` in other libraries and languages.

- `Every Subject is an Observer`. It is an object with `next(v)`, `error(e)`, and `complete()`.

```
import { Subject } from 'rxjs';

const subject = new Subject<number>();

subject.subscribe({
  next: (v) => console.log(`observerA: ${v}`),
});
subject.subscribe({
  next: (v) => console.log(`observerB: ${v}`),
});

subject.next(1);
subject.next(2);

// Logs:
// observerA: 1
// observerB: 1
// observerA: 2
// observerB: 2
```
