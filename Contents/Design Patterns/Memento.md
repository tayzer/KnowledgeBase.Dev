## Intent
The Memento design pattern provides the ability to restore an object to its previous state (undo via rollback), without exposing the internals of the object.
## Also Known As
Snapshot
## Problem
Sometimes it's necessary to record the internal state of an object at some point and be able to restore the object to that state later in a manner that's independent of the object's own operations, but without exposing the object's implementation.
## Solution
The Memento pattern involves three participants: the originator, the caretaker, and the memento. The originator creates a memento object capturing the originator's internal state. The caretaker operates or keeps the memento but never modifies it. When the originator needs to revert to a previous state, it uses the memento saved by the caretaker.
## Applicability or When to Use
- When a snapshot of an object's state must be saved so that it can be restored to that state later.
- When a direct interface to obtain the state would expose implementation details and break the object's encapsulation.
## Structure
![Diagram](link-to-your-memento-diagram)
The diagram should depict the relationship between the Originator, Memento, and Caretaker classes.
## Participants
- **Memento**: stores internal state of the Originator object and protects against access by objects other than the originator.
- **Originator**: creates a memento containing a snapshot of its current internal state and uses the memento to restore its internal state.
- **Caretaker**: is responsible for the memento's safekeeping but never operates on or examines the contents of a memento.
## Collaborations
- The caretaker requests a memento from the originator to capture the internal state of an originator and holds onto it for later restoration by the originator.
## Consequences
- Preserving encapsulation boundaries.
- It simplifies the originator.
- Using mementos might be expensive in terms of resources.
- Defining narrow and wide interfaces can be tricky.
## Known Uses
- The undo and redo functions of software applications (e.g., word processors, graphic editors).
- Saving and restoring the state of complex objects, like in gaming applications (save game functionality).
## Related Patterns
- **Command Pattern**: The Command pattern can use Mementos to maintain the state required for an undo operation.
- **Prototype Pattern**: Mementos are often used in conjunction with the Prototype pattern.
