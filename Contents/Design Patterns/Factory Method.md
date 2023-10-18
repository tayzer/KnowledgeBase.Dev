## Intent
Define an interface for creating an object, but let subclasses alter the type of objects that will be created. Factory Method lets a class defer instantiation to subclasses.
## Also Known As
Virtual Constructor
## Problem
A framework needs to standardize the architectural model for a range of applications, but allow for individual applications to define their own domain objects and provide for their instantiation.
## Solution
The Factory Method pattern involves a creator class containing the implementations for all of the methods to manipulate the product, except for the factory method. This is a method that you’re supposed to override in derived classes to produce instances of your desired concrete product.
## Applicability or When to Use
- A class can't anticipate the class of objects it must create.
- A class wants its subclasses to specify the objects it creates.
- Classes delegate responsibility to one of several helper subclasses, and you want to localize the knowledge of which helper subclass is the delegate.
## Structure
![Diagram](link-to-your-factory-method-diagram)
Diagram should depict the Creator and ConcreteCreator classes, the Product interface, and the ConcreteProduct classes.
## Participants
- **Product**: Defines the interface of objects the factory method creates.
- **ConcreteProduct**: Implements the Product interface.
- **Creator**: Declares the factory method, which returns an object of type Product. Creator may also define a default implementation of the factory method that returns a default ConcreteProduct object.
- **ConcreteCreator**: Overrides the factory method to return an instance of a ConcreteProduct.
## Collaborations
- Creator relies on its subclasses to define the factory method so that it returns an instance of the appropriate ConcreteProduct.
## Consequences
- Provides hooks for subclasses, creating an opportunity for subclasses to extend the logic of object creation without changing the code that uses the product.
- Connects parallel class hierarchies. Often, classes that implement the Product interface are composed of components from another class hierarchy. The Factory Method pattern links these hierarchies together.
## Known Uses
- GUI libraries, like Java's AWT, where it's used to encapsulate platform-dependent components like buttons, panels, etc.
- Complex frameworks that need to delegate the exact types and configurations of objects to create to the user's subclass.
## Related Patterns
- **Abstract Factory** patterns are often implemented using factory methods.
- **Prototype** patterns can be implemented with Factory Method. When the types of objects to create are specified by an instance, clone itself.
