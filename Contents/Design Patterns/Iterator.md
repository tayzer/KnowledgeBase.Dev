## Intent
Provide a way to access the elements of an aggregate object sequentially without exposing its underlying representation.
## Also Known As
Cursor
## Problem
An object's collection might be stored in different ways, but you want to hide these variations from the client who wants to iterate through the items in the collection.
## Solution
The Iterator pattern involves two primary components: a 'ConcreteIterator' and a 'ConcreteAggregate'. The 'ConcreteAggregate' is a collection class and has a method that returns an 'Iterator' for its collection. The 'ConcreteIterator' defines the interface for accessing the collection's elements.
## Applicability or When to Use
- Use the Iterator pattern when you want to access an aggregate object's contents without exposing its internal representation.
- Use the Iterator pattern to support multiple traversals of aggregate objects.
- Use the Iterator pattern to provide a uniform interface for traversing different aggregate structures (polymorphic iteration).
## Structure
![Diagram](link-to-your-iterator-diagram)
Diagram should depict the relationship between Aggregate, ConcreteAggregate, Iterator, and ConcreteIterator.
## Participants
- **Iterator**: defines an interface for accessing and traversing elements.
- **ConcreteIterator**: implements the Iterator interface and keeps track of the current position in the traversal of the aggregate.
- **Aggregate**: defines an interface for creating an Iterator object.
- **ConcreteAggregate**: implements the Iterator creation interface to return an instance of the proper ConcreteIterator.
## Collaborations
- A ConcreteIterator keeps track of the current object in the aggregate and can compute the succeeding object in the traversal sequence.
- Clients use the first(), next(), isDone(), and currentItem() protocol to access the elements of the aggregate sequentially.
## Consequences
- Supports variations in the traversal of an aggregate. Complex aggregates may be traversed in many ways, e.g., depth-first vs. breadth-first, preorder, and postorder, etc.
- Iterators simplify the Aggregate interface.
- More than one traversal can be pending on an aggregate.
## Known Uses
- All major programming environments have iterators. For example, Java's Collection Framework, Python's iterator protocol, and C++'s Standard Template Library all implement the Iterator pattern.
- Databases often provide an iterator interface to their collections of records.
## Related Patterns
- **Composite**: Iterators are often applied to recursive structures such as those maintained with Composite. You can have an iterator for each Composite and Leaf classes.
- **Factory Method**: Polymorphic iterators rely on factory methods to instantiate the appropriate Iterator subclass.
- **Memento** is often used in conjunction with the Iterator pattern. An iterator can use a memento to capture the state of an iteration. The iterator stores the memento internally.
