## Intent
The Builder pattern separates the construction of a complex object from its representation, allowing the same construction process to create various representations.

## Also Known As
Director-Builder

## Problem
Creating an object that requires various parts, created in a specific sequence, can necessitate a large number of constructor arguments. Such an object is often not amenable to being constructed with a traditional constructor, as numerous parameters can lead to confusing and fragile code, often referred to as the "telescoping constructor" problem.

## Solution
The Builder pattern proposes the use of a separate `Builder` object to construct the desired object step-by-step (piece-by-piece) before the final object is returned to the client. This allows for different implementations of the construction process for different representations of the object.

## Applicability or When to Use
- When the algorithm for creating a complex object should be independent of the parts that make up the object and how they're assembled.
- When the construction process must allow different representations for the object that's constructed.
## Structure
![Diagram](link-to-your-builder-diagram)

The structure involves a `Director`, `Builder`, and `ConcreteBuilder`.
## Participants
- **Builder**: Specifies an abstract interface for creating parts of a `Product` object.
- **ConcreteBuilder**: Constructs and assembles parts of the product by implementing the `Builder` interface. It defines and keeps track of the representation it creates and provides an interface for retrieving the product.
- **Director**: Constructs an object using the `Builder` interface.
- **Product**: Represents the complex object under construction. `ConcreteBuilder` builds the product's internal representation and defines the process by which it's assembled.
## Collaborations
- The client creates the `Director` object and configures it with the desired `Builder` object.
- `Director` notifies the builder whenever a part of the product should be built.
- `Builder` handles requests from the `Director` and adds parts to the product.
- The client retrieves the product from the `Builder`.
## Consequences
- Allows for finer control over the construction process, as opposed to using numerous constructors.
- Offers a clearer representation of the construction process for a particular object, as it's not buried within the object itself.
- More robust, adaptable construction: different directors can enact different construction processes with the same builder.
## Known Uses
- Text processing applications, where text elements can have different representations (ASCII, HTML, RTF, etc.).
- GUI libraries and frameworks, where different elements of a window could be defined and constructed independently but need to come together cohesively.
## Related Patterns
- **Abstract Factory**: Often a builder will employ an Abstract Factory pattern to construct some of its parts.
- **Composite**: Often builders will compose objects into tree structures.
