---
date: 2025-11-25
status: Current
tags:
  - architecture
  - microservices
  - communication
  - patterns

---

# Service Communication

## Quick Reference

**Definition:** Patterns and protocols used for communication between services: synchronous (HTTP/gRPC) and asynchronous (messaging, events).

**When to use:**
- Inter-service interactions in distributed systems.

**Key Takeaways:**
- **Synchronous HTTP or gRPC calls**: straightforward but couples latency and fault domains.
- **Asynchronous (queues and pub/sub)**: can decouple availability when durable delivery, capacity, and recovery are configured.
- Tip: **Use idempotency and retries** to handle partial failures.

**Code Snippet (gRPC service):**
```csharp
public class OrdersService : Orders.OrdersBase
{
    public override Task<GetOrderResponse> GetOrder(GetOrderRequest req, ServerCallContext ctx) =>
        Task.FromResult(new GetOrderResponse { /* ... */ });
}
```

**Gotchas:**
- Caution: **Distributed transactions** are hard; prefer eventual consistency.
- Caution: **Message ordering** is not guaranteed in many pub/sub systems; design accordingly.

---

## Deep Dive

### Protocol Choice
- **HTTP/REST:** Ubiquitous, simple, human-readable.
- **gRPC:** Protobuf contracts over HTTP/2 can fit internal RPC; latency depends on payload, network, and deployment.
- **Messaging (RabbitMQ, Kafka):** Durable, decoupled, good for event-driven systems.

### Patterns
- **Request/Response**: Synchronous direct calls.
- **Publish/Subscribe**: Events broadcast to many consumers.
- **Command/Worker**: Commands queued to workers for background processing.

### Reliability
- Set per-call deadlines. Retry only transient failures for safe or idempotent operations, with bounded attempts and jitter.
- Use dead-letter queues for poison messages.

---

### Call and message failure contract

For a synchronous request, define timeout, cancellation, idempotency key where needed, and what the caller does on an ambiguous response. For an asynchronous command, define publish confirmation, delivery expectation, duplicate handling, ordering scope, and dead-letter workflow. Neither messaging nor a retry loop guarantees resilience by itself. [Microsoft service communication guidance](https://learn.microsoft.com/en-us/azure/architecture/microservices/) (checked 2026-09-24).

## Related Concepts
- [[Message-Driven Architecture]]
- [[Event-Driven Architecture]]
- [[API Gateway Pattern]]
- [[Service Mesh]]
- [[Saga Pattern]]
- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]
- [[Azure Messaging Service Selection]]

## Resources
- Microsoft docs: microservices communications
- Patterns of Enterprise Application Architecture

## Practice Exercises
1. Implement a background worker that consumes messages from a queue (RabbitMQ or Azure Service Bus).
2. Create a small gRPC client/server pair and measure latency.

## Sources

- [Microsoft, Microservices architecture style](https://learn.microsoft.com/en-us/azure/architecture/microservices/) — last updated 2025-07-11; accessed 2026-09-24.
- [Microsoft, Integration event-based microservice communications](https://learn.microsoft.com/en-us/dotnet/architecture/microservices/multi-container-microservice-net-applications/integration-event-based-microservice-communications) — online page, date not shown; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 6 months
