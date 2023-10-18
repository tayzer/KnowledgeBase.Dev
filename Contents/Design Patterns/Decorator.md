## Intent
The Decorator pattern dynamically adds responsibilities to an object without altering its structure. This is a flexible alternative to subclassing for extending functionality.
## Also Known As
Wrapper
## Problem
You want to add behavior or state to individual objects at run-time without affecting other objects. Extending functionality using inheritance isn't feasible because it's static and applies to an entire class.
## Solution
Create a set of decorator classes that are used to wrap concrete components. Decorator classes mirror the type of the components they decorate, but add or override behaviors.
## Applicability or When to Use
- To add responsibilities to individual objects dynamically and transparently, that is, without affecting other objects.
- For responsibilities that can be withdrawn.
- When extension by subclassing is impractical. Sometimes a large number of independent extensions are possible and would produce an explosion of subclasses to support every combination.
## Structure
![Diagram](link-to-your-decorator-diagram)

The structure involves a `Component` interface, a `ConcreteComponent` class, and a `Decorator` class that maintains a reference to a `Component` object and defines an interface that conforms to `Component`'s interface.
## Participants
- **Component**: Defines the interface for objects that can have responsibilities added to them dynamically.
- **ConcreteComponent**: Defines an object to which additional responsibilities can be attached.
- **Decorator**: Maintains a reference to a Component object and defines an interface that conforms to Component's interface.
- **ConcreteDecorator**: Adds responsibilities to the component.
## Collaborations
- Decorator forwards requests to its Component object. It may optionally perform additional operations before and after forwarding the request.
## Consequences
- More flexibility than static inheritance. Adds responsibilities at run-time.
- Avoids feature-laden classes high up in the hierarchy. 
- A decorator and its component aren't identical. A decorator acts as a transparent enclosure. 
- Lots of little objects.
## Known Uses
- GUI toolkits to add behaviors to graphical elements. For instance, adding a border or shadow to a window.
- Web server frameworks adding processing layers (middleware) to handle HTTP requests.
- Java’s I/O Streams.
## Related Patterns
- **Adapter**: provides a different interface to the object it adapts. In contrast, Decorator provides the same interface as its component.
- **Composite**: A decorator can be viewed as a degenerate composite with only one component. However, a decorator adds additional responsibilities.
- **Strategy**: With different encapsulated algorithms, Decorators provide a new behavior, while Strategy alters the internals of an object.
