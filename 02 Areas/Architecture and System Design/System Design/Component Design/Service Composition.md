---
date: 2026-05-23
status: Current
tags:
  - architecture
  - service-composition
  - distributed
  - integration

---

# Service Composition

## Quick Reference

**Definition:** A composition service assembles a read-oriented response from multiple downstream services without becoming the source of truth for the underlying domain data.

**When to use:**
- Composite reports, unified profiles, or read models that need data from several service boundaries.
- Consumer-facing responses that should hide cross-service complexity behind one contract.
- Workflows where source ownership stays with downstream services and eventual consistency or partial completeness is acceptable.

**Key Takeaways:**
- **Composition services own orchestration and response assembly, not source-of-truth rules** for downstream domains.
- **Keep adapters and mappers mechanical** and move canonical rules to the owning service or an explicit policy component.
- Caution: **Fan-out amplifies latency and failure**; use synchronous composition only when the SLA and dependency reliability support it.

---

## Deep Dive

### What It Is And What It Is Not
Service composition is a read-side pattern. A caller asks one service for a report or aggregated view, and that service gathers data from several downstream services, applies response-shaping logic, and returns one contract.

It is not:
- a reason to read other services' databases directly
- a replacement for canonical domain logic inside source services
- identical to an API gateway or BFF: those can also aggregate, but this note concentrates on a report-specific read policy and completeness contract
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
For a report with multiple optional sources, the top-level handler can launch builders in parallel. Each optional call must convert expected downstream failures to an unavailable result before `Task.WhenAll`; otherwise a failed task throws and no partial response is assembled. Required-source failures should propagate. The sample is illustrative and assumes an existing `SectionResult` contract.

```csharp
// Illustrative: each optional source converts its own expected failure to
// an unavailable result; required-source failures still fail the request.
async Task<SectionResult> OptionalAsync(
    string source, Func<Task<SectionResult>> build)
{
    try { return await build(); }
    catch (HttpRequestException) { return SectionResult.Unavailable(source); }
    catch (TimeoutException) { return SectionResult.Unavailable(source); }
    catch (OperationCanceledException) when (!cancellationToken.IsCancellationRequested)
    { return SectionResult.Unavailable(source); }
}

var tasks = new[]
{
    OptionalAsync("sanctions", () => _sanctions.BuildAsync(subjectId, cancellationToken)
        .WaitAsync(TimeSpan.FromSeconds(2), cancellationToken)),
    OptionalAsync("addresses", () => _addresses.BuildAsync(subjectId, cancellationToken)
        .WaitAsync(TimeSpan.FromSeconds(2), cancellationToken))
};
var sections = await Task.WhenAll(tasks);
var missingSources = sections.Where(x => !x.IsAvailable)
    .Select(x => x.SourceName).ToArray();
// Assemble IsPartial, MissingSources, AsOfUtc, and Sections from these results.
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
- Retry only **operations safe to repeat** for transient failures. Reads commonly qualify; a write needs an explicit idempotency guarantee, such as a deduplication key, before retrying.
- Return **explicit completeness metadata** for partial reports rather than silently substituting defaults.
- Avoid distributed transactions; the composition service is assembling a read model, not coordinating atomic writes.

### Tradeoffs / When Not To Use
- Strong consistency across domains is required in one response.
- The caller's latency budget cannot tolerate six-service fan-out.
- The same report is requested frequently enough that a cached or precomputed read model would be simpler.
- The composition layer is starting to duplicate canonical logic that belongs inside downstream domains.

### Deadline and partial-response policy

Set an overall deadline as well as per-source timeouts. A missing optional source is reported with its name and freshness; a required source makes the report fail with an explicit error. Avoid silent defaults that look authoritative. For repeated reports with demanding latency or cross-source joins, compare a precomputed projection. [Microsoft Gateway Aggregation](https://learn.microsoft.com/en-us/azure/architecture/patterns/gateway-aggregation) (updated 2026-06-03; checked 2026-09-24) describes related fan-out risks.

## Related Concepts
- [[Service Communication]]
- [[API Gateway Pattern]]
- [[Backend for Frontend]]
- [[CQRS]]
- [[Event-Driven Architecture]]
- [[Materialized Read Model]]

## Sources

- [Microsoft, Gateway Aggregation pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/gateway-aggregation) — last updated 2026-06-03; accessed 2026-09-24.

## Review Schedule
- [ ] Review in 3 months
