## Intent
Provide a way to evaluate language grammar or expression. This type of pattern comes under behavioral pattern. This pattern involves implementing an expression interface which tells to interpret a particular context.
## Also Known As
N/A
## Problem
A class of problems occurs repeatedly in a well-defined and well-understood domain. If the domain were characterized with a "language," then problems could be easily solved with an interpretation "engine."
## Solution
The Interpreter pattern discusses: defining a domain language (i.e., grammar) as a simple language grammar, representing domain rules as language sentences, and interpreting these sentences to solve the problem. The pattern uses a class to represent each grammar rule. And since grammars are usually hierarchical in structure, an inheritance hierarchy of rule classes maps nicely.
## Applicability or When to Use
- The grammar is simple. For complex grammars, the class hierarchy for the grammar becomes large and unmanageable.
- Efficiency is not a critical concern. The most efficient interpreters are usually not implemented by interpreting parse trees directly but by translating them into some other form. For example, regular expressions are often transformed into state machines. But then, the translator is another instance of the Interpreter pattern, so the two are not mutually exclusive.
## Structure
![Diagram](link-to-your-interpreter-diagram)
Diagram should depict the relationship between Context, AbstractExpression, TerminalExpression, NonterminalExpression, and Client.
## Participants
- **AbstractExpression**: Declares an interpret() operation that all nodes (terminal and nonterminal) in the AST overrides.
- **TerminalExpression**: Implements the interpret() operation for terminal expressions.
- **NonterminalExpression**: Implements the interpret() operation for nonterminal expressions.
- **Context**: Contains information that's global to the interpreter.
- **Client**: Builds (or is given) the AST. Invokes the interpret() operation.
## Collaborations
- The client builds (or is given) the sentence as an abstract syntax tree of NonterminalExpression and TerminalExpression instances. Then the client initializes the context and invokes the interpret operation.
- Each TerminalExpression node in the tree implements the interpret operation to match and consume elements in the context. If the node is a NonterminalExpression, it recurses through nested elements.
## Consequences
- It's easy to change and extend the grammar. Implemented as classes, you can use inheritance to alter or extend the grammar.
- Implementing the grammar is easy, too. Classes defining nodes in the abstract syntax tree have similar implementations. These classes are easy to write, and often their generation can be automated with a compiler or preprocessor tool.
- Complex grammars are hard to maintain. The Interpreter pattern doesn't address parsing. When the grammar is very complex, other techniques like the flyweight pattern might be more appropriate.
## Known Uses
- Compilers, expression processing, rule-based systems, and natural language translation.
## Related Patterns
- **Composite**: The abstract syntax tree is an instance of the composite pattern.
- **Flyweight**: Shows how to share terminal symbols within the abstract syntax tree.
- **Iterator**: The interpreter can use an iterator to traverse the structure.
- **Visitor**: Can be used to maintain the behavior in each node in the abstract syntax tree in one class.
