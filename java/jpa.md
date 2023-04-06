Jakarta Persistence API

Persistence context describe the state of persistent data:
- transient: object has just been instantiated und is not associated with persistence context
- managed or persistent: object is associated with persistence context, may or may not have persistent representation in database
- detachted: is no longer assciated with persistence context (was associated with persistence context) because persistence context was closed or the instance was removed from persistence context
- removed: is associated with persistence context and is scheduled for removal from database

@Query(value="from User u where u.vorname=:vorname and u.name=?1)
