# Mock Challenge: REST Endpoint With Azure Table Storage and Azurite

  

Timebox: 75-90 minutes

  

Goal: Build a REST-style API that creates, retrieves, and lists case document records using Azure Table Storage locally through Azurite.

  

This mock is designed to practise:

  

- REST endpoint design

- Azure Table Storage

- Azurite/local storage

- Repository/reader/writer abstractions

- `201 Created`, `200 OK`, `400 Bad Request`, and `404 Not Found`

- Validation

- Clean C#/.NET structure

  

## Scenario

  

CPS needs a lightweight service to store metadata about case documents received by a digital service.

  

The API should allow a user to create a case document record, retrieve it by id, and list records by status.

  

## Functional Requirements

  

Build a REST API with these endpoints:

  

```http

POST /case-documents

GET /case-documents/{id}

GET /case-documents?status=Received

```

  

You can implement this as either:

  

- ASP.NET Core Minimal API

- ASP.NET Core controllers

- Azure Functions HTTP triggers

  

For this mock, Minimal API is the fastest route unless you specifically want Functions practice.

  

## Data Fields

  

A case document record has:

  

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

  

## Example Create Request

  

```http

POST http://localhost:5000/case-documents

Content-Type: application/json

  

{

  "caseUrn": "CPS-2026-001",

  "documentType": "WitnessStatement",

  "status": "Received",

  "receivedAt": "2026-06-17T09:30:00Z"

}

```

  

## Expected Create Response

  

```http

201 Created

Location: /case-documents/{id}

```

  

Example body:

  

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

- `status` is not one of the allowed statuses.

- `receivedAt` is in the future.

  

Return `404 Not Found` when:

  

- `GET /case-documents/{id}` is called with a valid id that does not exist.

  

## Non-Functional Requirements

  

Your solution should show:

  

- Clear separation between API and storage.

- Storage connection string from configuration.

- Use of Azure Table Storage through `Azure.Data.Tables`.

- Async methods.

- Cancellation tokens.

- Tests for validation or repository behaviour if time allows.

- Sensible lead-developer tradeoffs.

  

## Local Setup

  

Azurite must be running.

  

```powershell

azurite --location C:\tmp\azurite --silent --debug C:\tmp\azurite\debug.log

```

  

For an ASP.NET API, use `appsettings.Development.json`:

  

```json

{

  "Storage": {

    "ConnectionString": "UseDevelopmentStorage=true",

    "TableName": "CaseDocuments"

  }

}

```

  

Install the package:

  

```powershell

dotnet add package Azure.Data.Tables

```

  

## Suggested Project Shape

  

```text

CpsTableStorageMock/

  Program.cs

  Contracts/

    CreateCaseDocumentRequest.cs

    CaseDocumentResponse.cs

  Domain/

    CaseDocument.cs

    CaseDocumentStatus.cs

  Storage/

    CaseDocumentEntity.cs

    TableCaseDocumentRepository.cs

  Repositories/

    ICaseDocumentReader.cs

    ICaseDocumentWriter.cs

  Tests/

```

  

Keep it simpler if time is tight.

  

## Domain and DTOs

  

```csharp

public sealed record CaseDocument(

    Guid Id,

    string CaseUrn,

    string DocumentType,

    string Status,

    DateTimeOffset ReceivedAt);

```

  

```csharp

public sealed record CreateCaseDocumentRequest(

    string? CaseUrn,

    string? DocumentType,

    string? Status,

    DateTimeOffset ReceivedAt);

```

  

```csharp

public sealed record CaseDocumentResponse(

    Guid Id,

    string CaseUrn,

    string DocumentType,

    string Status,

    DateTimeOffset ReceivedAt);

```

  

Mapping:

  

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

  

## Reader and Writer Interfaces

  

```csharp

public interface ICaseDocumentReader

{

    Task<CaseDocument?> GetByIdAsync(

        Guid id,

        CancellationToken cancellationToken);

  

    Task<IReadOnlyList<CaseDocument>> ListByStatusAsync(

        string status,

        CancellationToken cancellationToken);

}

  

public interface ICaseDocumentWriter

{

    Task AddAsync(

        CaseDocument document,

        CancellationToken cancellationToken);

}

```

  

Interview wording:

  

```text

I am splitting reader and writer interfaces so endpoints depend only on the capability they need. The implementation can still be one Table Storage repository.

```

  

## Table Entity

  

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

  

Simple partition strategy for the mock:

  

```text

PartitionKey = "case-document"

RowKey = document id

```

  

Production note:

  

```text

For production, I would revisit partition key design based on query patterns and scale. For this exercise, a fixed partition keeps the implementation simple.

```

  

## Table Storage Repository

  

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

  

    public async Task AddAsync(

        CaseDocument document,

        CancellationToken cancellationToken)

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

  

        await _tableClient.AddEntityAsync(entity, cancellationToken);

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

  

## Dependency Injection

  

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

  

Interview wording:

  

```text

The Azure SDK client can be reused, so I register the TableClient once. The repository is scoped here as a safe default, and it stays stateless.

```

  

## Endpoint Implementation

  

### POST

  

```csharp

app.MapPost("/case-documents", async (

    CreateCaseDocumentRequest request,

    ICaseDocumentWriter writer,

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

  

    await writer.AddAsync(document, cancellationToken);

  

    return Results.Created(

        $"/case-documents/{document.Id}",

        ToResponse(document));

});

```

  

### GET by Id

  

```csharp

app.MapGet("/case-documents/{id:guid}", async (

    Guid id,

    ICaseDocumentReader reader,

    CancellationToken cancellationToken) =>

{

    var document = await reader.GetByIdAsync(id, cancellationToken);

  

    return document is null

        ? Results.NotFound()

        : Results.Ok(ToResponse(document));

});

```

  

### GET by Status

  

```csharp

app.MapGet("/case-documents", async (

    string status,

    ICaseDocumentReader reader,

    CancellationToken cancellationToken) =>

{

    if (string.IsNullOrWhiteSpace(status))

    {

        return Results.BadRequest("Status is required.");

    }

  

    var documents = await reader.ListByStatusAsync(status, cancellationToken);

  

    return Results.Ok(documents.Select(ToResponse));

});

```

  

## Validation Helper

  

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

    var allowedStatuses = new[]

    {

        "Received",

        "Processing",

        "Processed",

        "Rejected"

    };

  

    return allowedStatuses.Any(x =>

        string.Equals(x, status, StringComparison.OrdinalIgnoreCase));

}

```

  

## Acceptance Criteria

  

You are done when:

  

- Valid `POST /case-documents` returns `201 Created`.

- The `Location` header/body points to the new resource.

- `GET /case-documents/{id}` returns the created record.

- Unknown id returns `404 Not Found`.

- `GET /case-documents?status=Received` returns matching records.

- Invalid requests return `400 Bad Request`.

- Records are stored in Azurite Table Storage.

  

## Tests To Add If Time Allows

  

Prioritise validation tests:

  

- Missing case URN returns validation error.

- Invalid status returns validation error.

- Future received date returns validation error.

- Valid request passes validation.

  

Then repository tests if you have time:

  

- Add then get by id.

- Get unknown id returns null.

- List by status returns matching records.

  

## Stretch Goals

  

- Add duplicate detection by `caseUrn` and `documentType`.

- Add pagination to list endpoint.

- Add `PUT /case-documents/{id}/status`.

- Add endpoint tests with `WebApplicationFactory`.

- Add OpenAPI metadata.

- Add structured `ProblemDetails` responses.

  

## Production Talking Points

  

Say:

  

```text

For production I would revisit the Table Storage partition strategy around query patterns, add authentication and authorisation, use managed identity where possible, add integration tests, and monitor storage failures through Application Insights or OpenTelemetry.

```

  

Also mention:

  

- Table Storage is not relational SQL.

- Query design depends heavily on partition and row keys.

- Avoid unbounded scans for high-volume data.

- Use app settings/Key Vault for configuration.

- Add retry policies for transient storage failures.

  

## Panic Card

  

Create:

  

```csharp

await writer.AddAsync(document, cancellationToken);

return Results.Created($"/case-documents/{document.Id}", ToResponse(document));

```

  

Get by id:

  

```csharp

var document = await reader.GetByIdAsync(id, cancellationToken);

return document is null ? Results.NotFound() : Results.Ok(ToResponse(document));

```

  

Table get:

  

```csharp

try

{

    var response = await tableClient.GetEntityAsync<CaseDocumentEntity>(

        "case-document",

        id.ToString(),

        cancellationToken: cancellationToken);

  

    return ToDomain(response.Value);

}

catch (RequestFailedException ex) when (ex.Status == 404)

{

    return null;

}

```

  

Final explanation:

  

```text

The API exposes a small REST surface for case document metadata. Storage is behind reader/writer interfaces, and the implementation uses Azure Table Storage through Azurite locally. I kept the design compact for the timebox while leaving clear extension points for validation, pagination, authentication, and production storage configuration.

```