## Intent
The Adapter pattern allows classes with incompatible interfaces to work together by wrapping its own interface around that of an already existing class.
## Also Known As
Wrapper
## Problem
In software engineering, systems evolve and grow. Sometimes, new systems or updates introduce classes with interfaces that are not compatible with existing systems or client code. Rewriting the entire foundational interface may not be feasible because it's time-consuming, prone to error, and unnecessary.
## Solution
The Adapter pattern involves a single class, the adapter, which is responsible for joining functionalities of independent or incompatible interfaces. This structural pattern involves an interface which translates one interface into another, allowing for interoperability that otherwise wouldn't be possible.
## Applicability or When to Use
- When you want to use an existing class, but its interface isn't compatible with the rest of your code.
- When you want to create a reusable class that cooperates with classes that don't have compatible interfaces.
- When you need to standardize diverse implementations to a common interface.
## Structure
![Diagram](link-to-your-adapter-diagram)

The structure typically involves the client, the adapter (or wrapper), and the adaptee.
## Participants
- **Client**: This is the class that interacts with the Adapter.
- **Adapter**: This class mediates the functionality between the Client and the Adaptee.
- **Adaptee**: This is the class being adapted to the needs of the Client.
## Collaborations
- Clients call methods on the Adapter object which redirects them into calls to the Adaptee but in a format that is expected by the Client.
## Consequences
- Helps achieve reusability and flexibility.
- Client code isn't complicated by having to use and adapt to a new interface.
- Requires an understanding of both the target interface and the adaptee interface, which can be complex.
## C# Implementation
```csharp
// Adaptee class with a different interface that needs adapting
public class Adaptee
{
    public void SpecificRequest()
    {
        // Some specific functionality
    }
}

// Adapter class makes Adaptee's interface compatible with the ITarget interface
public class Adapter : ITarget
{
    private readonly Adaptee _adaptee = new Adaptee();

    public void Request()
    {
        // Possibly do some other work
        // and then call SpecificRequest
        _adaptee.SpecificRequest();
    }
}

// ITarget interface is used by the client to make requests
public interface ITarget
{
    void Request();
}

// Client code
public class Client
{
    public void Main(ITarget target)
    {
        target.Request();
    }
}
```
## Known Uses
- Adapters are widely used in systems integration, for instance, when integrating new features or software to older systems.
- Operating systems use adapters to standardize the operations and controls of different types of hardware devices.
## Related Patterns
- Bridge: Although the structure looks similar, Adapter is meant to change the interface of an existing object, while Bridge makes two components work together smoothly.
- Decorator: Adds responsibilities to an object while Adapter gives them a new interface.