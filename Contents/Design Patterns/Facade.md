## Intent
Provide a unified interface to a set of interfaces in a subsystem. Facade defines a higher-level interface that makes the subsystem easier to use.

## Also Known As
N/A

## Problem
When a system is complex or difficult to understand because it has a large number of interdependent classes or its source code is unavailable, this complexity might become problematic when clients need to interact with the system.

## Solution
Introduce a Facade object that provides a single, simplified interface to the more general facilities of a subsystem.

## Applicability or When to Use
- You want to provide a simple interface to a complex subsystem. Subsystems often get more complex as they evolve. Most patterns, when applied, result in more and smaller classes.
- There are many dependencies between clients and the implementation classes of an abstraction.
- You want to layer your subsystems. Use a facade to define an entry point to each subsystem level.
## Structure
![Diagram](link-to-your-facade-diagram)
Diagram showing the "Facade" which interacts with various complex subsystems, simplifying the client's interaction.
## Participants
- **Facade**: Knows which subsystem classes are responsible for a request and delegates client requests to appropriate subsystem objects.
- **Subsystems**: Implement more complex subsystem functionality and handle work assigned by the Facade object. They have no knowledge of the facade; they keep no reference to it.
## Collaborations
- Clients communicate with the subsystem by sending requests to Facade, which forwards them to the appropriate subsystem object(s). Although the subsystem objects perform the actual work, the facade may have to do work of its own to translate its interface to subsystem interfaces.
- Clients that use the facade don’t have to access its subsystem objects directly.
## Consequences
- It shields clients from subsystem components, thereby reducing the number of objects clients deal with and making the subsystem easier to use.
- It promotes weak coupling between the subsystem and its clients.
- It doesn't prevent applications from using subsystem classes if they need to.
## Known Uses
- Operating systems often provide a file system API as a facade over the actual low-level mechanics.
- Libraries like jQuery (for client-side JavaScript) act as a facade providing a simplified API for large or complex systems like the DOM.
## Related Patterns
- **Abstract Factory** can be used with **Facade** to provide a simple interface for creating complex objects.
- **Mediator** is similar to **Facade** in that it abstracts functionality of existing classes. However, Mediator's purpose is to abstract complex communication, state dependencies and behavior.
