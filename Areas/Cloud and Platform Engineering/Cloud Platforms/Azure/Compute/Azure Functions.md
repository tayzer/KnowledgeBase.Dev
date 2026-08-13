# Azure Functions
Date: 2026-06-26
Status: Needs Review
Tags: #azure #azure-functions #serverless #dotnet

## TL;DR / Quick Reference

**Definition:** Azure Functions is Azure's event-driven serverless compute service for running small units of code in response to triggers such as HTTP requests, queues, timers, blobs, Event Grid events, Service Bus messages, or Event Hubs streams.

**When to use:**
- Event-driven, bursty, scheduled, integration, or background-processing workloads.
- APIs or workers where managed scaling and low infrastructure overhead matter.
- Glue code between Azure services.

**Key Takeaways:**
- A Function has one trigger and can use bindings or SDK clients to interact with other services.
- Keep trigger code thin; put business logic in testable services.
- Design for retries, idempotency, cold starts, configuration, and observability.
- The Flex Consumption plan is the recommended Azure Functions hosting option for many new event-driven apps; choose Premium, Dedicated, or Container Apps when workload constraints require them.

---

## Deep Dive

### Mental Model

In ASP.NET Web API you usually think:

```text
Endpoint -> service -> repository -> response
```

In Azure Functions you usually think:

```text
Trigger -> function method -> service -> output or side effect
```

The trigger starts execution. Common triggers include HTTP, Queue Storage, Service Bus, Event Grid, Event Hubs, Blob Storage, and Timer.

### Good Fit

- HTTP APIs with variable traffic.
- Queue-triggered background processing.
- Scheduled jobs.
- Blob or Event Grid triggered file workflows.
- Event Hubs triggered telemetry processing.
- Integration glue between managed Azure services.

### Be Careful When

- Workflows are long-running and need durable state; consider Durable Functions or another workflow engine.
- Latency is strict and cold starts are unacceptable; consider Premium or Dedicated hosting.
- The function becomes a large mini-application with too much business logic in the trigger method.
- Local reproduction depends on many cloud-managed services.

### Design Guidance

- Keep function entry points small.
- Use dependency injection and services for core behavior.
- Prefer managed identity for Azure resources in production.
- Use `local.settings.json` only for local development.
- Make queue/message/event handlers idempotent because retries are normal.
- Use structured logs, correlation IDs, and Application Insights or OpenTelemetry.
- Use Azurite for local Blob, Queue, and Table Storage development where appropriate.

## Code Snippet

```csharp
[Function("ProcessCaseDocument")]
public async Task Run(
    [QueueTrigger("case-documents", Connection = "AzureWebJobsStorage")]
    string message,
    FunctionContext context,
    CancellationToken cancellationToken)
{
    await processor.ProcessAsync(message, cancellationToken);
}
```

## Related Concepts

- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]
- [[Azure Messaging Service Selection]]
- [[Azure Queue Storage]]
- [[Azure Service Bus]]
- [[Azure Event Grid]]
- [[Azure Event Hubs]]
- [[Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/Storage/Azurite]]
- [[Serverless Architecture]]

## Resources

- Microsoft Learn: Azure Functions overview
- Microsoft Learn: Azure Functions triggers and bindings
- Microsoft Learn: Azure Functions hosting options
- Microsoft Learn: Azure Functions .NET isolated worker guide

## Practice Exercises

1. Create an HTTP-triggered function that validates input and returns `202 Accepted`.
2. Add a Queue Storage trigger that processes work idempotently.
3. Move business logic out of a function method into an injected service and unit test it.

## Review Schedule

- [ ] Review in 3 months
