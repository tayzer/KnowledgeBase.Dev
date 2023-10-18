## Intent
The State pattern allows an object to alter its behavior when its internal state changes. The object will appear to change its class, promoting an object's behavior to change along with its state.
## Also Known As
Objects for States
## Problem
A common issue occurs when an object needs to alter its behavior based on its state, and the object has a large conditional statement (switch or if/else) that chooses the appropriate behavior. This leads to cumbersome, hard-to-maintain code, making it difficult to add new states and behaviors.
## Solution
The State pattern suggests that you create new classes for all possible states of an object (concrete states) and extract all state-specific behaviors into these classes. Instead of implementing all behaviors on its own, the original object (context), stores a reference to one of the state objects that represents its current state, and delegates all the state-related work to that object.
## Applicability or When to Use
- An object's behavior depends on its state, and it must change its behavior at runtime depending on that state.
- Operations have large, multipart conditional statements that depend on the object's state.
## Structure
![Diagram](link-to-your-state-diagram-image)
Diagram should depict the Context, State, and ConcreteState classes, showcasing the delegation of behaviors based on state.
## Participants
- **Context**: class that has a state and defines an interface of interest to clients. It maintains an instance of a ConcreteState subclass that defines the current state.
- **State**: defines an interface for encapsulating the behavior associated with a particular state of the Context.
- **ConcreteState subclasses**: each subclass implements behavior associated with a state of the Context.
## Collaborations
- Context delegates state-specific behavior to the current ConcreteState object.
- Context may pass itself as an argument to the State object handling the request. This lets the State object access the Context if necessary.
## Consequences
**Pros**:
- Separates state-related behaviors into distinct classes, promoting cleaner code.
- Simplifies state transition expressions.
- Encapsulates state-specific behavior and partitions behavior for different states.
**Cons**:
- Can increase the number of classes in an application.
## Known Uses
- Document editors can switch between states: Edit, Preview, Locked, etc.
- Game characters with varying abilities based on their current state: Normal, Powered-up, Invincible, etc.
## Related Patterns
- **Flyweight**: If the State objects have no local state, sharing them can save memory.
- **Singleton**: Sometimes, ConcreteStates are implemented as Singletons.