## Intent
The Mediator design pattern defines an object that encapsulates how a set of objects interact, promoting loose coupling by keeping objects from referring to each other explicitly.
## Also Known As
Intermediary, Controller
## Problem
In a system with many components, the logic and computational relationships between the components can become very complex, leading to an intertwined web where changes to one component can have unforeseen effects on other components.
## Solution
The Mediator pattern suggests that you should encapsulate the interactions between these components by introducing a mediator object. The components don't interact with each other directly but through the mediator.
## Applicability or When to Use
- A set of objects communicate in well-defined but complex ways. The resulting interdependencies are unstructured and difficult to understand.
- Reusing an object is difficult because it refers to and communicates with many other objects.
- Behavior that's distributed between several classes should be customizable without a lot of subclassing.
## Structure
![Diagram](link-to-your-mediator-diagram)
Diagram should depict the relationship between Mediator, ConcreteMediator, Colleague classes.
## Participants
- **Mediator**: defines an interface for communicating with Colleague objects.
- **ConcreteMediator**: implements cooperative behavior by coordinating Colleague objects and knows and maintains its colleagues.
- **Colleague classes**: each Colleague class knows its Mediator object and communicates with its mediator whenever it would have otherwise communicated with another colleague.
## Collaborations
- Colleagues send and receive requests from a Mediator object. The mediator implements the cooperative behavior by routing requests between the appropriate colleague(s).
## Consequences
- Reduces subclassing.
- Decouples colleagues.
- Simplifies object protocols.
- Abstracts how objects cooperate, making it independent of how they interact.
- Centralizes control.
## Known Uses
- Chat applications where the server acts as a mediator between clients sending messages.
- Air traffic control systems where the control tower acts as a mediator between airplanes.
- GUI libraries where the dialog box manages the interaction between GUI components.
## Related Patterns
- **Observer**: The Mediator might use the Observer pattern to keep track of colleagues and vice versa.
- **Facade Pattern**: Mediator can be seen as a generalization of the Facade pattern.
- **Command Pattern**: The Mediator may use the Command pattern to encapsulate colleagues' requests.
