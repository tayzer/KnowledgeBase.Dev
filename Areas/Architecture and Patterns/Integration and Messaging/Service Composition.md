# Service Composition
Date: 2026-05-23
Status: 🟡 Needs Review
Tags: #architecture #service-composition #distributed #integration

## 🎯 TL;DR / Quick Reference

**Definition:** A composition service assembles a read-oriented response from multiple downstream services without becoming the source of truth for the underlying domain data.

**When to use:**
- Composite reports, unified profiles, or read models that need data from several service boundaries.
- Consumer-facing responses that should hide cross-service complexity behind one contract.
- Workflows where source ownership stays with downstream services and eventual consistency or partial completeness is acceptable.

**Key Takeaways:**
- ✅ **Composition services own orchestration and response assembly, not source-of-truth rules** for downstream domains.
- ✅ **Keep adapters and mappers mechanical** and move canonical rules to the owning service or an explicit policy component.
- ⚠️ **Fan-out amplifies latency and failure**; use synchronous composition only when the SLA and dependency reliability support it.

---

## 📚 Deep Dive

### What It Is And What It Is Not
Service composition is a read-side pattern. A caller asks one service for a report or aggregated view, and that service gathers data from several downstream services, applies response-shaping logic, and returns one contract.

It is not:
- a reason to read other services' databases directly
- a replacement for canonical domain logic inside source services
- the same thing as an API gateway or BFF, which usually focuses more on routing, auth, or protocol translation than report-specific assembly rules
- the same thing as write orchestration across services

### Typical Internal Breakdown
Within the composition service, a practical split is:
- **Query handler or orchestrator:** owns deadlines, fan-out, required versus optional source policy, and final assembly.
- **Per-service adapter:** wraps the external call for one downstream service.
- **Transport DTO:** represents the downstream contract and stays at the edge.
- **Mapper:** performs mechanical reshaping from the transport DTO into a small internal source snapshot model.
- **Policy or rule component:** applies report-specific meaning or derived logic.
- **Section builder or assembler:** turns the source snapshot and derived values into the final section returned to the caller.

This keeps the orchestrator from turning into a god service while keeping business decisions explicit and testable.

### Mapper Versus Rule Service

| Concern | Mapper | Rule / Policy / Assembler |
|---|---|---|
| Copy or rename a downstream field | Yes | No |
| Parse dates, enums, numbers, or normalize null values | Yes | No |
| Translate transport-specific shapes into a local snapshot model | Yes | No |
| Derive a risk band or status | No | Yes |
| Combine multiple service results into one field | No | Yes |
| Apply report-specific inclusion or precedence rules | No | Yes |
| Call other services or repositories to finish the value | No | Yes |

If the logic changes business meaning, depends on policy, or combines sources, it is no longer just mapping.

### Parallel Fan-Out Across Multiple Services
For a report that depends on six asset services, the top-level handler can launch section builders in parallel and then assemble the response once all results complete or time out.

```csharp
var insolvenciesTask = _insolvencies.BuildAsync(subjectId, cancellationToken);
var sanctionsTask = _sanctions.BuildAsync(subjectId, cancellationToken);
var addressesTask = _addresses.BuildAsync(subjectId, cancellationToken);
var directorsTask = _directors.BuildAsync(subjectId, cancellationToken);
var filingsTask = _filings.BuildAsync(subjectId, cancellationToken);
var chargesTask = _charges.BuildAsync(subjectId, cancellationToken);

await Task.WhenAll(
    insolvenciesTask,
    sanctionsTask,
    addressesTask,
    directorsTask,
    filingsTask,
    chargesTask);

var sections = new[]
{
    await insolvenciesTask,
    await sanctionsTask,
    await addressesTask,
    await directorsTask,
    await filingsTask,
    await chargesTask
};

var missingSources = sections
    .Where(x => !x.IsAvailable)
    .Select(x => x.SourceName)
    .ToArray();

var response = new ReportResponse(
    SubjectId: subjectId,
    AsOfUtc: DateTimeOffset.UtcNow,
    IsPartial: missingSources.Length > 0,
    MissingSources: missingSources,
    Sections: sections);
```

### Freshness, Consistency, And Completeness
A composed report is often useful without being a transactional snapshot across all services. In most distributed systems, the composition service should assume:
- source data can arrive at different times
- a report can be complete enough for the use case without every source succeeding
- consumers need explicit completeness metadata when data is missing or stale

Good response contracts often include fields such as `AsOfUtc`, `IsPartial`, and `MissingSources` so the caller can understand what it received.

If the use case requires strong cross-service consistency, a synchronous composition service may be the wrong pattern. A precomputed projection, data pipeline, or asynchronous report job can be a better fit.

### Failure Handling
- Classify downstream sources as **required** or **optional**.
- Use **per-call timeouts** and an overall deadline for the report.
- Retry only **idempotent read calls** and only for transient failures.
- Return **explicit completeness metadata** for partial reports rather than silently substituting defaults.
- Avoid distributed transactions; the composition service is assembling a read model, not coordinating atomic writes.

### Tradeoffs / When Not To Use
- Strong consistency across domains is required in one response.
- The caller's latency budget cannot tolerate six-service fan-out.
- The same report is requested frequently enough that a cached or precomputed read model would be simpler.
- The composition layer is starting to duplicate canonical logic that belongs inside downstream domains.

## 🔗 Related Concepts
- [[ServiceCommunication]]
- [[CQRS]]
- [[Event Driven]]

## 🔄 Review Schedule
- [ ] Review in 3 months
