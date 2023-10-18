## Intent
The Singleton pattern ensures a class has only one instance and provides a global point of access to it. This is particularly useful when exactly one object is needed to coordinate actions across the system.
## Also Known As
Solitaire
## Problem
Some class instances are meant to be unique due to their nature: for instance, configuration objects, thread pools, and caches. Instantiating multiple objects in such scenarios might lead to unexpected results, increased complexity, or additional resource consumption.
## Solution
The Singleton pattern restricts instantiation of a class to a single object. This single instance is created upon the first request and re-used for all subsequent requests. The class itself ensures that no other instance can be created, typically by making the constructor private.
## Applicability or When to Use
- When a single shared instance of a class is sufficient for all uses.
- When controlling access to a resource which is shared by multiple parts of a program.
## Structure
![Diagram](link-to-your-singleton-diagram-image)
The structure shows the Singleton class with the mechanism (like a static method) to create and return the same instance.
## Participants
- **Singleton**: The class that has the mechanism to prevent any other object instantiation (through private constructors, for example), and provides a way to access its sole instance.
## Collaborations
Clients access the Singleton instance solely through the Singleton’s class operation (getInstance).
## Consequences
**Pros**:
- Controlled access to the sole instance.
- Reduced namespace.
- Permits refinement of operations and representation.
- Permits a variable number of instances (including multiple instances for testing).
**Cons**:
- Development and testing can be complicated due to global state.
- Considered an anti-pattern by some for promoting global state and violating single responsibility principle (when used inappropriately).
## Known Uses
- Database connections (connection pools).
- Logger classes.
- Configuration objects.
- Common caches and thread pools.
## Related Patterns
- **Abstract Factory**, **Builder**, and **Prototype** can be implemented as Singletons when the application needs only one instance of these patterns.
- **Facade Pattern**: Often, a facade object can be a Singleton because only one facade object is required.
