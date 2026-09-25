---
date: 2026-06-26
status: Current
tags:
  - azure
  - azure-functions
  - serverless
  - dotnet

---

# Azure Functions

## Quick Reference

**Definition:** Azure Functions is Azure's event-driven serverless compute service for running small units of code in response to triggers such as HTTP requests, queues, timers, blobs, Event Grid events, Service Bus messages, or Event Hubs streams.

**When to use:**
- Event-driven, bursty, scheduled, integration, or background-processing workloads.
- APIs or workers where managed scaling and low infrastructure overhead matter.
- Glue code between Azure services.

**Key Takeaways:**
- A Function has one trigger and can use bindings or SDK clients to interact with other services.
- Keep trigger code thin; put business logic in testable services.
- Design for retries, idempotency, cold starts, configuration, and observability.
- The Flex Consumption plan is the recommended serverless hosting plan for supported new Azure Functions workloads; choose Premium, Dedicated, or Container Apps when workload constraints require them.

**Limit:** Trigger, runtime, scaling, and timeout behavior depend on the hosting plan and extension versions.

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

Illustrative .NET isolated-worker function. Register ICaseDocumentProcessor in dependency injection and install the queue extension matching the Functions runtime. The SDK/extension versions and invocation still require a build and local run before promotion.

```csharp
public interface ICaseDocumentProcessor
{
    Task ProcessAsync(string message, CancellationToken cancellationToken);
}

public sealed class ProcessCaseDocument
{
    private readonly ICaseDocumentProcessor _processor;
    public ProcessCaseDocument(ICaseDocumentProcessor processor) => _processor = processor;

    [Function("ProcessCaseDocument")]
    public Task Run(
        [QueueTrigger("case-documents", Connection = "AzureWebJobsStorage")] string message,
        FunctionContext context,
        CancellationToken cancellationToken) =>
        _processor.ProcessAsync(message, cancellationToken);
}
```

## Hosting and trigger boundary

Each function has one trigger; input/output bindings are optional, and SDK clients remain useful when binding behavior is insufficient. Flex Consumption is Microsoft's recommended serverless hosting plan, but it is Linux-only and its Blob trigger uses the Event Grid source. Premium or Dedicated may fit other networking, runtime, or execution needs. Cold-start mitigation and retry behavior depend on plan and trigger extension. Verify the isolated-worker sample against exact package versions before promotion.

## Hosting choice snapshot

| Plan | Useful distinction | Check before choosing |
| --- | --- | --- |
| Flex Consumption | Event-driven scale and optional always-ready capacity; Linux only | Trigger/extension compatibility, network, cold start, and billing. |
| Premium | Prewarmed capacity and broader instance choices | Minimum warm-instance cost and execution limits. |
| Dedicated | Runs in an App Service plan | Existing capacity, scale configuration, and cost. |
| Container Apps | Functions runtime in a container environment | Replica minimum, container operations, and networking. |

Plan details change; use the [current hosting matrix](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale) (accessed 2026-09-24).

## Related Concepts

- [[40 Knowledge/Software Engineering/02 Areas/Cloud and Platform Engineering/Cloud Platforms/Azure/_Index]]
- [[Azure Messaging Service Selection]]
- [[Azure Queue Storage]]
- [[Azure Service Bus]]
- [[Azure Event Grid]]
- [[Azure Event Hubs]]
- [[Azurite]]
- [[Serverless Architecture]]

## Resources

- [Primary documentation](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale) (accessed 2026-09-24).

- [Microsoft Learn: Azure Functions overview](https://learn.microsoft.com/en-us/azure/azure-functions/functions-overview) (accessed 2026-09-24).
- [Microsoft Learn: Azure Functions triggers and bindings](https://learn.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings) (accessed 2026-09-24).
- [Microsoft Learn: Azure Functions hosting options](https://learn.microsoft.com/en-us/azure/azure-functions/functions-scale) (accessed 2026-09-24).
- [Microsoft Learn: Azure Functions .NET isolated worker guide](https://learn.microsoft.com/en-us/azure/azure-functions/dotnet-isolated-process-guide) (accessed 2026-09-24).

## Practice Exercises

1. Create an HTTP-triggered function that validates input and returns `202 Accepted`.
2. Add a Queue Storage trigger that processes work idempotently.
3. Move business logic out of a function method into an injected service and unit test it.

## Review Schedule

- [ ] Review in 3 months
- Draft fact-check: 2026-09-24. Set the next dated review when promoted.
