## Intent
The Template Method pattern defines the skeleton of an algorithm in the superclass but lets subclasses override specific steps of the algorithm without changing its structure.
## Also Known As
Don't call us, we'll call you.
## Problem
Designing an algorithm that consists of similar steps, but the exact implementation of some steps may differ. Modifying the algorithm or incorporating new steps often leads to code duplication and a maintenance nightmare.
## Solution
The Template Method pattern suggests that you break down an algorithm into a series of steps, turn these steps into methods, and put a series of calls to these methods inside a single "template method." The steps may either be abstract, or have some default implementation. To use the algorithm, the client is supposed to provide its own subclass, implement all abstract steps, and override some of the optional ones if needed (but not the template method itself).
## Applicability or When to Use
- When you want to let clients extend only particular steps of an algorithm, but not the whole algorithm or its structure.
- When you have several classes that contain almost identical algorithms with some minor differences. As a result, you might need to modify all classes when the algorithm changes.
## Structure
![Diagram](link-to-your-template-method-diagram-image)
Diagram should depict an abstract class with the template method and methods corresponding to steps of the algorithm, and subclasses implementing these steps.
## Participants
- **AbstractClass**: defines abstract primitive operations that concrete subclasses define to implement steps of an algorithm and implements a template method defining the skeleton of an algorithm.
- **ConcreteClass**: implements the primitive operations to carry out subclass-specific steps of the algorithm.
## Collaborations
- **AbstractClass** calls the primitive operations, as well as operations defined in AbstractClass itself, in the template method.
## Consequences
**Pros**:
- You can let clients override only certain parts of a large algorithm, making them less affected by changes that happen to other parts of the algorithm.
- You can pull the duplicate code into a superclass.
**Cons**:
- Some clients might be limited by the provided skeleton of an algorithm.
- You might violate the Liskov Substitution Principle by suppressing a default step implementation via a subclass.
- Template methods might be very hard to maintain in more complicated algorithms.
## Known Uses
- Frameworks often use Template Methods when providing generic methods for an operation, allowing users to extend specific steps. For example, data processing engines might define the outline of the data processing pipeline and allow users to introduce their custom processing steps.
## Related Patterns
- **Factory Method**: often called by template methods to create a system's components.
- **Strategy**: Template Method uses inheritance to vary part of an algorithm. Strategy uses delegation to vary the entire algorithm.