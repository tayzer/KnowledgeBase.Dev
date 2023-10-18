## Intent
The Abstract Factory pattern provides an interface for creating families of related or dependent objects without specifying their concrete classes.
## Also Known As
Kit
## Problem
Creating a series of related or dependent objects usually requires instantiating their concrete classes. This can make a system less scalable and more difficult to update, maintain, or scale because it binds client code to specific classes, forcing recompilation of the client code when new classes are added or switched.
## Solution
The Abstract Factory pattern involves the use of an interface or abstract class to define and encapsulate a group of individual factories that have a common theme. Implementation of the factories continues the theme and creates concrete objects that are related. Client systems create objects through the factories without being tied to the actual concrete classes.
## Applicability or When to Use
- When a system should be independent of how its products are created, composed, or represented.
- When a system should be configured with one of multiple families of products.
- When you want to provide a class library of products, and you want to reveal just the interfaces, not the implementations.
## Structure
![Diagram](link-to-your-abstract-factory-diagram)

The structure involves an AbstractFactory, ConcreteFactory, AbstractProduct, and ConcreteProduct. Clients use instances of ConcreteFactory via their AbstractFactory interface.
## Participants
- **AbstractFactory**: Declares an interface for operations that create abstract products.
- **ConcreteFactory**: Implements operations to create concrete products.
- **AbstractProduct**: Declares an interface for a type of product objects.
- **ConcreteProduct**: Defines an object to be created by the corresponding concrete factory; implements the AbstractProduct interface.
- **Client**: Uses only interfaces declared by AbstractFactory and AbstractProduct classes.
## Collaborations
- Normally a single instance of a ConcreteFactory class is created at run-time. This concrete factory creates product objects having a particular implementation.
- AbstractFactory defers creation of product objects to its ConcreteFactory subclass.
## Consequences
- Isolates concrete classes: The Abstract Factory pattern helps control the classes of objects that an application creates.
- Makes exchanging product families easy: The class of a factory appears only once in an application.
- Promotes consistency among products: When product objects from one family are designed to work together, it's important that an application use objects from only one family at a time.
- Supporting new kinds of products is difficult: Extending abstract factories to produce new kinds of Products isn't easy.
## Implementation/Pseudocode

``` 
// AbstractFactory
interface IFactory {
    createProductA(): IProductA;
    createProductB(): IProductB;
}

// ConcreteFactory1
class ConcreteFactory1 implements IFactory {
    createProductA(): IProductA { /*...*/ }
    createProductB(): IProductB { /*...*/ }
}

// ConcreteFactory2
class ConcreteFactory2 implements IFactory {
    createProductA(): IProductA { /*...*/ }
    createProductB(): IProductB { /*...*/ }
}

// Usage
class Client {
    constructor(factory: IFactory) {
        this.factory = factory;
    }

    createProducts() {
        this.productA = this.factory.createProductA();
        this.productB = this.factory.createProductB();
    }
}
```
## Known Uses

- GUI toolkits and frameworks often use the Abstract Factory pattern to manage and encapsulate platform-specific types and behaviors.
- Database frameworks that need to support multiple types of databases.
## Related Patterns
- Factory Method: Abstract Factory classes are often implemented with Factory Methods.
- Singleton: Often, the ConcreteFactories are implemented as Singletons.