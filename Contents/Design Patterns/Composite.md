## Intent
The Composite pattern allows clients to treat individual objects and compositions of objects uniformly. It composes objects into tree structures to represent part-whole hierarchies.
## Also Known As
Object Tree, Containership, Part-Whole
## Problem
Managing and manipulating a hierarchical collection of "primitive" and "composite" objects without having to differentiate between the two. Clients should be able to treat composite structures and individual objects the same.
## Solution
Define a unified `Component` interface for both part (leaf) and whole (composite) objects, enabling a composite to be composed of components which could be further composites.
## Applicability or When to Use
- When you want to represent part-whole hierarchies of objects.
- When you want clients to treat individual objects and compositions of objects uniformly.
## Structure
![Diagram](link-to-your-composite-diagram)

The structure involves a `Component` interface, a `Leaf` class, and a `Composite` class.
## Participants
- **Component**: Declares the interface for objects in the composition and for accessing and managing its child components.
- **Leaf**: Represents leaf objects in the composition. A leaf has no children.
- **Composite**: Defines behavior for components having children and stores child components.
## Collaborations
- Clients use the Component class interface to interact with objects in the composite structure. If the recipient is a Leaf, then the request is handled directly. If the recipient is a Composite, then it usually forwards requests to its child components, possibly performing additional operations before and/or after forwarding.
## Consequences
- **Simplifies the client code**: The client can treat composite structures and individual objects uniformly.
- **Makes it easier to add new kinds of components**: As long as the new component follows the established interface.
- **Can make your design overly general**: The difference between specific and generic behaviors can be lost in translation.
## Known Uses
- Representing hierarchical file and folder systems.
- Graphics systems: shapes, groups of shapes, layers, groups of layers.
- Organization structures (people and departments).
## Related Patterns
- **Chain of Responsibility**: A parent component in the composite tree may pass requests to its child components.
- **Decorator**: The decorator is often used with Composite. When decorators and composites are used together, they will usually have a common parent class. So decorators will have to support the Component interface with operations like Add, Remove, and GetChild.
- **Iterator**: Composite may support an Iterator to let clients traverse compositions of objects.
- **Visitor**: Can apply an operation over an object structure defined by Composite.
