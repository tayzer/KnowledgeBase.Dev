## Intent
The Observer pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically. It is primarily used for implementing distributed event handling systems.
## Also Known As
Dependents, Publish-Subscribe
## Problem
In a situation where the state of one object (the subject) may change and other objects (observers) depend on this state, we need a way to update the observers when the subject's state changes without creating high coupling between these two different types of objects.
## Solution
The Observer pattern suggests that you add a subscription mechanism to the subject class so it can keep track of all objects that wish to be informed about the subject’s events. The subject owns a list of references to its observers and notifies them automatically of any state changes by calling their methods.
## Applicability or When to Use
- When an abstraction has two aspects, one dependent on the other, encapsulating these aspects in separate objects lets you vary and reuse them independently.
- When a change to one object requires changing others, and you don't know how many objects need to be changed.
- When an object should be able to notify other objects without making assumptions about who these objects are.
## Structure
![Diagram](link-to-your-observer-diagram)
The diagram would typically depict the Subject, ConcreteSubject, Observer, and ConcreteObserver classes and their relationships.
## Participants
- **Subject**: Interface or abstract class defining the operations for attaching and de-attaching observers to the client.
- **ConcreteSubject**: The class which maintains the state of interest.
- **Observer**: Interface or abstract class defining the operations to be used to notify this object.
- **ConcreteObserver**: The class that maintains a reference to a ConcreteSubject object, stores state that should stay consistent with the subject's, and implements the Observer updating interface to keep its state consistent with the subject's.
## Collaborations
- ConcreteSubject notifies its observers whenever a change occurs that could make its observers' state inconsistent with its own.
- After being informed of a change in the concrete subject, a ConcreteObserver object may query the subject for information. The observer uses this information to reconcile its state with that of the subject.
## Consequences
- Abstract coupling between Subject and Observer.
- Support for broadcast communication.
- Unexpected updates. Because observers have no knowledge of each other's presence, they can be blind to the ultimate cost of changing the subject.
## Known Uses
- Listening to event-driven user interfaces (like buttons or menus in a graphical user interface).
- Watching for changes in a data model (in a model-view-controller architecture).
- Subscribing to incoming messages or events (like in message queuing systems).
## Related Patterns
- **Mediator Pattern**: By encapsulating complex update semantics, the Change Manager acts as a mediator between subjects and observers.
- **Singleton Pattern**: The Change Manager may use the Singleton pattern to make it unique system-wide.
- **State Pattern**: The objects being observed might use the State pattern to store states.
