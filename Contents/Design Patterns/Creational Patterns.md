Creational design patterns deal with object creation mechanisms, aiming to create objects in a manner suitable to the situation.
1. **[[Singleton]]**
    - **Use Case**: Ensuring that a class has only one instance and providing a global point to access this instance. Commonly used for logging, driver objects, caching, thread pools, and database connections.
2. **[[Factory Method]]**
    - **Use Case**: Creating an instance of several derived classes based on interfaced data or events. It's useful when the system needs to be independent of how its objects are created, composed, and represented, and when the class cannot anticipate which kind of class of objects it is supposed to create.
3. **[[Abstract Factory]]**
    - **Use Case**: Creating an object from several families of classes. Useful when the system needs to be independent of how its objects are created, composed, and represented and the system is configured with multiple families of objects.
4. **[[Builder]]**
    - **Use Case**: Separating the construction of a complex object from its representation so that the same construction process can create different representations. Commonly used for constructing composite representations or when an object needs to be created with various optional components or configurations.
5. **[[Prototype]]**
    - **Use Case**: Creating a fully initialized instance that can be cloned or copied to produce a derivative instance. Useful when instances of a class can have only a few different combinations of state, and it's more convenient to install a corresponding number of prototypes and clone them rather than instantiating the class manually each time with the appropriate state.
6. **Object Pool**
    - **Use Case**: Reusing objects that are expensive to create. Instances of a class will be pooled and reused, rather than creating and destroying them continually. Commonly used in scenarios that require a large number of objects that are only needed for short periods of time, such as database connections or thread pools.