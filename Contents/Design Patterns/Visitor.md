## Intent
The Visitor pattern lets you separate algorithms from the objects on which they operate, by introducing a new operation without changing the classes of the elements on which it operates.
## Also Known As
Walker, Double Dispatch
## Problem
In situations where you need to perform various operations on objects of different classes and want to avoid polluting their code with these operations, the regular approach might require placing these operations in each class. This leads not only to code duplication but also to a violation of the single responsibility principle and open-closed principle.
## Solution
The Visitor pattern suggests that you place the new operation into a separate class called a visitor. Instead of trying to perform an operation on an object, you send a visitor to that object. The object then accepts this visitor, granting it access to its internal elements, thus allowing the visitor to perform the operation on it.
## Applicability or When to Use
- When you need to perform an operation on all elements of a complex object structure (like a tree).
- When you want to benefit from double dispatch.
- When similar operations need to be performed on objects of different classes without coupling to their specific classes.
## Structure
![Diagram](link-to-your-visitor-diagram-image)
The diagram should show the relationships between Visitor, ConcreteVisitor, Element, and ConcreteElement classes.
## Participants
- **Visitor**: declares a visit operation for each class of ConcreteElement in the object structure.
- **ConcreteVisitor**: implements each operation declared by Visitor, which corresponds to classes of objects in the structure.
- **Element**: defines an accept operation that takes a visitor as an argument.
- **ConcreteElement**: implements an accept operation.
## Collaborations
- A client that uses the Visitor pattern must create a ConcreteVisitor object and then traverse the object structure, visiting each element with the visitor.
## Consequences
**Pros**:
- Simplifies addition of new operations to complex object structures.
- Centralizes related operations and separates them from object's structure.
- Double dispatch mechanism helps in choosing the operation to execute based on both the type of Visitor and Element.
**Cons**:
- Adding new ConcreteElement classes is hard.
- A visitor might require violating encapsulation of the elements it operates on.
- Accumulating state and carrying it through the traversal process can be challenging.
## Known Uses
- Compilers use the Visitor pattern to perform type-checking and code optimization, operating on ASTs (Abstract Syntax Trees).
- In graphical systems, it can be used to apply operations/behaviors to various graphical objects, like applying a filter or transformation.
## Related Patterns
- **Composite**: Visitors can be used to apply an operation over an entire Composite tree.
- **Interpreter**: Visitor may be applied to do the interpretation.