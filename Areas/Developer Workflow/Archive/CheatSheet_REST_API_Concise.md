# REST API Panic Cheat Sheet

Use this for a .NET 8 Minimal API live challenge.

## Status Codes

| Scenario | Return |
|---|---|
| Create success | `201 Created` |
| Get/list success | `200 OK` |
| Invalid input | `400 Bad Request` |
| Missing item | `404 Not Found` |
| Accepted async work | `202 Accepted` |
| No content update/delete | `204 No Content` |

## Minimal API Skeleton

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddSingleton<InMemoryStore>();
builder.Services.AddSingleton<ICaseReader>(sp =>
    sp.GetRequiredService<InMemoryStore>());
builder.Services.AddSingleton<ICaseWriter>(sp =>
    sp.GetRequiredService<InMemoryStore>());

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapPost("/cases", CreateCase);
app.MapGet("/cases/{id:guid}", GetCaseById);
app.MapGet("/cases", ListCases);

app.Run();
```

## DTOs / Domain

```csharp
public sealed record CreateCaseRequest(
    string? CaseUrn,
    string? DocumentType,
    string? Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseRecord(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseResponse(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);
```

```csharp
static CaseResponse ToResponse(CaseRecord item) =>
    new(item.Id, item.CaseUrn, item.DocumentType, item.Status, item.ReceivedAt);
```

## Interfaces

```csharp
public interface ICaseReader
{
    Task<CaseRecord?> GetByIdAsync(Guid id, CancellationToken ct);
    Task<IReadOnlyList<CaseRecord>> ListByStatusAsync(string status, CancellationToken ct);
}

public interface ICaseWriter
{
    Task AddAsync(CaseRecord item, CancellationToken ct);
}
```

## In-Memory Store

```csharp
public sealed class InMemoryStore : ICaseReader, ICaseWriter
{
    private readonly ConcurrentDictionary<Guid, CaseRecord> _items = new();

    public Task AddAsync(CaseRecord item, CancellationToken ct)
    {
        _items[item.Id] = item;
        return Task.CompletedTask;
    }

    public Task<CaseRecord?> GetByIdAsync(Guid id, CancellationToken ct)
    {
        _items.TryGetValue(id, out var item);
        return Task.FromResult(item);
    }

    public Task<IReadOnlyList<CaseRecord>> ListByStatusAsync(string status, CancellationToken ct)
    {
        var results = _items.Values
            .Where(x => string.Equals(x.Status, status, StringComparison.OrdinalIgnoreCase))
            .ToList();

        return Task.FromResult<IReadOnlyList<CaseRecord>>(results);
    }
}
```

## POST Create

```csharp
static async Task<IResult> CreateCase(
    CreateCaseRequest request,
    ICaseWriter writer,
    CancellationToken ct)
{
    var error = Validate(request);
    if (error is not null)
    {
        return Results.BadRequest(error);
    }

    var item = new CaseRecord(
        Guid.NewGuid(),
        request.CaseUrn!.Trim(),
        request.DocumentType!.Trim(),
        request.Status!.Trim(),
        request.ReceivedAt);

    await writer.AddAsync(item, ct);

    return Results.Created($"/cases/{item.Id}", ToResponse(item));
}
```

## GET by Id

```csharp
static async Task<IResult> GetCaseById(
    Guid id,
    ICaseReader reader,
    CancellationToken ct)
{
    var item = await reader.GetByIdAsync(id, ct);

    return item is null
        ? Results.NotFound()
        : Results.Ok(ToResponse(item));
}
```

Memory hook:

```text
id from route -> reader.GetByIdAsync -> null 404 -> found 200.
```

## GET List by Query

```csharp
static async Task<IResult> ListCases(
    string status,
    ICaseReader reader,
    CancellationToken ct)
{
    if (string.IsNullOrWhiteSpace(status))
    {
        return Results.BadRequest("Status is required.");
    }

    var items = await reader.ListByStatusAsync(status, ct);
    return Results.Ok(items.Select(ToResponse));
}
```

Request:

```http
GET /cases?status=Received
```

## Validation

```csharp
static string? Validate(CreateCaseRequest request)
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
    string[] allowed = ["Received", "Processing", "Processed", "Rejected"];

    return allowed.Any(x =>
        string.Equals(x, status, StringComparison.OrdinalIgnoreCase));
}
```

## Results.Created

```csharp
return Results.Created($"/cases/{item.Id}", ToResponse(item));
```

Means:

```text
201 Created
Location: /cases/{id}
Body: response DTO
```

## CreatedAtRoute Alternative

```csharp
app.MapGet("/cases/{id:guid}", GetCaseById)
   .WithName("GetCaseById");

return Results.CreatedAtRoute(
    "GetCaseById",
    new { id = item.Id },
    ToResponse(item));
```

Simple `Results.Created(...)` is fine for the challenge.

## DI Lifetimes

| Thing | Lifetime |
|---|---|
| In-memory store | Singleton |
| EF Core repository | Scoped |
| Azure SDK client | Singleton |
| Stateless repository | Scoped safe default |

Never inject scoped into singleton.

## Table Storage DI

```csharp
builder.Services.AddSingleton(_ =>
    new TableClient("UseDevelopmentStorage=true", "Cases"));

builder.Services.AddScoped<TableCaseRepository>();
builder.Services.AddScoped<ICaseReader>(sp =>
    sp.GetRequiredService<TableCaseRepository>());
builder.Services.AddScoped<ICaseWriter>(sp =>
    sp.GetRequiredService<TableCaseRepository>());
```

## Tests Worth Writing

```csharp
[Fact]
public void Validate_ReturnsError_WhenCaseUrnMissing()
{
    var request = new CreateCaseRequest("", "Doc", "Received", DateTimeOffset.UtcNow);

    var error = Validate(request);

    Assert.Equal("Case URN is required.", error);
}
```

```csharp
[Fact]
public async Task GetByIdAsync_ReturnsNull_WhenMissing()
{
    var store = new InMemoryStore();

    var result = await store.GetByIdAsync(Guid.NewGuid(), CancellationToken.None);

    Assert.Null(result);
}
```

## Panic Lines

```text
POST = validate -> create -> save -> 201 Created.
GET by id = id -> lookup -> null 404 -> found 200.
GET list = query param -> validate -> lookup -> 200 list.
Reader/writer split shows interface segregation.
In-memory singleton is fine for challenge if thread-safe.
Storage behind interface lets you swap to Azurite/Table later.
```

## Final Summary Script

```text
The API supports create, retrieve by id, and list by status. I kept storage behind reader/writer interfaces so the API is not coupled to the persistence implementation. I added validation and correct HTTP status codes. In production I would add authentication, structured problem details, integration tests, CI/CD quality gates, health checks, monitoring, and secure configuration.
```
