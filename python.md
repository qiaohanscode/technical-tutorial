### Python ORM sqlalchemy
### Class and Instance Variables
instance varialbes are for data unique to each insance and class variables are for attributes
and methods shared by all instances of the class
```
class Dog:

    kind = 'canine'         # class variable shared by all instances

    def __init__(self, name):
        self.name = name    # instance variable unique to each instance
```
