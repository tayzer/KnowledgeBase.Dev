Structural design patterns are concerned with how classes and objects are composed to form larger structures. They simplify the structure by identifying the relationships.
1. **[[Adapter]]**
    - **Use Case**: Allowing two incompatible interfaces to work together. It's often used when new classes need to be integrated with existing classes that have incompatible interfaces.
2. **[[Bridge]]**
    - **Use Case**: Separating an object's abstraction from its implementation so that the two can vary independently. For example, it can be used in graphics and windowing systems to decouple an interface from an underlying platform.
3. **[[Composite]]**
    - **Use Case**: Building complex objects from simple ones recursively. Used when clients should treat individual objects and compositions of objects uniformly, like in graphical systems where shapes can be simple or complex.
4. **[[Decorator]]**
    - **Use Case**: Adding responsibilities to individual objects dynamically and selectively without affecting other objects. Often seen in GUI libraries to add properties or methods to visual components.
5. **[[Facade]]**
    - **Use Case**: Simplifying a complex system by providing a unified high-level interface to a set of interfaces in a subsystem. Commonly used in computer operating systems where a simple method call initiates a series of complex actions.
6. **[[Flyweight]]
    - **Use Case**: Reducing the number of objects created by sharing objects. It's useful in systems where large numbers of similar objects are needed, leading to high overhead, like in graphics rendering systems where each pixel could be an object.
7. **[[Proxy]]**
    - **Use Case**: Providing a substitute or placeholder for another object to control access to it. Use cases include lazy instantiation, logging, access control, and remote object access.
8. **[[Private Class Data]]**
    - **Use Case**: Restricting the write access to class attributes. This pattern separates data from methods that use it, encapsulating class data initialization, reducing the exposure of attributes by limiting their visibility, and providing a cleaner interface.
9. **[[Module]]**
    - **Use Case**: Breaking up code into modular parts in languages that don't natively support module constructs. Commonly used in JavaScript to keep individual modules concise, preventing namespace pollution and allowing for better organization.