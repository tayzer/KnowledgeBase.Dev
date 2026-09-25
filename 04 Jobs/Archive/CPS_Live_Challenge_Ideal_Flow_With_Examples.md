# CPS Live Challenge: Ideal Flow With Examples

Use this when you need something concrete to hold onto during the live coding exercise.

The basic rhythm is:

```text
Clarify -> Design -> Test -> Build -> Harden -> Explain
```

If you freeze, come back to this:

```csharp
var item = await repository.GetByIdAsync(id, cancellationToken);
return item is null ? Results.NotFound() : Results.Ok(item);
```

That is the shape of a lot of API work: receive input, call the service/repository, handle missing/invalid cases, return the right HTTP response.

## Example Scenario

Imagine they ask you to build a small case document API.

Functional requirements:

- Create a case document record.
- Retrieve a record by id.
- List records by status.
- Reject invalid requests.

Example record:

```json
{
  "caseUrn": "CPS-2026-001",
  "documentType": "WitnessStatement",
  "status": "Received",
  "receivedAt": "2026-06-16T10:30:00Z"
}
```

## 1. Clarify

Say:

```text
Before I start coding, I want to confirm the main behaviour and the important edge cases so I can keep the solution focused.
```

Ask:

- What fields are required?
- What should happen if a record is not found?
- Should records persist after restart?
- Should I use local Azure Storage through Azurite?
- Are tests expected in the timebox?
- Are there any statuses or document types I should validate?

Summarise:

```text
I understand the core requirement as: create a case document, retrieve it by id, and list by status. I will build a small vertical slice first, then add validation, tests, and persistence if time allows.
```

## 2. State the Design

Say:

```text
I will keep the design proportionate for the timebox. I will use Minimal APIs, request/response DTOs, a small service if business rules grow, and a repository abstraction so storage can be swapped from in-memory to Azurite or Azure Storage.
```

Possible folder structure:

```text
Api/
  Program.cs
  Contracts/
  Domain/
  Repositories/
Tests/
```

For a short challenge, this is enough. Do not create layers just to look impressive.

## 3. Start With the Domain Shape

Create a simple domain model:

```csharp
public sealed record CaseDocument(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);
```

Create request and response DTOs:

```csharp
public sealed record CreateCaseDocumentRequest(
    string? CaseUrn,
    string? DocumentType,
    string? Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseDocumentResponse(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);
```

Mapping helper:

```csharp
static CaseDocumentResponse ToResponse(CaseDocument document)
{
    return new CaseDocumentResponse(
        document.Id,
        document.CaseUrn,
        document.DocumentType,
        document.Status,
        document.ReceivedAt);
}
```

## 4. Add the Repository Interface

Say:

```text
I am putting storage behind an interface so the API does not care whether this is in-memory, Azurite, or a real Azure service.
```

```csharp
public interface ICaseDocumentRepository
{
    Task AddAsync(CaseDocument document, CancellationToken cancellationToken);

    Task<CaseDocument?> GetByIdAsync(
        Guid id,
        CancellationToken cancellationToken);

    Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(
        string status,
        CancellationToken cancellationToken);
}
```

## 5. Add an In-Memory Repository First

This is fast and keeps you moving.

```csharp
public sealed class InMemoryCaseDocumentRepository : ICaseDocumentRepository
{
    private readonly Dictionary<Guid, CaseDocument> _documents = new();

    public Task AddAsync(CaseDocument document, CancellationToken cancellationToken)
    {
        _documents[document.Id] = document;
        return Task.CompletedTask;
    }

    public Task<CaseDocument?> GetByIdAsync(
        Guid id,
        CancellationToken cancellationToken)
    {
        _documents.TryGetValue(id, out var document);
        return Task.FromResult(document);
    }

    public Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(
        string status,
        CancellationToken cancellationToken)
    {
        var results = _documents.Values
            .Where(x => string.Equals(x.Status, status, StringComparison.OrdinalIgnoreCase))
            .ToList();

        return Task.FromResult<IReadOnlyList<CaseDocument>>(results);
    }
}
```

Register it:

```csharp
builder.Services.AddSingleton<ICaseDocumentRepository, InMemoryCaseDocumentRepository>();
```

## 6. Write a First Test

Say:

```text
I will pin the main happy path with a small test before wiring everything into the endpoint.
```

Example xUnit test:

```csharp
[Fact]
public async Task GetByIdAsync_ReturnsDocument_WhenDocumentExists()
{
    var repository = new InMemoryCaseDocumentRepository();

    var document = new CaseDocument(
        Guid.NewGuid(),
        "CPS-2026-001",
        "WitnessStatement",
        "Received",
        DateTimeOffset.UtcNow);

    await repository.AddAsync(document, CancellationToken.None);

    var result = await repository.GetByIdAsync(document.Id, CancellationToken.None);

    Assert.NotNull(result);
    Assert.Equal(document.Id, result.Id);
}
```

Missing item test:

```csharp
[Fact]
public async Task GetByIdAsync_ReturnsNull_WhenDocumentDoesNotExist()
{
    var repository = new InMemoryCaseDocumentRepository();

    var result = await repository.GetByIdAsync(Guid.NewGuid(), CancellationToken.None);

    Assert.Null(result);
}
```

## 7. Build POST Create Endpoint

Say:

```text
I will now create the thinnest working endpoint for adding a record.
```

```csharp
app.MapPost("/case-documents", async (
    CreateCaseDocumentRequest request,
    ICaseDocumentRepository repository,
    CancellationToken cancellationToken) =>
{
    if (string.IsNullOrWhiteSpace(request.CaseUrn))
    {
        return Results.BadRequest("Case URN is required.");
    }

    if (string.IsNullOrWhiteSpace(request.DocumentType))
    {
        return Results.BadRequest("Document type is required.");
    }

    if (string.IsNullOrWhiteSpace(request.Status))
    {
        return Results.BadRequest("Status is required.");
    }

    if (request.ReceivedAt > DateTimeOffset.UtcNow)
    {
        return Results.BadRequest("Received date cannot be in the future.");
    }

    var document = new CaseDocument(
        Guid.NewGuid(),
        request.CaseUrn.Trim(),
        request.DocumentType.Trim(),
        request.Status.Trim(),
        request.ReceivedAt);

    await repository.AddAsync(document, cancellationToken);

    return Results.Created(
        $"/case-documents/{document.Id}",
        ToResponse(document));
});
```

What this shows:

- Validates input.
- Creates a domain record.
- Saves through repository.
- Returns `201 Created`.
- Includes a location for the new resource.

## 8. Build GET by Id Endpoint

This is the pattern you were worried about. It is small.

Say:

```text
Now I will add retrieval by id. The important behaviour is returning 404 if the record does not exist.
```

```csharp
app.MapGet("/case-documents/{id:guid}", async (
    Guid id,
    ICaseDocumentRepository repository,
    CancellationToken cancellationToken) =>
{
    var document = await repository.GetByIdAsync(id, cancellationToken);

    if (document is null)
    {
        return Results.NotFound();
    }

    return Results.Ok(ToResponse(document));
});
```

Memory hook:

```text
Route id -> repository lookup -> null means 404 -> found means 200 OK.
```

Even shorter:

```csharp
app.MapGet("/case-documents/{id:guid}", async (
    Guid id,
    ICaseDocumentRepository repository,
    CancellationToken cancellationToken) =>
{
    var document = await repository.GetByIdAsync(id, cancellationToken);
    return document is null ? Results.NotFound() : Results.Ok(ToResponse(document));
});
```

## 9. Build GET List by Status Endpoint

Say:

```text
I will add a simple query endpoint for listing by status. If no status is supplied, I would normally discuss whether to return all records or reject the request.
```

```csharp
app.MapGet("/case-documents", async (
    string status,
    ICaseDocumentRepository repository,
    CancellationToken cancellationToken) =>
{
    if (string.IsNullOrWhiteSpace(status))
    {
        return Results.BadRequest("Status is required.");
    }

    var documents = await repository.ListByStatusAsync(status, cancellationToken);

    var response = documents
        .Select(ToResponse)
        .ToList();

    return Results.Ok(response);
});
```

Example request:

```http
GET /case-documents?status=Received
```

## 10. Move Validation Into a Helper if It Gets Noisy

If the endpoint gets messy, extract validation.

Say:

```text
The endpoint is starting to carry too much validation detail, so I will extract that to keep the HTTP layer readable.
```

```csharp
static string? Validate(CreateCaseDocumentRequest request)
{
    if (string.IsNullOrWhiteSpace(request.CaseUrn))
    {
        return "Case URN is required.";
    }

    if (string.IsNullOrWhiteSpace(request.DocumentType))
    {
        return "Document type is required.";
    }

    if (string.IsNullOrWhiteSpace(request.Status))
    {
        return "Status is required.";
    }

    if (request.ReceivedAt > DateTimeOffset.UtcNow)
    {
        return "Received date cannot be in the future.";
    }

    return null;
}
```

Endpoint becomes:

```csharp
app.MapPost("/case-documents", async (
    CreateCaseDocumentRequest request,
    ICaseDocumentRepository repository,
    CancellationToken cancellationToken) =>
{
    var validationError = Validate(request);

    if (validationError is not null)
    {
        return Results.BadRequest(validationError);
    }

    var document = new CaseDocument(
        Guid.NewGuid(),
        request.CaseUrn!.Trim(),
        request.DocumentType!.Trim(),
        request.Status!.Trim(),
        request.ReceivedAt);

    await repository.AddAsync(document, cancellationToken);

    return Results.Created(
        $"/case-documents/{document.Id}",
        ToResponse(document));
});
```

## 11. Add Azure Table Storage Later if Needed

Only do this once the in-memory version works.

Say:

```text
Now that the API shape works, I can swap the repository implementation to Azure Table Storage via Azurite.
```

Install package:

```powershell
dotnet add package Azure.Data.Tables
```

Configuration:

```json
{
  "Storage": {
    "ConnectionString": "UseDevelopmentStorage=true"
  }
}
```

Entity:

```csharp
using Azure;
using Azure.Data.Tables;

public sealed class CaseDocumentEntity : ITableEntity
{
    public string PartitionKey { get; set; } = default!;
    public string RowKey { get; set; } = default!;
    public DateTimeOffset? Timestamp { get; set; }
    public ETag ETag { get; set; }

    public string CaseUrn { get; set; } = default!;
    public string DocumentType { get; set; } = default!;
    public string Status { get; set; } = default!;
    public DateTimeOffset ReceivedAt { get; set; }
}
```

Repository:

```csharp
using Azure;
using Azure.Data.Tables;

public sealed class TableCaseDocumentRepository : ICaseDocumentRepository
{
    private const string PartitionKey = "case-document";
    private readonly TableClient _tableClient;

    public TableCaseDocumentRepository(TableClient tableClient)
    {
        _tableClient = tableClient;
    }

    public async Task AddAsync(CaseDocument document, CancellationToken cancellationToken)
    {
        await _tableClient.CreateIfNotExistsAsync(cancellationToken);

        var entity = new CaseDocumentEntity
        {
            PartitionKey = PartitionKey,
            RowKey = document.Id.ToString(),
            CaseUrn = document.CaseUrn,
            DocumentType = document.DocumentType,
            Status = document.Status,
            ReceivedAt = document.ReceivedAt
        };

        await _tableClient.UpsertEntityAsync(entity, cancellationToken: cancellationToken);
    }

    public async Task<CaseDocument?> GetByIdAsync(
        Guid id,
        CancellationToken cancellationToken)
    {
        try
        {
            var response = await _tableClient.GetEntityAsync<CaseDocumentEntity>(
                PartitionKey,
                id.ToString(),
                cancellationToken: cancellationToken);

            return ToDomain(response.Value);
        }
        catch (RequestFailedException ex) when (ex.Status == 404)
        {
            return null;
        }
    }

    public async Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(
        string status,
        CancellationToken cancellationToken)
    {
        var results = new List<CaseDocument>();

        var query = _tableClient.QueryAsync<CaseDocumentEntity>(
            x => x.PartitionKey == PartitionKey && x.Status == status,
            cancellationToken: cancellationToken);

        await foreach (var entity in query)
        {
            results.Add(ToDomain(entity));
        }

        return results;
    }

    private static CaseDocument ToDomain(CaseDocumentEntity entity)
    {
        return new CaseDocument(
            Guid.Parse(entity.RowKey),
            entity.CaseUrn,
            entity.DocumentType,
            entity.Status,
            entity.ReceivedAt);
    }
}
```

Register Table Storage:

```csharp
using Azure.Data.Tables;

var connectionString = builder.Configuration["Storage:ConnectionString"];

builder.Services.AddSingleton(_ =>
    new TableClient(connectionString, "CaseDocuments"));

builder.Services.AddSingleton<ICaseDocumentRepository, TableCaseDocumentRepository>();
```

If this starts taking too long, stop and say:

```text
I am going to keep the in-memory implementation so the working API remains intact. The repository boundary is ready for the Table Storage implementation, and I would complete that next.
```

That is a good senior tradeoff.

## 12. Add a Controller Version if They Prefer Controllers

Minimal APIs are fine, but if they ask for controllers, the GET-by-id shape is:

```csharp
[ApiController]
[Route("api/case-documents")]
public sealed class CaseDocumentsController : ControllerBase
{
    private readonly ICaseDocumentRepository _repository;

    public CaseDocumentsController(ICaseDocumentRepository repository)
    {
        _repository = repository;
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<CaseDocumentResponse>> GetById(
        Guid id,
        CancellationToken cancellationToken)
    {
        var document = await _repository.GetByIdAsync(id, cancellationToken);

        if (document is null)
        {
            return NotFound();
        }

        return Ok(ToResponse(document));
    }
}
```

Memory hook:

```text
Controller returns ActionResult<T>.
Minimal API returns Results.Ok / Results.NotFound.
The logic is the same.
```

## 13. Add Error Handling and Logging

For a small challenge, do not build a giant error framework.

Add logging where it helps:

```csharp
app.MapGet("/case-documents/{id:guid}", async (
    Guid id,
    ICaseDocumentRepository repository,
    ILogger<Program> logger,
    CancellationToken cancellationToken) =>
{
    var document = await repository.GetByIdAsync(id, cancellationToken);

    if (document is null)
    {
        logger.LogInformation("Case document {DocumentId} was not found.", id);
        return Results.NotFound();
    }

    return Results.Ok(ToResponse(document));
});
```

Say:

```text
I am logging the not-found path at information level because it is useful operationally but not necessarily an error.
```

## 14. Add a Health Check if Time Allows

```csharp
builder.Services.AddHealthChecks();

app.MapHealthChecks("/health");
```

Say:

```text
For production readiness I would expose a health endpoint and include dependency checks for storage.
```

## 15. Run It and Test Manually

Use Swagger if enabled, or an HTTP client.

POST:

```http
POST /case-documents
Content-Type: application/json

{
  "caseUrn": "CPS-2026-001",
  "documentType": "WitnessStatement",
  "status": "Received",
  "receivedAt": "2026-06-16T10:30:00Z"
}
```

GET by id:

```http
GET /case-documents/{id}
```

List by status:

```http
GET /case-documents?status=Received
```

Bad request example:

```http
POST /case-documents
Content-Type: application/json

{
  "caseUrn": "",
  "documentType": "WitnessStatement",
  "status": "Received",
  "receivedAt": "2026-06-16T10:30:00Z"
}
```

Expected result:

```text
400 Bad Request
Case URN is required.
```

## 16. Final Refactor Checklist

Before the end, quickly check:

- Does the project build?
- Do tests pass?
- Are route names clear?
- Do invalid requests return `400`?
- Does missing data return `404`?
- Does create return `201`?
- Are names readable?
- Is there any duplication worth removing quickly?
- Did you keep the working slice intact?

Run:

```powershell
dotnet test
```

## 17. Final Explanation

Say:

```text
What is working now is create, retrieve by id, and list by status. The solution uses a repository abstraction so persistence can move from in-memory to Azure Table Storage without changing the API shape. I added validation for required fields and future received dates, and I covered the core repository behaviour with tests.
```

Then:

```text
The main tradeoff I made was keeping the architecture compact for the timebox. In production I would add authentication and authorisation, structured problem details, integration tests against Azurite or a test storage account, CI/CD quality gates, health checks, monitoring, retry policies, and secure configuration through managed identity and Key Vault.
```

## Panic Card

If you forget POST:

```csharp
app.MapPost("/items", async (CreateRequest request, IRepository repository, CancellationToken ct) =>
{
    var item = new Item(Guid.NewGuid(), request.Name);
    await repository.AddAsync(item, ct);
    return Results.Created($"/items/{item.Id}", item);
});
```

If you forget GET by id:

```csharp
app.MapGet("/items/{id:guid}", async (Guid id, IRepository repository, CancellationToken ct) =>
{
    var item = await repository.GetByIdAsync(id, ct);
    return item is null ? Results.NotFound() : Results.Ok(item);
});
```

If you forget list:

```csharp
app.MapGet("/items", async (IRepository repository, CancellationToken ct) =>
{
    var items = await repository.ListAsync(ct);
    return Results.Ok(items);
});
```

If you forget validation:

```csharp
if (string.IsNullOrWhiteSpace(request.Name))
{
    return Results.BadRequest("Name is required.");
}
```

If you forget dependency injection:

```csharp
builder.Services.AddSingleton<IRepository, InMemoryRepository>();
```

If you forget the shape of a repository:

```csharp
public interface IRepository
{
    Task AddAsync(Item item, CancellationToken cancellationToken);
    Task<Item?> GetByIdAsync(Guid id, CancellationToken cancellationToken);
    Task<IReadOnlyList<Item>> ListAsync(CancellationToken cancellationToken);
}
```

## The Thing To Remember

You are not trying to prove that you remember every API from memory.

You are trying to show:

- You clarify before building.
- You build a working slice.
- You test meaningful behaviour.
- You handle missing and invalid data.
- You make proportionate architecture choices.
- You explain tradeoffs calmly.

That is the Lead Developer signal.
