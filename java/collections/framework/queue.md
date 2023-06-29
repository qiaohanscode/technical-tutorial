### The Queue Interface
A Queue is a collection that typically, but not necessarily, order elements in a FIFO (first-in-first-out) manner.

#### Queue Interface Structure
- insert operation
````
add(e)
offer(e)
````
- remove operation 
````
remove()
poll()
````
- examine operation
````
element()
peek()
````
#### General-Purpose Queue Implementations
- LinkedList
- PriorityQueue

#### Concurrent Queue Implementations
- LinkedBlockingQueue
- ArrayBlockingQueue
- PriorityBlockingQueue
- DelayQueue
- SynchronousQueue


