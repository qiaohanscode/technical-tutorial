there are four types of nested classes
- static nested class
- no static nested class (i.e. inner class)
- local class
- anonymous class

#### Static Nested Class
- belongs to their enclosing class, and not to an instance of the class
- can have all types o access modifiers in their declaration
- only have access to static members in the enclosing class
- can define both static and non-static members
````
public class Enclosing {
    
    private static int x = 1;
    
    public static class StaticNested {

        private void run() {
            // method implementation
        }
    }
    
    @Test
    public void test() {
        Enclosing.StaticNested nested = new Enclosing.StaticNested();
        nested.run();
    }
}
````
#### Non-static Nested Class (i.e. inner class)
- can have all types of access modifiers in their declaration
- just like instance variables and methods, inner classes are associated with an instance of the enclosing class
- have access to all members (static and non-static) of the enclosing class
- can only define non-static members
````
public class Outer {
    
    public class Inner {
        // ...
    }
}
````

#### Local Class
local classes are a special type of inner classes - in which the clas is defined inside a method or scope block.
- cannot have access modifiers in their declaration
- have access to both static and non-static members in the enclosing context
- can only define instance members
````
public class NewEnclosing {
    
    void run() {
        class Local {

            void run() {
                // method implementation
            }
        }
        Local local = new Local();
        local.run();
    }
    
    @Test
    public void test() {
        NewEnclosing newEnclosing = new NewEnclosing();
        newEnclosing.run();
    }
}
````

#### Anonymous Class
Anonymous classes can be used to define an implementation of an interface or an abstract class without having to create a reusable implementation.
- cannot have access modifiers in their declaration
- have access to both static and non-static members in the enclosing context
- can only define instance members
- are the only type of nested casses that cannot define constructors or extend/implement other classes or interfaces
````
abstract class SimpleAbstractClass {
    abstract void run();
}
````
````
public class AnonymousInnerUnitTest {
    
    @Test
    public void whenRunAnonymousClass_thenCorrect() {
        SimpleAbstractClass simpleAbstractClass = new SimpleAbstractClass() {
            void run() {
                // method implementation
            }
        };
        simpleAbstractClass.run();
    }
}
````
#### Shadowing
the declaration of the members of an inner class shadow those of the enclosing class if they have the same name
````
public class NewOuter {

    int a = 1;
    static int b = 2;

    public class InnerClass {
        int a = 3;
        static final int b = 4;

        public void run() {
            System.out.println("a = " + a);
            System.out.println("b = " + b);
            System.out.println("NewOuterTest.this.a = " + NewOuter.this.a);
            System.out.println("NewOuterTest.b = " + NewOuter.b);
            System.out.println("NewOuterTest.this.b = " + NewOuter.this.b);
        }
    }

    @Test
    public void test() {
        NewOuter outer = new NewOuter();
        NewOuter.InnerClass inner = outer.new InnerClass();
        inner.run();

    }
}
````
#### Serialization
To avoid a java.io.NotSerializableException while attempting to serialize a nested class, we should
- Declare the nested class as static

    or
- Make both the nested class and the enclosing class implement Serializable







