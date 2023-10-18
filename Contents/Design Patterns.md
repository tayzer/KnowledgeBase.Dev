
To add:
- Factory 
- State 
- Strategy
- Mediator

### Singleton

**Intent**: Ensure a class has only one instance and provide a global point of access to it.

**Applicability or When to Use**:

- When you need to ensure there's exactly one instance of a class in the system.
- When you need to provide a global point of access to an object, such as a configuration manager or a connection pool.
- When you want to avoid expensive operations like I/O repeatedly by sharing a single instance.

---

### Factory Method

**Intent**: Define an interface for creating an object, but allow subclasses to alter the type of objects that will be created.

**Applicability or When to Use**:

- When the exact type of the object to be created isn't known until runtime.
- When the creation process is complex or involves multiple steps.
- When you want to delegate the responsibility of object instantiation to subclasses.

### Observer

**Intent**: Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

**Applicability or When to Use**:

- When an abstraction has multiple aspects that depend on its state, and you want to keep them in sync.
- When you want to avoid tight coupling between a central object and many observer objects.
- For event-driven systems where state changes need to be communicated across components.

---

### Strategy

**Intent**: Define a family of algorithms, encapsulate each one, and make them interchangeable. This pattern lets the algorithm vary independently from clients that use it.

**Applicability or When to Use**:

- When you have multiple ways of doing something (algorithms) and want to switch between them dynamically.
- When you want to isolate the logic of a particular algorithm from the code that uses it.
- To reduce conditional statements and make the code more maintainable.
## Architectural
[[CQRS]]
Goal Oriented Action Planning (GOAP)
Entity Component System (ECS)
## Creational
## Structural
## Behavioural 
### Operation Result