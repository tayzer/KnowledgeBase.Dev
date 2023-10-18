## Intent
The Bridge pattern is meant to decouple an abstraction from its implementation so that the two can vary independently. This promotes flexibility and segregates responsibilities into different classes.
## Also Known As
Handle/Body
## Problem
When an abstraction and its implementation need to vary, hard-wiring the specific implementation to the abstraction can make the code inflexible and difficult to adapt to new requirements. Both components then become tightly coupled, hindering independent scalability and feature expansion.
## Solution
The Bridge pattern involves separating the abstraction from its implementation by creating two different hierarchies – one for the abstractions and one for the implementations. An interface ensures that the implementation will be decoupled from the abstraction, and both can be extended independently.
## Applicability or When to Use
- When you want to avoid a permanent binding between an abstraction and its implementation. This might be the case when the implementation must be selected or switched at run-time.
- Both the abstractions and their implementations should be extendable by subclassing. In this case, the Bridge pattern lets you combine the different abstractions and implementations and extend them independently.
- Changes in the implementation of an abstraction should have no impact on clients; that is, their code should not have to be recompiled.
## Structure
![Diagram](link-to-your-bridge-diagram)

The structure typically involves an Abstraction, RefinedAbstraction, Implementor, and ConcreteImplementor.
## Participants
- **Abstraction**: Defines the abstraction's interface and maintains a reference to an object of type Implementor.
- **RefinedAbstraction**: Extends the interface defined by Abstraction.
- **Implementor**: Defines the interface for implementation classes. This interface doesn't have to correspond exactly to Abstraction's interface; the two interfaces can be quite different.
- **ConcreteImplementor**: Implements the Implementor interface and defines its concrete implementation.
## Collaborations
- Abstraction forwards client requests to its Implementor object.
## Consequences
- Decoupling interface and implementation: Clients aren't locked into a single implementation, and any Implementor can be used with the same Abstraction.
- Improved extensibility: You can extend both the Abstraction and the Implementor hierarchies independently.
- Hiding implementation details from clients: Clients interact with the Abstraction, not the Implementor, thus implementation details are hidden from clients.
## Known Uses
- GUI toolkits and frameworks use the Bridge pattern to separate widgets from windowing systems, allowing multiple platforms to be supported without duplicating code.
- Database connectivity through drivers and APIs (like JDBC in Java environments) often employs this pattern to provide support for different databases.
## Related Patterns
- Adapter: Makes unrelated interfaces work together. It is usually applied to systems after they're designed. Bridge, on the other hand, is used up-front in a design to let abstractions and implementations vary independently.
