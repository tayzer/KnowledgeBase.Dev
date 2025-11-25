# Service Communication
Date: 2025-11-25
Status: 🟢 Current
Tags: #architecture #microservices #communication #patterns

## 🎯 TL;DR / Quick Reference

**Definition:** Patterns and protocols used for communication between services: synchronous (HTTP/gRPC) and asynchronous (messaging, events).

**When to use:**
- Inter-service interactions in distributed systems.

**Key Takeaways:**
- ✅ **Synchronous (HTTP/gRPC)**: straightforward but couples latency/fault domains.
- ✅ **Asynchronous (Message queues, Pub/Sub)**: improves resilience and decoupling.
- ⚡ **Use idempotency and retries** to handle partial failures.

**Code Snippet (gRPC service):**
```csharp
public class OrdersService : Orders.OrdersBase
{
    public override Task<GetOrderResponse> GetOrder(GetOrderRequest req, ServerCallContext ctx) =>
        Task.FromResult(new GetOrderResponse { /* ... */ });
}
```

**Gotchas:**
- ⚠️ **Distributed transactions** are hard; prefer eventual consistency.
- ⚠️ **Message ordering** is not guaranteed in many pub/sub systems; design accordingly.

---

## 📚 Deep Dive

### Protocol Choice
- **HTTP/REST:** Ubiquitous, simple, human-readable.
- **gRPC:** Binary, fast, strongly-typed contracts—great for internal low-latency services.
- **Messaging (RabbitMQ, Kafka):** Durable, decoupled, good for event-driven systems.

### Patterns
- **Request/Response**: Synchronous direct calls.
- **Publish/Subscribe**: Events broadcast to many consumers.
- **Command/Worker**: Commands queued to workers for background processing.

### Reliability
- Implement retries with exponential backoff.
- Use dead-letter queues for poison messages.

---

## 🔗 Related Concepts
- [[CQRSMediator]]
- [[AzureServicesOverview]]

## 📖 Resources
- Microsoft docs: microservices communications
- Patterns of Enterprise Application Architecture

## 🧪 Practice Exercises
1. Implement a background worker that consumes messages from a queue (RabbitMQ or Azure Service Bus).
2. Create a small gRPC client/server pair and measure latency.

## 📝 Personal Notes

## 🔄 Review Schedule
- [ ] Review in 6 months
