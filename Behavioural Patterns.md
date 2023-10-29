Behavioral design patterns are concerned with algorithms and the assignment of responsibilities between objects. They deal with object collaboration and the delegation of responsibilities.
1. **[[Chain of Responsibility]]**
    - **Use Case**: Decoupling the sender from receiver by allowing more than one object to handle a request. For instance, event handling systems in GUI libraries where events can be handled by any parent object in the GUI hierarchy.
2. **[[Command]]**
    - **Use Case**: Turning a request into a standalone object that contains information about the request. It's useful in GUI action buttons, macro recording, and undo functionality in applications.
3. **[[Interpreter]]**
    - **Use Case**: Evaluating language grammar or expressions for particular languages. This is used in compilers, interpreters, and IDEs for programming languages.
4. **[[Iterator]]**
    - **Use Case**: Providing a way to access elements of an aggregate object sequentially without exposing the underlying representation. Seen in collection objects like lists, trees, and graphs.
5. **[[Mediator]]**
    - **Use Case**: Reducing the coupling between classes by having them communicate indirectly through a mediator object. Common in chat room systems where multiple users can send messages to each other without being directly connected.
6. **[[Memento]]**
    - **Use Case**: Capturing and externalizing an object's internal state so that it can be restored later, without violating encapsulation. Useful in "undo" functionalities in software.
7. **[[Observer]]**
    - **Use Case**: Allowing an object to publish changes to its state so that other objects can react accordingly. Seen in event management systems, GUI libraries, and real-time data monitoring.
8. **[[State]]**
    - **Use Case**: Allowing an object to change its behaviour when its internal state changes. This pattern is used in applications like media players which can have different states (playing, paused, stopped) and behave differently in each state.
9. **[[Strategy]]**
    - **Use Case**: Defining a set of algorithms, encapsulating each one, and making them interchangeable. Useful in e-commerce checkout systems where multiple payment strategies can be selected, or graphics rendering where different rendering techniques can be switched in and out.
10. **[[Template Method]]**
    - **Use Case**: Defining the program skeleton in an algorithm in a method in an algorithm but delaying some steps to subclasses. Common in frameworks and libraries where certain steps of an algorithm are generalized, but allow for customization.
11. **[[Visitor]]**
    - **Use Case**: Adding further operations to objects without having to modify them. Useful in systems where new operations are required on objects, like a graphics editor that needs new tools or operations.
12. **[[Null Object]]**
    - **Use Case**: Providing an object as a surrogate for the lack of an object of a given interface. It's used in situations where a null object might cause undesirable behaviour or exceptions.

To add
- [[Operation Result]]