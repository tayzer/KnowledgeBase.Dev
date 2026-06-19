# Azure Functions Panic Cheat Sheet

Function app = trigger-driven code. Most likely challenge: HTTP trigger, Queue trigger, or both.

## Mental Map

| Web API | Azure Functions |
|---|---|
| Endpoint/controller | Function method |
| Route | `HttpTrigger(..., Route = "...")` |
| `Results.Ok(x)` | `new OkObjectResult(x)` |
| `Results.NotFound()` | `new NotFoundResult()` |
| `Results.Created(loc, body)` | `new CreatedResult(loc, body)` |
| `appsettings.json` | `local.settings.json` locally |
| Background worker | Queue/Timer trigger |

## Create App

Visual Studio safest path:

```text
New project -> Azure Functions -> .NET 8 isolated -> HTTP trigger
```

CLI if `func` exists:

```powershell
func init CpsFunctions --worker-runtime dotnet-isolated --target-framework net8.0
func new --template "Http Trigger" --name CreateCaseDocument
func start
```

Local URL:

```text
http://localhost:7071/api/<route>
```

## local.settings.json

```json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated"
  }
}
```

## DI in Program.cs

```csharp
var builder = FunctionsApplication.CreateBuilder(args);

builder.ConfigureFunctionsWebApplication();

builder.Services.AddSingleton<InMemoryStore>();
builder.Services.AddSingleton<ICaseReader>(sp =>
    sp.GetRequiredService<InMemoryStore>());
builder.Services.AddSingleton<ICaseWriter>(sp =>
    sp.GetRequiredService<InMemoryStore>());

builder.Build().Run();
```

## DTOs

```csharp
public sealed record CreateCaseRequest(
    string? CaseUrn,
    string? DocumentType,
    string? Status,
    DateTimeOffset ReceivedAt);

public sealed record CaseResponse(
    Guid Id,
    string CaseUrn,
    string DocumentType,
    string Status,
    DateTimeOffset ReceivedAt);
```

## Function Class Shape

```csharp
public sealed class CaseFunctions
{
    private readonly ICaseReader _reader;
    private readonly ICaseWriter _writer;
    private readonly ILogger<CaseFunctions> _logger;

    public CaseFunctions(
        ICaseReader reader,
        ICaseWriter writer,
        ILogger<CaseFunctions> logger)
    {
        _reader = reader;
        _writer = writer;
        _logger = logger;
    }
}
```

## POST HTTP Function

```csharp
[Function("CreateCase")]
public async Task<IActionResult> CreateCase(
    [HttpTrigger(AuthorizationLevel.Function, "post", Route = "cases")]
    HttpRequest request,
    CancellationToken ct)
{
    var dto = await JsonSerializer.DeserializeAsync<CreateCaseRequest>(
        request.Body,
        cancellationToken: ct);

    if (dto is null)
    {
        return new BadRequestObjectResult("Request body is required.");
    }

    var error = Validate(dto);
    if (error is not null)
    {
        return new BadRequestObjectResult(error);
    }

    var item = new CaseRecord(
        Guid.NewGuid(),
        dto.CaseUrn!.Trim(),
        dto.DocumentType!.Trim(),
        dto.Status!.Trim(),
        dto.ReceivedAt);

    await _writer.AddAsync(item, ct);

    return new CreatedResult($"/api/cases/{item.Id}", ToResponse(item));
}
```

## GET by Id HTTP Function

```csharp
[Function("GetCaseById")]
public async Task<IActionResult> GetCaseById(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "cases/{id}")]
    HttpRequest request,
    string id,
    CancellationToken ct)
{
    if (!Guid.TryParse(id, out var caseId))
    {
        return new BadRequestObjectResult("Invalid id.");
    }

    var item = await _reader.GetByIdAsync(caseId, ct);

    return item is null
        ? new NotFoundResult()
        : new OkObjectResult(ToResponse(item));
}
```

## GET List Function

```csharp
[Function("ListCases")]
public async Task<IActionResult> ListCases(
    [HttpTrigger(AuthorizationLevel.Function, "get", Route = "cases")]
    HttpRequest request,
    CancellationToken ct)
{
    var status = request.Query["status"].ToString();

    if (string.IsNullOrWhiteSpace(status))
    {
        return new BadRequestObjectResult("Status is required.");
    }

    var items = await _reader.ListByStatusAsync(status, ct);
    return new OkObjectResult(items.Select(ToResponse));
}
```

## Queue Trigger

Use for background work.

```csharp
[Function("ProcessCaseMessage")]
public async Task Run(
    [QueueTrigger("case-events", Connection = "AzureWebJobsStorage")]
    string message,
    CancellationToken ct)
{
    var payload = JsonSerializer.Deserialize<CaseMessage>(message);

    if (payload is null)
    {
        _logger.LogWarning("Invalid queue message.");
        return;
    }

    _logger.LogInformation("Processing case {CaseId}.", payload.CaseId);

    await Task.CompletedTask;
}
```

## HTTP -> Queue

Return `202 Accepted` because work is queued, not complete.

```csharp
await queue.CreateIfNotExistsAsync(cancellationToken: ct);
await queue.SendMessageAsync(BinaryData.FromObjectAsJson(message), ct);

return new AcceptedResult(
    $"/api/cases/{caseId}",
    new { caseId, status = "Queued" });
```

## Validation Helper

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

    if (request.ReceivedAt > DateTimeOffset.UtcNow)
    {
        return "Received date cannot be in the future.";
    }

    return null;
}
```

## Panic Lines

```text
POST: deserialize -> validate -> create item -> save -> CreatedResult.
GET by id: parse id -> reader.GetByIdAsync -> null 404 -> found 200.
Queue: deserialize message -> validate -> idempotency check -> process.
Async work returns 202 Accepted, not 201 Created.
Use local.settings.json for AzureWebJobsStorage.
```

## Interview Lines

```text
The design is the same as a Web API; the entry point is just an HTTP trigger rather than a controller or Minimal API endpoint.
```

```text
I would use HTTP for synchronous request/response and a Queue trigger where eventual background processing is acceptable.
```

```text
For the timebox I would unit test validation and service logic. In a real project I would add host integration tests that start the Functions host, run against Azurite, call the HTTP endpoint, and assert the queue/table side effect.
```
