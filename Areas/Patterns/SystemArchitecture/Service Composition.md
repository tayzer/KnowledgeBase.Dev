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

The important decision is not just `Task.WhenAll`; it is how each section builder reports availability and how the orchestrator treats required versus optional dependencies.

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

## 💻 Reference Example (.NET)

This example shows a read-side composition service that fans out to six section builders in parallel. Only the Insolvencies slice is expanded in full; the other five are reduced to their boundary shapes so the note stays maintainable.

The example is intentionally compile-close, not production-complete. Retries, telemetry, authentication, and resilience policies are omitted for brevity.

### Example Layout

```text
ReportComposition/
  Host/
    Program.cs

  Application/
    Reports/
      GetReport/
        GetReportQuery.cs
        GetReportHandler.cs
        ReportResponse.cs
        ReportUnavailableException.cs

    Insolvencies/
      IInsolvenciesClient.cs
      InsolvenciesMapper.cs
      InsolvenciesRules.cs
      InsolvenciesSectionBuilder.cs
      InsolvencyFacts.cs
      InsolvenciesSection.cs

    Sanctions/
      SanctionsSection.cs
      SanctionsSectionBuilder.cs

    Addresses/
      AddressesSection.cs
      AddressesSectionBuilder.cs

    Directors/
      DirectorsSection.cs
      DirectorsSectionBuilder.cs

    Filings/
      FilingsSection.cs
      FilingsSectionBuilder.cs

    Charges/
      ChargesSection.cs
      ChargesSectionBuilder.cs

  Infrastructure/
    Insolvencies/
      InsolvenciesHttpClient.cs
      InsolvenciesApiResponse.cs
```

### Core Contracts

```csharp
#nullable enable

public sealed record GetReportQuery(string SubjectId);

public sealed record ReportSectionMetadata(
    string SourceName,
    bool IsRequired,
    bool IsAvailable,
    string? WarningCode = null,
    string? WarningMessage = null);

public sealed record ReportResponse(
    string SubjectId,
    DateTimeOffset AsOfUtc,
    bool IsPartial,
    IReadOnlyList<ReportSectionMetadata> SectionMetadata,
    InsolvenciesSection Insolvencies,
    SanctionsSection Sanctions,
    AddressesSection Addresses,
    DirectorsSection Directors,
    FilingsSection Filings,
    ChargesSection Charges);

public sealed class ReportUnavailableException : Exception
{
    public ReportUnavailableException(IReadOnlyList<string> missingRequiredSources)
        : base($"Required sources unavailable: {string.Join(", ", missingRequiredSources)}")
    {
        MissingRequiredSources = missingRequiredSources;
    }

    public IReadOnlyList<string> MissingRequiredSources { get; }
}

public sealed record SectionResult<TSection>(
    string SourceName,
    bool IsRequired,
    bool IsAvailable,
    TSection Section,
    string? WarningCode = null,
    string? WarningMessage = null);

public interface ISectionBuilder<TSection>
{
    Task<SectionResult<TSection>> BuildAsync(string subjectId, CancellationToken cancellationToken);
}

public sealed record SanctionsSection(bool HasMatch, string? MatchReference);
public sealed record AddressesSection(int AddressCount);
public sealed record DirectorsSection(int CurrentDirectorCount);
public sealed record FilingsSection(int FilingCount);
public sealed record ChargesSection(int OutstandingChargeCount);
```

### Top-Level Handler

```csharp
public sealed class GetReportHandler
{
    private readonly ISectionBuilder<InsolvenciesSection> _insolvencies;
    private readonly ISectionBuilder<SanctionsSection> _sanctions;
    private readonly ISectionBuilder<AddressesSection> _addresses;
    private readonly ISectionBuilder<DirectorsSection> _directors;
    private readonly ISectionBuilder<FilingsSection> _filings;
    private readonly ISectionBuilder<ChargesSection> _charges;

    public GetReportHandler(
        ISectionBuilder<InsolvenciesSection> insolvencies,
        ISectionBuilder<SanctionsSection> sanctions,
        ISectionBuilder<AddressesSection> addresses,
        ISectionBuilder<DirectorsSection> directors,
        ISectionBuilder<FilingsSection> filings,
        ISectionBuilder<ChargesSection> charges)
    {
        _insolvencies = insolvencies;
        _sanctions = sanctions;
        _addresses = addresses;
        _directors = directors;
        _filings = filings;
        _charges = charges;
    }

    public async Task<ReportResponse> HandleAsync(
        GetReportQuery query,
        CancellationToken cancellationToken)
    {
        var insolvenciesTask = _insolvencies.BuildAsync(query.SubjectId, cancellationToken);
        var sanctionsTask = _sanctions.BuildAsync(query.SubjectId, cancellationToken);
        var addressesTask = _addresses.BuildAsync(query.SubjectId, cancellationToken);
        var directorsTask = _directors.BuildAsync(query.SubjectId, cancellationToken);
        var filingsTask = _filings.BuildAsync(query.SubjectId, cancellationToken);
        var chargesTask = _charges.BuildAsync(query.SubjectId, cancellationToken);

        await Task.WhenAll(
            insolvenciesTask,
            sanctionsTask,
            addressesTask,
            directorsTask,
            filingsTask,
            chargesTask);

        var insolvencies = await insolvenciesTask;
        var sanctions = await sanctionsTask;
        var addresses = await addressesTask;
        var directors = await directorsTask;
        var filings = await filingsTask;
        var charges = await chargesTask;

        var metadata = new[]
        {
            ToMetadata(insolvencies),
            ToMetadata(sanctions),
            ToMetadata(addresses),
            ToMetadata(directors),
            ToMetadata(filings),
            ToMetadata(charges)
        };

        var missingRequiredSources = metadata
            .Where(x => x.IsRequired && !x.IsAvailable)
            .Select(x => x.SourceName)
            .ToArray();

        if (missingRequiredSources.Length > 0)
        {
            throw new ReportUnavailableException(missingRequiredSources);
        }

        return new ReportResponse(
            SubjectId: query.SubjectId,
            AsOfUtc: DateTimeOffset.UtcNow,
            IsPartial: metadata.Any(x => !x.IsAvailable),
            SectionMetadata: metadata,
            Insolvencies: insolvencies.Section,
            Sanctions: sanctions.Section,
            Addresses: addresses.Section,
            Directors: directors.Section,
            Filings: filings.Section,
            Charges: charges.Section);
    }

    private static ReportSectionMetadata ToMetadata<TSection>(SectionResult<TSection> result)
    {
        return new ReportSectionMetadata(
            SourceName: result.SourceName,
            IsRequired: result.IsRequired,
            IsAvailable: result.IsAvailable,
            WarningCode: result.WarningCode,
            WarningMessage: result.WarningMessage);
    }
}
```

### Insolvencies Slice In Full

The transport DTOs would normally live in the infrastructure project. They are inlined here so the example can be read end to end.

```csharp
public sealed record InsolvenciesSection(
    int CaseCount,
    bool HasActiveInsolvency,
    string RiskBand,
    string? LatestCaseReference,
    string? Summary);

public sealed record InsolvencyFacts(
    int TotalCases,
    int ActiveCases,
    string? LatestCaseReference);

public interface IInsolvenciesClient
{
    Task<InsolvenciesApiResponse> GetAsync(string subjectId, CancellationToken cancellationToken);
}

public sealed record InsolvenciesApiResponse(IReadOnlyList<InsolvencyCaseApiModel> Cases);

public sealed record InsolvencyCaseApiModel(
    string Reference,
    string Status,
    DateOnly? RegisteredOn);

public sealed class InsolvenciesMapper
{
    public InsolvencyFacts Map(InsolvenciesApiResponse response)
    {
        var latestCase = response.Cases
            .OrderByDescending(x => x.RegisteredOn)
            .FirstOrDefault();

        return new InsolvencyFacts(
            TotalCases: response.Cases.Count,
            ActiveCases: response.Cases.Count(x =>
                string.Equals(x.Status, "Active", StringComparison.OrdinalIgnoreCase)),
            LatestCaseReference: latestCase?.Reference);
    }
}

public sealed class InsolvenciesRules
{
    public bool HasActiveInsolvency(InsolvencyFacts facts) => facts.ActiveCases > 0;

    public string GetRiskBand(InsolvencyFacts facts)
    {
        if (facts.ActiveCases > 0)
        {
            return "High";
        }

        if (facts.TotalCases > 0)
        {
            return "Medium";
        }

        return "Low";
    }

    public string BuildSummary(InsolvencyFacts facts)
    {
        if (facts.TotalCases == 0)
        {
            return "No insolvency cases found.";
        }

        if (facts.ActiveCases > 0)
        {
            return $"Active insolvency cases found: {facts.ActiveCases}.";
        }

        return $"Historical insolvency cases found: {facts.TotalCases}.";
    }
}

public sealed class InsolvenciesSectionBuilder : ISectionBuilder<InsolvenciesSection>
{
    private readonly IInsolvenciesClient _client;
    private readonly InsolvenciesMapper _mapper;
    private readonly InsolvenciesRules _rules;

    public InsolvenciesSectionBuilder(
        IInsolvenciesClient client,
        InsolvenciesMapper mapper,
        InsolvenciesRules rules)
    {
        _client = client;
        _mapper = mapper;
        _rules = rules;
    }

    public async Task<SectionResult<InsolvenciesSection>> BuildAsync(
        string subjectId,
        CancellationToken cancellationToken)
    {
        try
        {
            using var timeoutCts = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
            timeoutCts.CancelAfter(TimeSpan.FromSeconds(2));

            var response = await _client.GetAsync(subjectId, timeoutCts.Token);
            var facts = _mapper.Map(response);

            var section = new InsolvenciesSection(
                CaseCount: facts.TotalCases,
                HasActiveInsolvency: _rules.HasActiveInsolvency(facts),
                RiskBand: _rules.GetRiskBand(facts),
                LatestCaseReference: facts.LatestCaseReference,
                Summary: _rules.BuildSummary(facts));

            return new SectionResult<InsolvenciesSection>(
                SourceName: "Insolvencies",
                IsRequired: true,
                IsAvailable: true,
                Section: section);
        }
        catch (OperationCanceledException) when (!cancellationToken.IsCancellationRequested)
        {
            return Unavailable("Timeout", "Insolvencies request timed out.");
        }
        catch (HttpRequestException)
        {
            return Unavailable("Unavailable", "Insolvencies service was unavailable.");
        }
    }

    private static SectionResult<InsolvenciesSection> Unavailable(string warningCode, string warningMessage)
    {
        return new SectionResult<InsolvenciesSection>(
            SourceName: "Insolvencies",
            IsRequired: true,
            IsAvailable: false,
            Section: new InsolvenciesSection(
                CaseCount: 0,
                HasActiveInsolvency: false,
                RiskBand: "Unknown",
                LatestCaseReference: null,
                Summary: null),
            WarningCode: warningCode,
            WarningMessage: warningMessage);
    }
}
```

### The Other Five Sections Follow The Same Shape

The other downstream services should repeat the same boundary: client -> mapper -> rules or assembler -> `SectionResult<TSection>`.

```csharp
public sealed class SanctionsSectionBuilder : ISectionBuilder<SanctionsSection>
{
    public Task<SectionResult<SanctionsSection>> BuildAsync(string subjectId, CancellationToken cancellationToken)
        => throw new NotImplementedException();
}

public sealed class AddressesSectionBuilder : ISectionBuilder<AddressesSection>
{
    public Task<SectionResult<AddressesSection>> BuildAsync(string subjectId, CancellationToken cancellationToken)
        => throw new NotImplementedException();
}

public sealed class DirectorsSectionBuilder : ISectionBuilder<DirectorsSection>
{
    public Task<SectionResult<DirectorsSection>> BuildAsync(string subjectId, CancellationToken cancellationToken)
        => throw new NotImplementedException();
}

public sealed class FilingsSectionBuilder : ISectionBuilder<FilingsSection>
{
    public Task<SectionResult<FilingsSection>> BuildAsync(string subjectId, CancellationToken cancellationToken)
        => throw new NotImplementedException();
}

public sealed class ChargesSectionBuilder : ISectionBuilder<ChargesSection>
{
    public Task<SectionResult<ChargesSection>> BuildAsync(string subjectId, CancellationToken cancellationToken)
        => throw new NotImplementedException();
}
```

### DI Registration

```csharp
builder.Services.AddTransient<InsolvenciesMapper>();
builder.Services.AddTransient<InsolvenciesRules>();

builder.Services.AddTransient<ISectionBuilder<InsolvenciesSection>, InsolvenciesSectionBuilder>();
builder.Services.AddTransient<ISectionBuilder<SanctionsSection>, SanctionsSectionBuilder>();
builder.Services.AddTransient<ISectionBuilder<AddressesSection>, AddressesSectionBuilder>();
builder.Services.AddTransient<ISectionBuilder<DirectorsSection>, DirectorsSectionBuilder>();
builder.Services.AddTransient<ISectionBuilder<FilingsSection>, FilingsSectionBuilder>();
builder.Services.AddTransient<ISectionBuilder<ChargesSection>, ChargesSectionBuilder>();

builder.Services.AddHttpClient<IInsolvenciesClient, InsolvenciesHttpClient>(client =>
{
    client.BaseAddress = new Uri(builder.Configuration["Services:Insolvencies:BaseUrl"]!);
    client.Timeout = TimeSpan.FromSeconds(2);
});
```

### Testing Guidance

- Unit test the handler so an **optional** section returns a partial report rather than failing the whole composition.
- Unit test the handler so a **required** section produces the chosen failure behavior when unavailable.
- Unit test the mapper separately so it stays mechanical and does not absorb policy logic.
- Unit test the rules service separately around threshold and edge-case behaviour.

## 🔗 Related Concepts
- [[Service Based Architecture]]
- [[ServiceCommunication]]
- [[CleanArchitecture]]
- [[CQRS]]
- [[EventDriven]]
- [[Mappers]]

## 🔄 Review Schedule
- [ ] Review in 3 months