Implementations of ``Collector`` that implement various useful operations.

```
public static <T, K, U>
Collector<T, ?, Map<K,U>> toMap(Function<? super T, ? extends K> keyMapper,
                                    Function<? super T, ? extends U> valueMapper) {
    return new CollectorImpl<>(HashMap::new,
                               uniqKeysMapAccumulator(keyMapper, valueMapper),
                               uniqKeysMapMerger(),
                               CH_ID);
}
  ```
Returns a Collector that accumulates elements into a Map whose keys and values are the result of applying the provided mapping functions to the input elements. 
- if the mapped keys contain duplicates (according to Object.equals(Object)), an IllegalStateException is thrown when the collection operation is performed.
- if the mappled keys might have duplicates, use ``toMap(Function,Function,BinaryOperator)`` instead.
- The returned Collector is not concurrent. For parallel stream pipelines, using ``toConcurrentMap(Function,Function)`` may offer better parallel performance.
