## Intent
The Prototype pattern is used to create new objects by copying an existing object, known as the prototype. This method is particularly useful when creating an object is more resource-intensive than copying one.
## Also Known As
Clone Pattern
## Problem
Creating objects can be a resource-intensive process, both in terms of computing power and coding overhead, particularly when objects must have similar initial states. The overhead can be excessive when objects need to be created at runtime with dynamic conditions.
## Solution
The Prototype pattern delegates the cloning process to the actual objects that are being cloned. This pattern involves creating a new object by copying an existing object and then possibly making further modifications. This is typically implemented via a common interface that all prototype objects implement.
## Applicability or When to Use
- When the classes you need to create objects of are determined at runtime.
- When you want to avoid building a factory hierarchy or when instances of a class can have only one of a few different combinations of state.
## Structure
![Diagram](link-to-your-prototype-diagram-image)
The structure typically involves a Prototype interface which declares the clone method, and ConcretePrototype classes that implement this interface. The Client then creates a new object by cloning a ConcretePrototype.
## Participants
- **Prototype**: This is an interface or abstract class that declares the clone operation.
- **ConcretePrototype**: These are classes that implement the Prototype interface and handle the cloning operation.
- **Client**: The client is responsible for cloning the prototypes.
## Collaborations
Clients create new objects by copying a prototype. The client is responsible for knowing which prototype to clone.
## Consequences
**Pros**:
- You can clone objects without coupling to their concrete classes.
- You can get rid of repeated initialization code in favor of cloning pre-built prototypes.
- You can produce complex objects more conveniently.
- You can use the pattern to cache expensive network or database calls and return a clone from the cache.
**Cons**:
- Cloning complex objects that have circular references might be very tricky.
## Known Uses
- Document editors, where it's cheaper to clone a complex document structure and alter it slightly than to create a new structure from scratch.
- Game worlds, where you have massive amounts of similar objects like trees, bullets, enemies, etc.
## Related Patterns
- **Factory Method**: Designs start with Factory Method (less complicated, more customizable via subclasses) and evolve toward Prototype (more flexible, but more complicated).
- **Composite**: Often useful when the objects being composed from can be prototypes that you clone and combine.