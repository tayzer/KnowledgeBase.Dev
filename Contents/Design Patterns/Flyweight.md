## Intent
Use sharing to support large numbers of fine-grained objects efficiently.
## Also Known As
Cache
## Problem
Designing objects down to the lowest levels of system "granularity" provides optimal flexibility, but can be unacceptably expensive in terms of performance and memory usage.
## Solution
The Flyweight pattern describes how to share objects to allow their use at fine granularities without an unacceptable cost. Each "flyweight" object is divided into two pieces: the state-dependent (extrinsic) part, and the state-independent (intrinsic) part. Intrinsic state is stored (shared) in the Flyweight object; extrinsic state is stored or computed by client objects and passed to the Flyweight when its operations are invoked.
## Applicability or When to Use
- An application uses a large number of objects.
- Storage costs are high because of the sheer quantity of objects.
- Most object state can be made extrinsic.
- Many groups of objects may be replaced by relatively few shared objects once extrinsic state is removed.
- The application doesn't depend on object identity. Since flyweight objects may be shared, identity tests will return true for conceptually distinct objects.
## Structure
![Diagram](link-to-your-flyweight-diagram)
Diagram should depict the relationship between Client, FlyweightFactory, Flyweight, UnsharedConcreteFlyweight, and ConcreteFlyweight.
## Participants
- **Flyweight**: Declares an interface through which flyweights can receive and act on extrinsic state.
- **ConcreteFlyweight**: Implements the Flyweight interface and adds storage for intrinsic state, if any. A ConcreteFlyweight object must be sharable.
- **UnsharedConcreteFlyweight**: Not all Flyweight subclasses need to be shared.
- **FlyweightFactory**: Creates and manages flyweight objects and ensures that flyweights are shared properly.
- **Client**: Maintains a reference to flyweights and computes or stores the extrinsic state of flyweights.
## Collaborations
- Clients request flyweights from the factory. If a flyweight exists, the factory provides an existing instance; if not, it creates a new one.
- The client supplies extrinsic state to the flyweight when it invokes its operations.
## Consequences
- Reduces the number of instances that must be created, lowering memory usage and potentially improving application performance.
- The reduction of instance count also decreases the cost of data storage, retrieval, and context switching.
- More challenging to manage shared objects and the extrinsic state. The pattern introduces runtime costs associated with transferring, finding, and/or computing extrinsic state.
## Known Uses
- Text editors typically use a glyph object to represent characters, reducing the storage costs associated with complex documents.
- Game engines frequently use this pattern to minimize the memory footprint of massive numbers of similar characters and environment elements.
## Related Patterns
- **Composite**: Often, the flyweight objects can be composed into tree structures.
- **Factory Method**: A factory is usually present and can be used to manage flyweight objects.
- **State or Strategy**: Flyweight explains when and how State objects can be shared.
