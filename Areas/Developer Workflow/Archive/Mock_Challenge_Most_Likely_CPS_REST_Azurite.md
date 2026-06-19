# Most Likely CPS Mock Challenge: .NET 8 REST API With Azurite

Timebox: 75-90 minutes

Why this is the most likely shape:

- The challenge document asks for Visual Studio, Web Development, Cloud Development, `.NET 8`, Azurite, and an optional HTTP client.
- That strongly points to a small HTTP-accessible .NET solution with local Azure Storage.
- The CPS job spec also emphasises C#/.NET 8, RESTful APIs, Azure, clean architecture, testing, and pragmatic engineering standards.

Most likely task shape:

```text
Build a small .NET 8 REST API that accepts, stores, retrieves, and queries records using local Azure Storage via Azurite.
```

## Scenario

CPS receives digital case documents. Build a small service to store metadata about received case documents.

## Functional Requirements

Create a REST API with:

```http
POST /case-documents
GET /case-documents/{id}
GET /case-documents?status=Received
```

The API must store records in Azure Table Storage using Azurite locally.

## Data Model

A case document has:

- `id`
- `caseUrn`
- `documentType`
- `status`
- `receivedAt`

Allowed statuses:

- `Received`
- `Processing`
- `Processed`
- `Rejected`

## Example POST

```http
POST /case-documents
Content-Type: application/json

{
  "caseUrn": "CPS-2026-001",
  "documentType": "WitnessStatement",
  "status": "Received",
  "receivedAt": "2026-06-17T09:30:00Z"
}
```

Expected response:

```http
201 Created
Location: /case-documents/{id}
```

```json
{
  "id": "2c8cf2a0-833e-4a7d-923a-5fd66a4ec2f1",
  "caseUrn": "CPS-2026-001",
  "documentType": "WitnessStatement",
  "status": "Received",
  "receivedAt": "2026-06-17T09:30:00Z"
}
```

## Validation Rules

Return `400 Bad Request` when:

- `caseUrn` is missing or whitespace.
- `documentType` is missing or whitespace.
- `status` is missing, whitespace, or unknown.
- `receivedAt` is in the future.

Return `404 Not Found` when:

- `GET /case-documents/{id}` is called for a valid id that does not exist.

## Non-Functional Requirements

Show:

- Clear code structure.
- Sensible REST status codes.
- Azure Table Storage through Azurite.
- Configuration, not hard-coded secrets.
- Async methods and cancellation tokens.
- Basic tests for validation or repository behaviour.
- A short explanation of production hardening.

## Setup

Start Azurite:

```powershell
azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log
```

Create project:

```powershell
dotnet new webapi -n CpsCaseDocuments
cd CpsCaseDocuments
dotnet add package Azure.Data.Tables
```

Configuration:

```json
{
  "Storage": {
    "ConnectionString": "UseDevelopmentStorage=true",
    "TableName": "CaseDocuments"
  }
}
```

## Recommended Implementation Order

### 1. Clarify and State Design

Say:

```text
I will build a thin working REST slice first: DTOs, endpoints, validation, and a repository abstraction. I will then back the repository with Azure Table Storage through Azurite.
```

### 2. Create DTOs and Domain Record

```csharp
public sealed record CreateCaseDocumentRequest(
    string? CaseUrn,
    string? DocumentType,
    string? Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseDocument(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseDocumentResponse(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);
```

Mapping:

```csharp
static CaseDocumentResponse ToResponse(CaseDocument document) =>
    new(
        document.Id,
        document.CaseUrn,
        document.DocumentType,
        document.Status,
        document.ReceivedAt);
```

### 3. Create Reader/Writer Interfaces

```csharp
public interface ICaseDocumentReader
{
    Task<CaseDocument?> GetByIdAsync(Guid id, CancellationToken ct);
    Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(string status, CancellationToken ct);
}

public interface ICaseDocumentWriter
{
    Task AddAsync(CaseDocument document, CancellationToken ct);
}
```

Say:

```text
I split read and write contracts so endpoints depend only on the capability they need. The implementation can still be one class.
```

### 4. Implement POST First

```csharp
app.MapPost("/case-documents", async (
    CreateCaseDocumentRequest request,
    ICaseDocumentWriter writer,
    CancellationToken ct) =>
{
    var error = Validate(request);

    if (error is not null)
    {
        return Results.BadRequest(error);
    }

    var document = new CaseDocument(
        Guid.NewGuid(),
        request.CaseUrn!.Trim(),
        request.DocumentType!.Trim(),
        request.Status!.Trim(),
        request.ReceivedAt);

    await writer.AddAsync(document, ct);

    return Results.Created(
        $"/case-documents/{document.Id}",
        ToResponse(document));
});
```

### 5. Implement GET by Id

```csharp
app.MapGet("/case-documents/{id:guid}", async (
    Guid id,
    ICaseDocumentReader reader,
    CancellationToken ct) =>
{
    var document = await reader.GetByIdAsync(id, ct);

    return document is null
        ? Results.NotFound()
        : Results.Ok(ToResponse(document));
});
```

Panic memory:

```text
id -> reader.GetByIdAsync -> null means 404 -> found means 200.
```

### 6. Implement GET by Status

```csharp
app.MapGet("/case-documents", async (
    string status,
    ICaseDocumentReader reader,
    CancellationToken ct) =>
{
    if (string.IsNullOrWhiteSpace(status))
    {
        return Results.BadRequest("Status is required.");
    }

    var documents = await reader.ListByStatusAsync(status, ct);

    return Results.Ok(documents.Select(ToResponse));
});
```

### 7. Add Validation

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

    if (!IsValidStatus(request.Status))
    {
        return "Status is invalid.";
    }

    if (request.ReceivedAt > DateTimeOffset.UtcNow)
    {
        return "Received date cannot be in the future.";
    }

    return null;
}

static bool IsValidStatus(string? status)
{
    string[] allowed =
    [
        "Received",
        "Processing",
        "Processed",
        "Rejected"
    ];

    return allowed.Any(x =>
        string.Equals(x, status, StringComparison.OrdinalIgnoreCase));
}
```

### 8. Add Table Entity

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

For this mock:

```text
PartitionKey = "case-document"
RowKey = document.Id
```

Say:

```text
For production I would revisit partition key design around query patterns and scale. For this exercise, this keeps the implementation simple.
```

### 9. Add Table Repository

```csharp
using Azure;
using Azure.Data.Tables;

public sealed class TableCaseDocumentRepository :
    ICaseDocumentReader,
    ICaseDocumentWriter
{
    private const string PartitionKey = "case-document";
    private readonly TableClient _tableClient;

    public TableCaseDocumentRepository(TableClient tableClient)
    {
        _tableClient = tableClient;
    }

    public async Task AddAsync(CaseDocument document, CancellationToken ct)
    {
        await _tableClient.CreateIfNotExistsAsync(ct);

        var entity = new CaseDocumentEntity
        {
            PartitionKey = PartitionKey,
            RowKey = document.Id.ToString(),
            CaseUrn = document.CaseUrn,
            DocumentType = document.DocumentType,
            Status = document.Status,
            ReceivedAt = document.ReceivedAt
        };

        await _tableClient.AddEntityAsync(entity, ct);
    }

    public async Task<CaseDocument?> GetByIdAsync(Guid id, CancellationToken ct)
    {
        try
        {
            var response = await _tableClient.GetEntityAsync<CaseDocumentEntity>(
                PartitionKey,
                id.ToString(),
                cancellationToken: ct);

            return ToDomain(response.Value);
        }
        catch (RequestFailedException ex) when (ex.Status == 404)
        {
            return null;
        }
    }

    public async Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(
        string status,
        CancellationToken ct)
    {
        var results = new List<CaseDocument>();

        var query = _tableClient.QueryAsync<CaseDocumentEntity>(
            x => x.PartitionKey == PartitionKey && x.Status == status,
            cancellationToken: ct);

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

### 10. Register Dependencies

```csharp
using Azure.Data.Tables;

var connectionString = builder.Configuration["Storage:ConnectionString"];
var tableName = builder.Configuration["Storage:TableName"] ?? "CaseDocuments";

builder.Services.AddSingleton(_ =>
    new TableClient(connectionString, tableName));

builder.Services.AddScoped<TableCaseDocumentRepository>();

builder.Services.AddScoped<ICaseDocumentReader>(sp =>
    sp.GetRequiredService<TableCaseDocumentRepository>());

builder.Services.AddScoped<ICaseDocumentWriter>(sp =>
    sp.GetRequiredService<TableCaseDocumentRepository>());
```

Say:

```text
The Azure SDK client can be reused. The repository is scoped as a safe default and stays stateless.
```

## Tests To Write If Time Allows

Start with validation tests:

```csharp
[Fact]
public void Validate_ReturnsError_WhenCaseUrnMissing()
{
    var request = new CreateCaseDocumentRequest(
        "",
        "WitnessStatement",
        "Received",
        DateTimeOffset.UtcNow);

    var error = Validate(request);

    Assert.Equal("Case URN is required.", error);
}
```

Then repository tests if time allows:

```csharp
[Fact]
public async Task GetByIdAsync_ReturnsNull_WhenMissing()
{
    var repository = CreateRepository();

    var result = await repository.GetByIdAsync(Guid.NewGuid(), CancellationToken.None);

    Assert.Null(result);
}
```

If repository setup takes too long, say:

```text
For the timebox I will test validation and core rules. In the real project I would add integration tests against Azurite for the Table Storage repository.
```

## Acceptance Criteria

You are done when:

- Valid POST returns `201 Created`.
- Response body includes the new id.
- Location points to `/case-documents/{id}`.
- GET by id returns the created record.
- Unknown id returns `404`.
- GET by status returns matching records.
- Invalid requests return `400`.
- Data is stored in Azurite Table Storage.

## Stretch Goals

Only add after the core flow works:

- Duplicate detection by `caseUrn` and `documentType`.
- Pagination for list endpoint.
- `PUT /case-documents/{id}/status`.
- Health check endpoint.
- Swagger metadata.
- ProblemDetails responses.
- Integration test against Azurite.

## Final Explanation Script

```text
The service supports creating, retrieving, and listing case document metadata. I kept storage behind reader/writer interfaces so the API is not coupled to Table Storage. The implementation uses Azure Table Storage locally through Azurite, with validation and correct HTTP status codes.
```

```text
The main tradeoff is the simple partition key, which is fine for the exercise but something I would revisit for production scale and query patterns. For production I would add authentication, authorisation, structured error responses, integration tests, observability, CI/CD quality gates, and secure configuration through managed identity or Key Vault.
```

## If They Pivot To Queue Or Functions

Say:

```text
The core design stays the same. If this needs asynchronous processing, I would return 202 Accepted from the HTTP endpoint and put a message on an Azure Storage Queue. If they prefer Azure Functions, the endpoint becomes an HTTP trigger and the background processor becomes a Queue trigger.
```

## One-Line Panic Memory

```text
POST validates and creates. GET by id looks up and returns 404 or 200. Table Storage needs PartitionKey and RowKey. Azurite uses UseDevelopmentStorage=true.
```
