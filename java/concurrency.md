### autoboxing 
is the automatic conversion from primitive type to corresponding wrapper class, eg. int -> Integer, double -> Double

### unboxing 
is the automatic conversion the other direction, wrapper class to primitive type. Boolean to boolean, Byte to byte

### Concurrency

- Runnable: represents a Task without return value, without Exception
````
@FunctionalInterface
public interface Runnable {
    public abstract void run();
}
````
- Callable: represents a Task returns a value and may throw Exception
````
@FunctionalInterface
public interface Callable<V> {
    V call() throws Exception;
}
````
- Thread
<br/>causes the executing thread to be stopped. May throw InterruptedException, ClosedByInterruptException, or SecurityException.
````
Thread.interrupt()
```` 

#### Thread-Safety
different threads access the same resources without producing erroneous results or behaviour
- Synchronized Collections: uses monitor-lock (implicit lock) in each method. The methods can be accessed by only on thread at a time, in a synchronized manner. Java Collection Framework provides synchronized wrappers for creating thread-safe collection
````
java.util.Collections

public static <T> Collection<T> synchronizedCollection(Collection<T> c)
static <T> Collection<T> synchronizedCollection(Collection<T> c, Object mutex)
````
- Concurrent Collections: achieves thread-safety by dividing their data into segments. The package java.util.concurrent contains several concurrnt collections.
````
BlockingQueue, LinkedBlockingQueue
ConcurrentMap, ConcurrentHashMap
ConcurrentNavigableMap, ConcurrentSkipListMap
````
- Atomic Objects allow to perform atomic operation which will be executed in one single machine-level operation, withpout using synchronization.
````
AtomicInteger
AtomicLong
AtomicBoolean
AtomicReference
````
- Synchronized method and synchronized statement
````
public void incrementCounter() {
    // additional unsynchronized operations
    synchronized(this) {
        counter += 1;
    }
}
````
- Reentrant Locks: the package java.util.concurrent.locks provides Lock implementations which prevent queued threads from suffering deadlock or livelock
````
ReentrantLock
````
````
ReentrantReadWriteLock

private final rwLock = new ReeReentrantReadWriteLock();
private final readLock = rwLock.read();
private final writeLock = rwLock.writeLock();
...
readLock.lock();
...
writeLock.lock();
 
````

#### High Level Concurrency
````
java.util.concurrent.Executors
````
provides factory methods which create instance of implmentations of ExecutorService and ScheduledExecutorService
````
newFixedThreadPool
newCachedThreadPool: 0, Integer.MAX_VALUE
newSingleThreadExecutor
````
- Executor: declares only one method
````
void execute(Runnable command)
````

- ExecutorService: provides Methods to execute tasks asynchronous and return a Future
````
<T> List<Future<T>> invokeAll(Collections<? extends Callable<T>> tasks)
<T> List<FutureyT>> invokeAll(Collection<? extends Callable<T>> tasks, long timeout, TimeUnit unit);

<T> Future<T> submit(Callable<T> task)
<T> Future<T> submit(Runnable task, T result)
````

- ScheduledExecutorService: extends ExecutorService and provides methods to execute tasks repetitive
````
SchedledFuture<?> scheduleAtFixedRate(Runnable command, long initialDelay, long period, TimeUnit unit)
ScheduledFuture<?> scheduleWithFixedDelay(Runnable command, long initialDelay, long delay, TimeUnit unit)  

ScheduledFuture<?> schedule(Runnable command, long delay, TimeUnit unit)
ScheduledFuture<T> schedule(Callable<V> command, long delay TimeUnit unit) 
  ````
- Future<T>: is an interface, provides methods to cancel the task, get the result of execution and asks if the execution has been finished
````
boolean cancel(boolean mayInterruptIfRunning)
V get() -- blocking further processing of the current thread until task is finished 
V get(long timeout, TimeUnit unit)
boolean isCancelled()
boolean isDone()
````

- ScheduledFuture<T>: extends the interface Future<V> and provides methods for asking result of delayed tasks
- ````
  long getDelay(TimeUnit unit) -- returns the remaining delay associated with this object in the given time unit 
  ````
