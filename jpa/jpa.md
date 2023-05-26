## Jakarta Persistence API

### Persistence context 
describe the state of persistent data:
- transient: object has just been instantiated und is not associated with persistence context
- managed or persistent: object is associated with persistence context, may or may not have persistent representation in database
- detachted: is no longer assciated with persistence context (was associated with persistence context) because persistence context was closed or the instance was removed from persistence context
- removed: is associated with persistence context and is scheduled for removal from database

````
@Query(value="from User u where u.vorname=:vorname and u.name=?1)
````
### Dirty read

### Optimistic Locking: 
  - corresponds read-committed isolation, ensures no intervening transaction has updated that data since the entity state was read. 
  - Checked by flush or commit, OptimisticLockException will be thrown in the "before completion" phase of the commit by violation. 
  - Enabled with Version (@Version) field.
  - PersistenceException will be thrown, if database does not support this lock mode
  - OptimisticLockException always cause the transaction to be rollback

### Pessimistic Locking: 
  - aka. long-term database lock. No other transaction may successfully read, modify or delete that instance until the transaction holding the lock has ended.
  - relationship modeled with foreign key will also be locked.
  - PessimisticLockException will be thrown when the lock cannot be obtained and the transaction muss be rollback.
  - PersistenceException will be thrown, if lock can't be obtained or database does not support this lock mode

### Lock Mode
- defined in the enum jakarta.persistence.LockModeType
- has following items:
````
READ, -- synonymous with OPTIMISTIC
WRITE, -- synonymous with OPTIMISTIC_FORCE_INCREMENT
OPTIMISTIC,
OPTIMISTIC_FORCE_INCREMENT, -- force an update on the version column
PESSIMISTIC_READ, -- long-term read lock, 
PESSIMISTIC_WRITE, -- may cause deadlock
PESSIMISTC_FORCE_INCREMENT,
NONE
````
