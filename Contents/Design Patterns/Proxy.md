## Intent
The Proxy pattern provides a surrogate or placeholder for another object to control access to it. This is useful for implementing various services such as access control, caching, lazy initialization, and remote object access.
## Also Known As
Surrogate
## Problem
Direct access to objects can sometimes come with issues of security, performance, or resource consumption. Clients might not need the full level of access or the cost of having a full object in memory, or there might be security considerations that restrict direct object access.
## Solution
The Proxy pattern involves a new proxy class, which is typically smaller, less resource-intensive, or more restricted than the original object. The proxy receives client requests and performs several tasks related to these requests, potentially forwarding them to the real subject object.
## Applicability or When to Use
- Remote Proxy: Providing a local representation for an object that is in a different address space.
- Virtual Proxy: Creating expensive objects on demand.
- Protection Proxy: Controlling access to the original object for security reasons.
- Smart Reference: Adding additional actions when an object is accessed.
## Structure
![Diagram](link-to-your-proxy-diagram-image)
The structure involves the 'Subject' interface, the 'RealSubject' class, and the 'Proxy' class. Clients interact with the 'RealSubject' through the 'Subject' interface, which is also implemented by the 'Proxy' class.
## Participants
- **Subject**: Interface implemented by both the RealSubject and the Proxy, ensuring the Proxy can be used anywhere the RealSubject is expected.
- **RealSubject**: The original object that the proxy represents.
- **Proxy**: Holds a reference to the RealSubject, and implements the same interface. The proxy controls access to the RealSubject and may be responsible for its creation and deletion.
## Collaborations
Clients interact with the RealSubject through the Proxy, usually without even knowing they are dealing with a proxy rather than the real object.
## Consequences
**Pros**:
- The proxy can shield clients from the complexities of the real object.
- It can enhance performance or add security checks to the real object operations.
- Often simplifies the memory management for the real object.
**Cons**:
- Can complicate the design if overused.
- May cause a decrease in performance due to additional layers of abstraction.
## Known Uses
- Lazy loading of database entities.
- Web browser caching for web pages or media.
- Access control and logging for remote services.
- Smart references for large objects in memory.
## Related Patterns
- **Adapter Pattern**: Proxies alter the object’s interface, while Adapters provide a different interface to the object.
- **Decorator Pattern**: Unlike proxies, decorators add new responsibilities to objects while keeping the same interface.