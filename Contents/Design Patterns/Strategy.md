## Intent
The Strategy pattern enables an object, called the context, to support variations in its logic by extracting variable parts into separate, interchangeable objects known as strategies. It defines a family of algorithms, encapsulates each one, and makes them interchangeable.
## Also Known As
Policy
## Problem
You have an object that performs a certain task, but there are several ways to complete this task, and the preferred method might change at runtime. Implementing all these methods in a single class directly makes the class extremely large and difficult to maintain.
## Solution
The Strategy pattern suggests that you take a class that does something specific in a lot of different ways and extract all of these algorithms into separate classes called strategies. The original class, called context, must have a field for storing a reference to one of the strategies. Instead of implementing a behavior on its own, the context calls the execution method on the linked strategy object.
## Applicability or When to Use
- Use the Strategy pattern when you want to define a class that will have one behavior that is similar to other behaviors in a list.
- When you need to use one of several behaviors dynamically.
- When you have a lot of similar classes that only differ in the way they execute some behavior.
## Structure
![Diagram](link-to-your-strategy-diagram-image)
Diagram should depict the Context, Strategy, and ConcreteStrategy classes, showcasing the delegation of behaviors.
## Participants
- **Context**: maintains a reference to a Strategy object, and communicates with this object by calling the strategy's method.
- **Strategy**: common interface for all strategies, declaring a method the context uses to execute a strategy.
- **ConcreteStrategy**: implements the algorithm using the Strategy interface.
## Collaborations
- Strategy and Context work together to implement the chosen algorithm. The Context forwards requests from its clients to its strategy. Clients usually create and pass a ConcreteStrategy object to the Context.
## Consequences
**Pros**:
- You can swap algorithms used inside an object at runtime.
- You can isolate the implementation details of an algorithm from the code that uses it.
- You can replace inheritance with composition.
- Open/Closed Principle. You can introduce new strategies without having to change the context.
**Cons**:
- Clients must be aware of the differences between strategies to select the proper one.
- A lot of modern programming languages have functional type support that lets you implement different versions of an algorithm inside a set of anonymous functions. Then you could use these functions exactly as you’d have used the strategy objects, but without bloating your code with extra classes and interfaces.
## Known Uses
- Various sorting algorithms (Quick, Merge, Bubble, etc.) that can be switched at runtime.
- Different transportation algorithms for a logistics company that can be chosen based on various factors: cost, speed, etc.
## Related Patterns
- **Composite**: Strategies can be composed.
- **Flyweight**: Instead of creating multiple similar strategy objects, you might use Flyweight to share strategies between contexts (if they don’t maintain state).
- **Bridge**: can be viewed as a layer over Strategy, each different implementation would be a separate strategy.