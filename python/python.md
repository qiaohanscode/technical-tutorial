### Python ORM sqlalchemy
```
from sqlalchemy import Connection, select
from sqlalchemy.orm import Session
```

### Rest API Framework -- FastAPI 

### Class and Instance Variables
`instance varialbes` are for data unique to each insance and `class variables` are for attributes
and methods shared by all instances of the class
```
class Dog:

    kind = 'canine'         # class variable shared by all instances

    def __init__(self, name):
        self.name = name    # instance variable unique to each instance

>>> d = Dog('Fido')
>>> e = Dog('Buddy')
>>> d.kind                  # shared by all dogs
'canine'
>>> e.kind                  # shared by all dogs
'canine'
>>> d.name                  # unique to d
'Fido'
>>> e.name                  # unique to e
'Buddy'
```
`instance variable` can theoritically be defined every where, it will normally be defined within the `__init__` methode.
https://docs.python.org/3/tutorial/classes.html#class-and-instance-variables
