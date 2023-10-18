## Intent
The Command pattern encapsulates a request as an object, thereby allowing for parameterization of clients with queues, requests, and operations. It also allows for saving the requests and provides support for undoable operations.
## Also Known As
Action, Transaction
## Problem
In a traditional procedure, we directly invoke the methods on objects. This approach doesn't allow for the decoupling of the sender of a request from its receiver, leading to less flexible systems. For instance, it's challenging to add commands without altering the existing code.
## Solution
Use an intermediary object (a command) to encapsulate a request. The command object binds together one or more actions on a specific receiver. This approach allows senders and receivers to vary independently.
## Applicability or When to Use
- When you need to parameterize objects according to an action to perform.
- When you need to specify, queue, and execute requests at different times.
- When you need support for undo/redo functionality.
- When the invoker should be decoupled from the object handling the invocation.
## Structure
![Diagram](link-to-your-command-diagram)

The structure involves a `Command` interface, one or more `ConcreteCommand` classes, a `Client`, an `Invoker`, and a `Receiver`.
## Participants
- **Command**: Declares an interface for executing an operation.
- **ConcreteCommand**: Extends the Command interface, implementing the Execute method by invoking the corresponding operations on the Receiver.
- **Client**: Creates a ConcreteCommand object and sets its receiver.
- **Invoker**: Asks the command to carry out the request.
- **Receiver**: Knows how to perform the operations associated with carrying out the request.
## Collaborations
- The client instantiates and configures a ConcreteCommand object, providing all necessary information.
- The invoker issues a request by calling `execute()` on the command. When commands are undoable, ConcreteCommand stores state for undoing the command prior to invoking `execute()`.
- The ConcreteCommand invokes actions on the receiver necessary to fulfill the request.
## Consequences
- **Decouples the classes that invoke the operation from the object that knows how to perform it.**
- **Allows for the creation of complex commands out of simpler ones using a composite.**
- **Makes it easier to support undoing operations.**
- **Can structure a system around high-level operations built on primitives operations.**
## Known Uses
- GUI buttons and menu items (e.g., in frameworks like .NET and Java Swing).
- Multi-level undo/redo features in applications like document editors or image processing tools.
- Operations, transactions, or requests logging.
## Related Patterns
- **Composite**: Commands can be assembled into composite commands (known as macros).
- **Memento**: If complex undo/redo capabilities are required, Mementos can store the state required to undo commands.
- **Prototype**: When command classes are instantiated dynamically, Prototypes can be used to avoid subclassing the Command class for every conceivable command.
